open General.Abbr


module J = struct
  type t = Yojson.Basic.json
  type a = string * t

  let to_string = Yojson.Basic.pretty_to_string

  let null = `Null

  let (str: string -> t) = fun x ->
    `String x

  let (li: t list -> t) = fun x ->
    `List x

  let (bo: bool -> t) = fun x ->
    `Bool x

  let (opt: t option -> t) = function
    | None -> null
    | Some x -> x

  let (obj: string -> a list -> t) = fun kind attributes ->
    `Assoc (("__class__", str kind)::attributes)
end


(*BISECT-IGNORE-BEGIN*)
let warn s v =
  StdErr.print "WARNING: %s\n" s;
  v
(*BISECT-IGNORE-END*)


module Name: sig
  val of_string: string -> J.a
  val of_string_loc: string Asttypes.loc -> J.a
  val of_ident: Ident.t -> J.a
end = struct
  let of_string s =
    ("name", J.str s)

  let of_string_loc {Asttypes.txt; loc=_} =
    of_string txt

  let of_ident id =
    id
    |> Ident.name
    |> of_string
end


module Hidden: sig
  val default: J.a

  module OfTypedtree: sig
    open Typedtree
    val attributes: attributes -> J.a
  end
end = struct
  let of_bool hidden =
    ("hidden", J.bo hidden)

  let default = of_bool false

  module OfTypedtree = struct
    let attributes attributes =
      attributes
      |> Li.there_exists ~f:(fun ({Asttypes.txt; loc=_}, payload) ->
        txt = "autodoc.hide" && payload = Parsetree.PStr []
      )
      |> of_bool
  end
end


module Doc: sig
  val empty: J.a
  val merge: J.a list -> J.a

  module OfTypedtree: sig
    open Typedtree
    val attributes: attributes -> J.a
    val module_type: module_type -> J.a
    val module_type_option: module_type option -> J.a
  end

  module OfTypes: sig
    open Types
    val module_type_option: Env.t -> module_type option -> J.a
  end
end = struct
  let of_list xs =
    ("doc", J.li xs)

  let empty = of_list []

  let merge xs =
    xs
    |> Li.flat_map ~f:(function
      | (_, `List x) ->
        x
      | _ -> (*BISECT-IGNORE*)
        Exn.failure "Doc.merge"
    )
    |> of_list

  let filter_attributes attributes =
    attributes
    |> Li.filter_map ~f:(fun ({Asttypes.txt; loc=_}, payload) ->
      Opt.some_if (txt = "ocaml.doc") (lazy Parsetree.(
        match payload with
          | PStr [{pstr_desc=Pstr_eval ({pexp_desc=Pexp_constant (Parsetree.Pconst_string (s, _)); _}, _); _}] ->
            J.str s
          | _ -> (*BISECT-IGNORE*)
            Exn.failure "Doc.of_attribute"
      ))
    )

  module OfTypes = struct
    let rec module_type_option env = function
      | None -> (*BISECT-IGNORE*)
        warn "Doc.OfTypes.module_type_option: None" []
      | Some mod_typ ->
        module_type env mod_typ

    and modtype_declaration env {Types.mtd_type; mtd_attributes; mtd_loc=_} =
        (filter_attributes mtd_attributes) @ (module_type_option env mtd_type)

    and module_type env = function
      | Types.Mty_ident path ->
        Env.find_modtype path env
        |> modtype_declaration env
      | Types.Mty_signature _ ->
        [] (* Empty on purpose *)
      | Types.Mty_functor (_, _, contents) ->
        module_type env contents
      | Types.Mty_alias (_, _) -> (*BISECT-IGNORE*)
        warn "Doc.OfTypes.module_type: Mty_alias" []

    let module_type_option env mod_typ =
      mod_typ
      |> module_type_option env
      |> of_list
  end

  module OfTypedtree = struct
    let attributes attributes =
      attributes
      |> filter_attributes
      |> of_list

    let rec module_type {Typedtree.mty_desc; mty_type=_; mty_env; mty_loc=_; mty_attributes=_} =
      match mty_desc with
        | Typedtree.Tmty_signature _ ->
          empty
        | Typedtree.Tmty_ident (path, _) ->
          Env.find_modtype path mty_env
          |> OfTypes.modtype_declaration mty_env
          |> of_list
        | Typedtree.Tmty_functor (_, _, _, contents) ->
          module_type contents
        | Typedtree.Tmty_with (_, _) -> (*BISECT-IGNORE*)
          warn "Doc.OfTypedtree.module_type: Tmty_with" empty
        | Typedtree.Tmty_typeof _ -> (*BISECT-IGNORE*)
          warn "Doc.OfTypedtree.module_type: Tmty_typeof" empty
        | Typedtree.Tmty_alias (_, _) -> (*BISECT-IGNORE*)
          warn "Doc.OfTypedtree.module_type: Tmty_alias" empty

    let module_type_option = Opt.value_map ~f:module_type ~def:empty
  end
end


module FloatingDoc: sig
  val of_attribute_payload: Parsetree.payload -> J.t
end = struct
  let of_attribute_payload = Parsetree.(function
    | PStr [{pstr_desc=Pstr_eval ({pexp_desc=Pexp_constant (Parsetree.Pconst_string (s, _)); _}, _); _}] ->
      J.obj "signature_item:floating_documentation" [
        Hidden.default;
        ("text", J.str s);
      ]
    | _ -> (*BISECT-IGNORE*)
      Exn.failure "FloatingDoc.of_attribute_payload"
  )
end


let string_of_type_expr t =
  Printtyp.reset ();
  Printtyp.type_expr OCamlStandard.Format.str_formatter t;
  OCamlStandard.Format.flush_str_formatter ()

let string_of_core_type {Typedtree.ctyp_desc=_; ctyp_type; ctyp_env=_; ctyp_loc=_; ctyp_attributes=_} =
  string_of_type_expr ctyp_type

let string_of_record labels =
  labels
  |> Li.map ~f:(fun {Typedtree.ld_id=_; ld_name={Asttypes.txt; loc=_}; ld_mutable; ld_type; ld_loc=_; ld_attributes=_} ->
    Frmt.apply "%s%s: %s" (if ld_mutable = Asttypes.Mutable then "mutable " else "") txt (string_of_core_type ld_type)
  )
  |> StrLi.concat ~sep:"; "
  |> Frmt.apply "{%s}"

let string_of_tuple elements =
  let format =
    match elements with
      | [{Typedtree.ctyp_type={Types.desc=Types.Ttuple _; _}; _}] ->
        Frmt.of_string "(%s)"
      | _ ->
        Frmt.of_string "%s"
  in
  elements
  |> Li.map ~f:string_of_core_type
  |> StrLi.concat ~sep:" * "
  |> Frmt.apply format


module Payload: sig
  module OfTypedtree: sig
    open Typedtree
    val constructor_arguments: constructor_arguments -> J.a
  end
end = struct
  let of_string s =
    ("payload", J.str s)

  let empty = ("payload", J.null)

  module OfTypedtree = struct
    let constructor_arguments = function
      | Typedtree.Cstr_tuple [] ->
        empty
      | Typedtree.Cstr_tuple elements ->
        elements
        |> string_of_tuple
        |> of_string
      | Typedtree.Cstr_record declarations ->
        declarations
        |> string_of_record
        |> of_string
  end
end


module RecordLabels: sig
  module OfTypedtree: sig
    open Typedtree
    val constructor_arguments: constructor_arguments -> J.a
    val type_kind: type_kind -> J.a
  end

  module OfTypes: sig
    open Types
    val type_kind: type_kind -> J.a
  end
end = struct
  let of_list xs =
    ("labels", J.li xs)

  let empty = of_list []

  module OfTypedtree = struct
    let label_declarations declarations =
        declarations
        |> Li.map ~f:(fun {Typedtree.ld_id=_; ld_name; ld_mutable=_; ld_type=_; ld_loc=_; ld_attributes} ->
          J.obj "record_label" [
            Name.of_string_loc ld_name;
            Doc.OfTypedtree.attributes ld_attributes;
          ]
        )

    let constructor_arguments = function
      | Typedtree.Cstr_tuple _ ->
        []
      | Typedtree.Cstr_record declarations ->
        label_declarations declarations

    let type_kind = function
      | Typedtree.Ttype_abstract ->
        empty
      | Typedtree.Ttype_variant declarations ->
        declarations
        |> Li.flat_map ~f:(fun {Typedtree.cd_id=_; cd_name=_; cd_args; cd_res=_; cd_loc=_; cd_attributes=_} ->
          constructor_arguments cd_args
        )
        |> of_list
      | Typedtree.Ttype_record declarations ->
        label_declarations declarations
        |> of_list
      | Typedtree.Ttype_open ->
        empty

    let constructor_arguments = of_list % constructor_arguments
  end

  module OfTypes = struct
    let type_kind = function
      | Types.Type_abstract ->
        empty
      | Types.Type_variant _ -> (*BISECT-IGNORE*)
        warn "RecordLabels.OfTypes.type_kind: Type_variant" empty
      | Types.Type_record _ -> (*BISECT-IGNORE*)
        warn "RecordLabels.OfTypes.type_kind: Type_record" empty
      | Types.Type_open -> (*BISECT-IGNORE*)
        warn "RecordLabels.OfTypes.type_kind: Type_open" empty
  end
end


module TypeParameters: sig
  module OfTypedtree: sig
    open Typedtree
    val type_parameters: (core_type * Asttypes.variance) list -> J.a
  end

  module OfTypes: sig
    open Types
    val type_exprs: type_expr list -> J.a
  end
end = struct
  let of_string s =
    ("parameters", J.str s)

  let empty = ("parameters", J.null)

  let string_of_type_parameter (t, v) =
    let variance = match v with
      | Asttypes.Covariant ->
        "+"
      | Asttypes.Contravariant ->
        "-"
      | Asttypes.Invariant ->
        ""
    in
    Frmt.apply "%s%s" variance (string_of_core_type t)

  module OfTypedtree = struct
    let type_parameters = function
      | [] ->
        empty
      | [type_parameter] ->
        type_parameter
        |> string_of_type_parameter
        |> of_string
      | type_parameters ->
        type_parameters
        |> Li.map ~f:string_of_type_parameter
        |> StrLi.concat ~sep:", "
        |> Frmt.apply "(%s)"
        |> of_string
  end

  module OfTypes = struct
    let type_exprs = function
      | [] ->
        empty
      | _ -> (*BISECT-IGNORE*)
        warn "TypeParameters.OfTypes.type_exprs" empty
  end
end


module TypePrivate: sig
  val of_private_flag: Asttypes.private_flag -> J.a
end = struct
  let bool_of_private_flag = function
    | Asttypes.Private -> true
    | Asttypes.Public -> false

  let of_private_flag f =
    ("private", f |> bool_of_private_flag |> J.bo)
end

module TypeManifest: sig
  module OfTypedtree: sig
    open Typedtree
    val core_type_option: core_type option -> J.a
  end

  module OfTypes: sig
    open Types
    val type_expr_option: type_expr option -> J.a
  end
end = struct
  let of_string_option s =
      ("manifest", s |> Opt.map ~f:J.str |> J.opt)

  module OfTypedtree = struct
    let core_type_option t =
      t
      |> Opt.map ~f:string_of_core_type
      |> of_string_option
  end

  module OfTypes = struct
    let type_expr_option t =
      t
      |> Opt.map ~f:string_of_type_expr
      |> of_string_option
  end
end


module TypeConstructors: sig
  module OfTypedtree: sig
    open Typedtree
    val type_kind: type_kind -> J.a
  end

  module OfTypes: sig
    open Types
    val type_kind: type_kind -> J.a
  end
end = struct
  let of_list xs =
    ("constructors", J.li xs)

  let empty = of_list []

  module OfTypedtree = struct
    let type_kind = function
      | Typedtree.Ttype_abstract ->
        empty
      | Typedtree.Ttype_variant declarations ->
        declarations
        |> Li.map ~f:(fun {Typedtree.cd_id=_; cd_name; cd_args; cd_res=_; cd_loc=_; cd_attributes} ->
          J.obj "type_constructor" [
            Name.of_string_loc cd_name;
            Doc.OfTypedtree.attributes cd_attributes;
            Payload.OfTypedtree.constructor_arguments cd_args;
          ]
        )
        |> of_list
      | Typedtree.Ttype_record _ ->
        empty
      | Typedtree.Ttype_open ->
        empty
  end

  module OfTypes = struct
    let type_kind = function
      | Types.Type_abstract ->
        empty
      | Types.Type_variant _ -> (*BISECT-IGNORE*)
        warn "TypeConstructors.of_types_type_kind: Type_variant" empty
      | Types.Type_record _ -> (*BISECT-IGNORE*)
        warn "TypeConstructors.of_types_type_kind: Type_record" empty
      | Types.Type_open -> (*BISECT-IGNORE*)
        warn "TypeConstructors.of_types_type_kind: Type_open" empty
  end
end


module TypeKind: sig
  module OfTypedtree: sig
    open Typedtree
    val type_kind: type_kind -> J.a
  end

  module OfTypes: sig
    open Types
    val type_kind: type_kind -> J.a
  end
end = struct
  let of_string s =
    ("kind", J.str s)

  let empty = ("kind", J.null)

  module OfTypedtree = struct
    let type_kind = function
      | Typedtree.Ttype_abstract ->
        empty
      | Typedtree.Ttype_variant declarations ->
        declarations
        |> Li.map ~f:(fun {Typedtree.cd_id=_; cd_name={Asttypes.txt; loc=_}; cd_args; cd_res=_; cd_loc=_; cd_attributes=_} ->
          let payload =
            match cd_args with
              | Typedtree.Cstr_tuple [] ->
                ""
              | Typedtree.Cstr_tuple elements ->
                elements
                |> string_of_tuple
                |> Frmt.apply " of %s"
              | Typedtree.Cstr_record declarations ->
                declarations
                |> string_of_record
                |> Frmt.apply " of %s"
          in
          Frmt.apply "%s%s" txt payload
        )
        |> StrLi.concat ~sep:" | "
        |> of_string
      | Typedtree.Ttype_record declarations ->
        declarations
        |> string_of_record
        |> of_string
      | Typedtree.Ttype_open ->
        of_string ".."
  end

  module OfTypes = struct
    let type_kind = function
      | Types.Type_abstract ->
        empty
      | Types.Type_variant _ -> (*BISECT-IGNORE*)
        warn "TypeKind.OfTypes.type_kind: Type_variant" empty
      | Types.Type_record _ -> (*BISECT-IGNORE*)
        warn "TypeKind.OfTypes.type_kind: Type_record" empty
      | Types.Type_open -> (*BISECT-IGNORE*)
        warn "TypeKind.OfTypes.type_kind: Type_open" empty
  end
end


module Type: sig
  module OfTypedtree: sig
    open Typedtree
    val type_declaration: type_declaration -> J.t
  end

  module OfTypes: sig
    open Types
    val type_declaration: Ident.t -> type_declaration -> J.t
  end
end = struct
  module OfTypedtree = struct
    let type_declaration {Typedtree.typ_id=_; typ_name; typ_params; typ_type=_; typ_cstrs=_; typ_kind; typ_private; typ_manifest; typ_loc=_; typ_attributes} =
      J.obj "signature_item:type" [
        Name.of_string_loc typ_name;
        Hidden.OfTypedtree.attributes typ_attributes;
        Doc.OfTypedtree.attributes typ_attributes;
        TypeParameters.OfTypedtree.type_parameters typ_params;
        TypePrivate.of_private_flag typ_private;
        TypeManifest.OfTypedtree.core_type_option typ_manifest;
        TypeKind.OfTypedtree.type_kind typ_kind;
        TypeConstructors.OfTypedtree.type_kind typ_kind;
        RecordLabels.OfTypedtree.type_kind typ_kind;
      ]
  end

  module OfTypes = struct
    let type_declaration id {Types.type_params; type_arity=_; type_kind; type_private; type_manifest; type_variance=_; type_newtype_level=_; type_loc=_; type_attributes; type_immediate=_; type_unboxed=_} =
      J.obj "signature_item:type" [
        Name.of_ident id;
        Hidden.OfTypedtree.attributes type_attributes;
        Doc.OfTypedtree.attributes type_attributes;
        TypeParameters.OfTypes.type_exprs type_params; (* @todo Variances *)
        TypePrivate.of_private_flag type_private;
        TypeManifest.OfTypes.type_expr_option type_manifest;
        TypeKind.OfTypes.type_kind type_kind;
        TypeConstructors.OfTypes.type_kind type_kind;
        RecordLabels.OfTypes.type_kind type_kind;
      ]
  end
end


module Exception: sig
  module OfTypedtree: sig
    open Typedtree
    val extension_constructor: extension_constructor -> J.t
  end
end = struct
  module OfTypedtree = struct
    let extension_constructor {Typedtree.ext_id=_; ext_name; ext_type=_; ext_kind; ext_loc=_; ext_attributes} =
      let arguments =
        match ext_kind with
          | Typedtree.Text_decl (arguments, _) ->
            arguments
          | Typedtree.Text_rebind (_, _) -> (*BISECT-IGNORE*)
            Exn.failure "exception_: ext_kind=Text_rebind"
      in
      J.obj "signature_item:exception" [
        Name.of_string_loc ext_name;
        Hidden.OfTypedtree.attributes ext_attributes;
        Doc.OfTypedtree.attributes ext_attributes;
        Payload.OfTypedtree.constructor_arguments arguments;
        RecordLabels.OfTypedtree.constructor_arguments arguments;
      ]
  end
end


module Value: sig
  module OfTypedtree: sig
    open Typedtree
    val value_description: value_description -> J.t
  end
end = struct
  module OfTypedtree = struct
    let value_description {Typedtree.val_id=_; val_name; val_desc; val_val=_; val_prim=_; val_loc=_; val_attributes} =
      (* @todo let format =
        Opt.some_if'
          (Oprint.parenthesized_ident (Ident.name val_id))
          (Frmt.of_string "(%s)") (* This is not strictly correct for ( * ) but it's prettier for everything else. *)
      in *)
      J.obj "signature_item:value" [
        Name.of_string_loc val_name;
        Hidden.OfTypedtree.attributes val_attributes;
        Doc.OfTypedtree.attributes val_attributes;
        ("type", val_desc |> string_of_core_type |> J.str);
      ]
  end
end


module ContentsFrom: sig
  val default: J.a

  module OfTypedtree: sig
    open Typedtree
    val module_type: module_type -> J.a
    val module_type_option: module_type option -> J.a
  end

  module OfTypes: sig
    open Types
    val module_type: Env.t -> module_type -> J.a
    val module_type_option: Env.t -> module_type option -> J.a
  end
end = struct
  let of_string s =
    ("contents_from", J.str s)

  let default = ("contents_from", J.null)

  module OfTypedtree = struct
    let rec module_type {Typedtree.mty_desc; mty_type=_; mty_env=_; mty_loc=_; mty_attributes=_} =
      match mty_desc with
        | Typedtree.Tmty_signature _ ->
          default
        | Typedtree.Tmty_ident (path, _) ->
          path
          |> Path.name
          |> of_string
        | Typedtree.Tmty_functor (_, _, _, contents) ->
          module_type contents
        | Typedtree.Tmty_with (_, _) -> (*BISECT-IGNORE*)
          warn "ContentsFrom.OfTypedtree.module_type: Tmty_with" default
        | Typedtree.Tmty_typeof _ -> (*BISECT-IGNORE*)
          warn "ContentsFrom.OfTypedtree.module_type: Tmty_typeof" default
        | Typedtree.Tmty_alias (_, _) -> (*BISECT-IGNORE*)
          warn "ContentsFrom.OfTypedtree.module_type: Tmty_alias" default

    let module_type_option = Opt.value_map ~f:module_type ~def:default
  end

  module OfTypes = struct
    let module_type _env = function
      | Types.Mty_ident _ -> (*BISECT-IGNORE*)
        warn "ContentsFrom.OfTypes.module_type: Mty_ident" default
      | Types.Mty_signature _ ->
        default
      | Types.Mty_functor (_, _, _) -> (*BISECT-IGNORE*)
        warn "ContentsFrom.OfTypes.module_type: Mty_functor" default
      | Types.Mty_alias (_, _) -> (*BISECT-IGNORE*)
        warn "ContentsFrom.OfTypes.module_type: Mty_alias" default

    let module_type_option env = Opt.value_map ~f:(module_type env) ~def:default
  end
end


module rec FunctorParameters: sig
  val empty: J.a

  module OfTypedtree: sig
    open Typedtree
    val module_type: module_type -> J.a
    val module_type_option: module_type option -> J.a
  end
end = struct
  let of_list contents =
    ("functor_parameters", J.li contents)

  let empty = of_list []

  module OfTypes = struct
    let modtype_declaration env {Types.mtd_type; mtd_attributes=_; mtd_loc=_} =
      let rec aux = function
          | None -> (*BISECT-IGNORE*)
            warn "FunctorParameters.OfTypes.modtype_declaration: None" []
          | Some Types.Mty_ident path ->
            let {Types.mtd_type; mtd_attributes=_; mtd_loc=_} = Env.find_modtype path env in
            aux mtd_type
          | Some Types.Mty_signature _ ->
            [] (* Empty on purpose *)
          | Some Types.Mty_functor (parameter_name, parameter_type, contents) -> (*BISECT-IGNORE*)
            let parameter = J.obj "functor_parameter" [
              Name.of_ident parameter_name;
              (* of_module_type_option parameter_type; *)
              empty;
              Doc.OfTypes.module_type_option env parameter_type;
              ContentsFrom.OfTypes.module_type_option env parameter_type;
              Contents.OfTypes.module_type_option env parameter_type;
            ] in
            parameter::(aux (Some contents))
          | Some Types.Mty_alias (_, _) -> (*BISECT-IGNORE*)
            warn "FunctorParameters.OfTypes.modtype_declaration: Some Mty_alias" []
      in
      aux mtd_type
  end

  module OfTypedtree = struct
    let rec module_type t =
      let rec aux {Typedtree.mty_desc; mty_type=_; mty_env; mty_loc=_; mty_attributes=_} =
        match mty_desc with
          | Typedtree.Tmty_signature _ ->
            [] (* Empty on purpose *)
          | Typedtree.Tmty_ident (path, _) ->
            Env.find_modtype path mty_env
            |> OfTypes.modtype_declaration mty_env
          | Typedtree.Tmty_functor (_, parameter_name, parameter_type, contents) ->
            let parameter = J.obj "functor_parameter" [
              Name.of_string_loc parameter_name;
              module_type_option parameter_type;
              Doc.OfTypedtree.module_type_option parameter_type;
              ContentsFrom.OfTypedtree.module_type_option parameter_type;
              Contents.OfTypedtree.module_type_option parameter_type;
            ] in
            parameter::(aux contents)
          | Typedtree.Tmty_with (_, _) -> (*BISECT-IGNORE*)
            warn "FunctorParameters.OfTypedtree.module_type: Tmty_with" []
          | Typedtree.Tmty_typeof _ -> (*BISECT-IGNORE*)
            warn "FunctorParameters.OfTypedtree.module_type: Tmty_typeof" []
          | Typedtree.Tmty_alias (_, _) -> (*BISECT-IGNORE*)
            warn "FunctorParameters.OfTypedtree.module_type: Tmty_alias" []
      in
      aux t
      |> of_list

    and module_type_option = Opt.value_map ~f:module_type ~def:empty
  end
end

and Contents: sig
  module OfTypedtree: sig
    open Typedtree
    val signature: signature -> J.a
    val module_type: module_type -> J.a
    val module_type_option: module_type option -> J.a
  end

  module OfTypes: sig
    open Types
    val module_type_option: Env.t -> module_type option -> J.a
  end
end = struct
  let of_list contents =
    ("contents", J.li contents)

  let empty = of_list []

  module OfTypes = struct
    let rec module_type_option env = function
      | None -> (*BISECT-IGNORE*)
        warn "Contents.OfTypes.module_type_option: None" empty
      | Some Types.Mty_ident path ->
        let {Types.mtd_type; mtd_attributes=_; mtd_loc=_} = Env.find_modtype path env in
        module_type_option env mtd_type
      | Some Types.Mty_signature items ->
        items
        |> Li.map ~f:(function
          | Types.Sig_value (_, _) -> (*BISECT-IGNORE*)
            warn "Contents.OfTypes.module_type_option: Sig_value" J.null
          | Types.Sig_type (id, declaration, _) ->
            Type.OfTypes.type_declaration id declaration
          | Types.Sig_typext (_, _, _) -> (*BISECT-IGNORE*)
            warn "Contents.OfTypes.module_type_option: Sig_typext" J.null
          | Types.Sig_module (_, _, _) -> (*BISECT-IGNORE*)
            warn "Contents.OfTypes.module_type_option: Sig_module" J.null
          | Types.Sig_modtype (_, _) -> (*BISECT-IGNORE*)
            warn "Contents.OfTypes.module_type_option: Sig_modtype" J.null
          | Types.Sig_class (_, _, _) -> (*BISECT-IGNORE*)
            warn "Contents.OfTypes.module_type_option: Sig_class" J.null
          | Types.Sig_class_type (_, _, _) -> (*BISECT-IGNORE*)
            warn "Contents.OfTypes.module_type_option: Sig_class_type" J.null
        )
        |> of_list
      | Some Types.Mty_functor (_, _, contents) ->
        module_type_option env (Some contents)
      | Some Types.Mty_alias (_, _) -> (*BISECT-IGNORE*)
        warn "Contents.OfTypes.module_type_option: Some Mty_alias" empty

    let modtype_declaration env {Types.mtd_type; mtd_attributes=_; mtd_loc=_} =
      module_type_option env mtd_type
  end

  module OfTypedtree = struct
    let signature {Typedtree.sig_items; sig_type=_; sig_final_env=_} =
      sig_items
      |> Li.flat_map ~f:(fun {Typedtree.sig_desc; sig_env=_; sig_loc=_} ->
        match sig_desc with
          | Typedtree.Tsig_attribute ({Asttypes.txt="ocaml.text"; loc=_}, payload) ->
            [FloatingDoc.of_attribute_payload payload]
          | Typedtree.Tsig_attribute _ ->
            [] (* Empty on purpose *)
          | Typedtree.Tsig_modtype declaration ->
            [ModuleType.OfTypedtree.module_type_declaration declaration]
          | Typedtree.Tsig_value description ->
            [Value.OfTypedtree.value_description description]
          | Typedtree.Tsig_module declaration ->
            [Module.OfTypedtree.module_declaration declaration]
          | Typedtree.Tsig_include description ->
            [Include.OfTypedtree.include_description description]
          | Typedtree.Tsig_type (_, declarations) ->
            declarations
            |> Li.map ~f:Type.OfTypedtree.type_declaration
          | Typedtree.Tsig_typext _ -> (*BISECT-IGNORE*)
            warn "Contents.signature: Typedtree.Tsig_typext" []
          | Typedtree.Tsig_exception description ->
            [Exception.OfTypedtree.extension_constructor description]
          | Typedtree.Tsig_recmodule _ -> (*BISECT-IGNORE*)
            warn "Contents.signature: Typedtree.Tsig_recmodule" []
          | Typedtree.Tsig_open _ -> (*BISECT-IGNORE*)
            warn "Contents.signature: Typedtree.Tsig_open" []
          | Typedtree.Tsig_class _ -> (*BISECT-IGNORE*)
            warn "Contents.signature: Typedtree.Tsig_class" []
          | Typedtree.Tsig_class_type _ -> (*BISECT-IGNORE*)
            warn "Contents.signature: Typedtree.Tsig_class_type" []
      )
      |> of_list

    let rec module_type {Typedtree.mty_desc; mty_type=_; mty_env; mty_loc=_; mty_attributes=_} =
      match mty_desc with
        | Typedtree.Tmty_signature signature_ ->
          signature signature_
        | Typedtree.Tmty_ident (path, _) ->
          Env.find_modtype path mty_env
          |> OfTypes.modtype_declaration mty_env
        | Typedtree.Tmty_functor (_, _, _, contents) ->
          module_type contents
        | Typedtree.Tmty_with (_, _) -> (*BISECT-IGNORE*)
          warn "Contents.OfTypedtree.module_type: Tmty_with" empty
        | Typedtree.Tmty_typeof _ -> (*BISECT-IGNORE*)
          warn "Contents.OfTypedtree.module_type: Tmty_typeof" empty
        | Typedtree.Tmty_alias (_, _) -> (*BISECT-IGNORE*)
          warn "Contents.OfTypedtree.module_type: Tmty_alias" empty

    let module_type_option = Opt.value_map ~f:module_type ~def:empty
  end
end

and ModuleType: sig
  module OfTypedtree: sig
    open Typedtree
    val module_type_declaration: module_type_declaration -> J.t
  end
end = struct
  module OfTypedtree = struct
    let module_type_declaration {Typedtree.mtd_id=_; mtd_name; mtd_type; mtd_attributes; mtd_loc=_} =
      J.obj "signature_item:module_type" [
        Name.of_string_loc mtd_name;
        Hidden.OfTypedtree.attributes mtd_attributes;
        Doc.(merge [OfTypedtree.attributes mtd_attributes; OfTypedtree.module_type_option mtd_type]);
        FunctorParameters.OfTypedtree.module_type_option mtd_type;
        ContentsFrom.OfTypedtree.module_type_option mtd_type;
        Contents.OfTypedtree.module_type_option mtd_type;
      ]
  end
end

and Include: sig
  module OfTypedtree: sig
    open Typedtree
    val include_description: include_description -> J.t
  end
end = struct
  module OfTypedtree = struct
    let include_description {Typedtree.incl_mod; incl_type=_; incl_loc=_; incl_attributes} =
      J.obj "signature_item:include" [
        Hidden.OfTypedtree.attributes incl_attributes;
        Doc.(merge [OfTypedtree.attributes incl_attributes; OfTypedtree.module_type incl_mod]);
        ContentsFrom.OfTypedtree.module_type incl_mod;
        Contents.OfTypedtree.module_type incl_mod;
      ]
  end
end

and Module: sig
  module OfTypedtree: sig
    open Typedtree
    val signature: string -> signature -> J.t
    val module_declaration: module_declaration -> J.t
  end
end = struct
  module OfTypedtree = struct
    let signature name signature =
      J.obj "signature_item:module" [
        Name.of_string name;
        Hidden.default;
        Doc.empty;
        FunctorParameters.empty;
        ContentsFrom.default;
        Contents.OfTypedtree.signature signature;
      ]

    let module_declaration {Typedtree.md_id=_; md_name; md_type; md_attributes; md_loc=_} =
      J.obj "signature_item:module" [
        Name.of_string_loc md_name;
        Hidden.OfTypedtree.attributes md_attributes;
        Doc.(merge [OfTypedtree.attributes md_attributes; OfTypedtree.module_type md_type]);
        FunctorParameters.OfTypedtree.module_type md_type;
        ContentsFrom.OfTypedtree.module_type md_type;
        Contents.OfTypedtree.module_type md_type;
      ]
  end
end


let () =
  Clflags.dont_write_files := true;
  Compmisc.init_path false;
  try
    let name =
      Str.drop_suffix ~suf:".mli" OCamlStandard.Sys.argv.(1)
    and signature =
      OCamlStandard.Sys.argv.(1)
      |> Pparse.parse_interface ~tool_name:"autoocamldoc" OCamlStandard.Format.err_formatter
      |> Typemod.type_interface "Foo?" (Compmisc.initial_env ())
    in
    Module.OfTypedtree.signature name signature
    |> J.to_string
    |> StdOut.print "%s\n"
  with
    exc -> begin (*BISECT-IGNORE*)
      Location.report_exception OCamlStandard.Format.err_formatter exc;
      Exit.(exit (Failure 1)) (*BISECT-IGNORE*)
    end
