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


let filter_attributes ~key attributes =
  attributes
  |> Li.filter_map ~f:(fun ({Asttypes.txt; loc=_}, payload) ->
    Opt.some_if (txt = key) (lazy Parsetree.(
      match payload with
        | PStr [{pstr_desc=Pstr_eval ({pexp_desc=Pexp_constant (Parsetree.Pconst_string (s, _)); _}, _); _}] ->
          J.str s
        | _ -> Exn.failure "filter_attributes" (*BISECT-IGNORE*)
    ))
  )


let filter_ocaml_doc_attributes attributes =
  J.li (filter_attributes ~key:"ocaml.doc" attributes)


module TypedtreeToJson = struct
  let type_expr' t =
    Printtyp.reset ();
    Printtyp.type_expr OCamlStandard.Format.str_formatter t;
    OCamlStandard.Format.flush_str_formatter ()

  let type_expr t =
    J.str (type_expr' t)

  open Typedtree

  let string_loc ?(format=Frmt.of_string "%s") {Asttypes.txt; loc=_} =
    J.str (Frmt.apply format txt)

  let type_parameters typ_params =
    typ_params
    |> Li.map ~f:(fun ({ctyp_type; _}, variance) ->
      let type_ = type_expr' ctyp_type
      and variance =
        match variance with
          | Asttypes.Covariant -> "+"
          | Asttypes.Contravariant -> "-"
          | Asttypes.Invariant -> ""
      in
      J.str (Frmt.apply "%s%s" variance type_)
    )
    |> J.li

  let type_manifest typ_manifest =
    typ_manifest
    |> Opt.map ~f:(fun {ctyp_type; _} -> type_expr ctyp_type)
    |> J.opt

  let label_declaration {ld_id=_; ld_name; ld_mutable; ld_type={ctyp_type; _}; ld_loc=_; ld_attributes} =
    J.obj "record_label" [
      ("doc", filter_ocaml_doc_attributes ld_attributes);
      ("name", string_loc ld_name);
      ("mutable", J.bo (ld_mutable = Asttypes.Mutable));
      ("type", type_expr ctyp_type);
    ]

  let constructor_arguments = function
    | Cstr_tuple payload ->
      J.obj "arguments:tuple" [
        ("payload", payload |> Li.map ~f:(fun {ctyp_type; _} -> type_expr ctyp_type) |> J.li);
      ]
    | Cstr_record labels ->
      J.obj "arguments:record" [
        ("labels", labels |> Li.map ~f:label_declaration |> J.li);
      ]

  let type_kind = function
    | Ttype_abstract ->
      J.obj "type_kind:abstract" [
      ]
    | Ttype_variant constructors ->
      J.obj "type_kind:variant" [
        (
          "constructors",
          constructors
          |> Li.map ~f:(fun {cd_id=_; cd_name; cd_args; cd_res=_; cd_loc=_; cd_attributes} ->
            J.obj "type_constructor" [
              ("doc", filter_ocaml_doc_attributes cd_attributes);
              ("name", string_loc cd_name);
              ("arguments", constructor_arguments cd_args);
            ]
          )
          |> J.li
        )
      ]
    | Ttype_record labels ->
      J.obj "type_kind:record" [
        ("labels", labels |> Li.map ~f:label_declaration |> J.li)
      ]
    | Ttype_open -> (*BISECT-IGNORE*)
      Exn.failure "type_kind: Ttype_open"
end


(*BISECT-IGNORE-BEGIN*)
let warn s v =
  StdErr.print "WARNING: %s\n" s;
  v
(*BISECT-IGNORE-END*)


module Name: sig
  val of_string: string -> J.a
  val of_string_loc: string Asttypes.loc -> J.a
end = struct
  let of_string s =
    ("name", J.str s)

  let of_string_loc {Asttypes.txt; loc=_} =
    of_string txt
end


module Hidden: sig
  val default: J.a

  val of_attributes: Typedtree.attributes -> J.a
end = struct
  let of_bool hidden =
    ("hidden", J.bo hidden)

  let default = of_bool false

  let of_attributes attributes =
    attributes
    |> Li.there_exists ~f:(fun ({Asttypes.txt; loc=_}, payload) ->
      txt = "autodoc.hide" && payload = Parsetree.PStr []
    )
    |> of_bool
end


module Doc: sig
  val empty: J.a
  val of_attributes: Typedtree.attributes -> J.a
end = struct
  let of_list xs =
    ("doc", J.li xs)

  let empty = of_list []

  let of_attributes attributes =
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
    |> of_list
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


module Type: sig
  val of_type_declaration: Typedtree.type_declaration -> J.t
end = struct
  let of_type_declaration {Typedtree.typ_id=_; typ_name; typ_params; typ_type=_; typ_cstrs=_; typ_kind; typ_private=_; typ_manifest; typ_loc=_; typ_attributes} =
    J.obj "signature_item:type" [
      Name.of_string_loc typ_name;
      Hidden.of_attributes typ_attributes;
      Doc.of_attributes typ_attributes;
      ("parameters", TypedtreeToJson.type_parameters typ_params);
      ("manifest",TypedtreeToJson. type_manifest typ_manifest);
      ("kind", TypedtreeToJson.type_kind typ_kind);
    ]
end


module Exception: sig
  val of_extension_constructor: Typedtree.extension_constructor -> J.t
end = struct
  let of_extension_constructor {Typedtree.ext_id=_; ext_name; ext_type=_; ext_kind; ext_loc=_; ext_attributes} =
    let arguments =
      match ext_kind with
        | Typedtree.Text_decl (arguments, _) ->
          arguments
        | Typedtree.Text_rebind (_, _) -> (*BISECT-IGNORE*)
          Exn.failure "exception_: ext_kind=Text_rebind"
    in
    J.obj "signature_item:exception" [
      Name.of_string_loc ext_name;
      Hidden.of_attributes ext_attributes;
      Doc.of_attributes ext_attributes;
      ("arguments", TypedtreeToJson.constructor_arguments arguments);
    ]
end


module Value: sig
  val of_value_description: Typedtree.value_description -> J.t
end = struct
  let of_value_description {Typedtree.val_id=_; val_name; val_desc={Typedtree.ctyp_type; _}; val_val=_; val_prim=_; val_loc=_; val_attributes} =
    (* @todo let format =
      Opt.some_if'
        (Oprint.parenthesized_ident (Ident.name val_id))
        (Frmt.of_string "(%s)") (* This is not strictly correct for ( * ) but it's prettier for everything else. *)
    in *)
    J.obj "signature_item:value" [
      Name.of_string_loc val_name;
      Hidden.of_attributes val_attributes;
      Doc.of_attributes val_attributes;
      ("type", TypedtreeToJson.type_expr ctyp_type);
    ]
end


module rec FunctorParameters: sig
  val empty: J.a
  val of_module_type: Typedtree.module_type -> J.a
  val of_module_type_option: Typedtree.module_type option -> J.a
end = struct
  let of_list contents =
    ("functor_parameters", J.li contents)

  let empty = of_list []

  let rec of_module_type t =
    let rec aux {Typedtree.mty_desc; mty_type=_; mty_env=_; mty_loc=_; mty_attributes=_} =
      match mty_desc with
        | Typedtree.Tmty_signature _ ->
          [] (* Empty on purpose *)
        | Typedtree.Tmty_ident (_, _) -> (*BISECT-IGNORE*)
          warn "FunctorParameters.of_module_type: Tmty_ident" []
        | Typedtree.Tmty_functor (_, parameter_name, parameter_type, contents) ->
          let parameter = J.obj "functor_parameter" [
            Name.of_string_loc parameter_name;
            of_module_type_option parameter_type;
            Contents.of_module_type_option parameter_type;
          ] in
          parameter::(aux contents)
        | Typedtree.Tmty_with (_, _) -> (*BISECT-IGNORE*)
          warn "FunctorParameters.of_module_type: Tmty_with" []
        | Typedtree.Tmty_typeof _ -> (*BISECT-IGNORE*)
          warn "FunctorParameters.of_module_type: Tmty_typeof" []
        | Typedtree.Tmty_alias (_, _) -> (*BISECT-IGNORE*)
          warn "FunctorParameters.of_module_type: Tmty_alias" []
    in
    aux t
    |> of_list

  and of_module_type_option = Opt.value_map ~f:of_module_type ~def:empty
end

and Contents: sig
  val of_signature: Typedtree.signature -> J.a
  val of_module_type: Typedtree.module_type -> J.a
  val of_module_type_option: Typedtree.module_type option -> J.a
end = struct
  let of_list contents =
    ("contents", J.li contents)

  let empty = of_list []

  let of_signature {Typedtree.sig_items; sig_type=_; sig_final_env=_} =
    sig_items
    |> Li.flat_map ~f:(fun {Typedtree.sig_desc; sig_env=_; sig_loc=_} ->
      match sig_desc with
        | Typedtree.Tsig_attribute ({Asttypes.txt="ocaml.text"; loc=_}, payload) ->
          [FloatingDoc.of_attribute_payload payload]
        | Typedtree.Tsig_attribute _ ->
          [] (* Empty on purpose *)
        | Typedtree.Tsig_modtype declaration ->
          [ModuleType.of_module_type_declaration declaration]
        | Typedtree.Tsig_value description ->
          [Value.of_value_description description]
        | Typedtree.Tsig_module declaration ->
          [Module.of_declaration declaration]
        | Typedtree.Tsig_include description ->
          [Include.of_include_description description]
        | Typedtree.Tsig_type (_, declarations) ->
          declarations
          |> Li.map ~f:Type.of_type_declaration
        | Typedtree.Tsig_typext _ -> (*BISECT-IGNORE*)
          warn "Contents.of_signature: Typedtree.Tsig_typext" []
        | Typedtree.Tsig_exception description ->
          [Exception.of_extension_constructor description]
        | Typedtree.Tsig_recmodule _ -> (*BISECT-IGNORE*)
          warn "Contents.of_signature: Typedtree.Tsig_recmodule" []
        | Typedtree.Tsig_open _ -> (*BISECT-IGNORE*)
          warn "Contents.of_signature: Typedtree.Tsig_open" []
        | Typedtree.Tsig_class _ -> (*BISECT-IGNORE*)
          warn "Contents.of_signature: Typedtree.Tsig_class" []
        | Typedtree.Tsig_class_type _ -> (*BISECT-IGNORE*)
          warn "Contents.of_signature: Typedtree.Tsig_class_type" []
    )
    |> of_list

  let rec of_module_type {Typedtree.mty_desc; mty_type=_; mty_env=_; mty_loc=_; mty_attributes=_} =
    match mty_desc with
      | Typedtree.Tmty_signature signature ->
        of_signature signature
      | Typedtree.Tmty_ident (_, _) -> (*BISECT-IGNORE*)
        warn "Contents.of_module_type: Tmty_ident" empty
      | Typedtree.Tmty_functor (_, _, _, contents) ->
        of_module_type contents
      | Typedtree.Tmty_with (_, _) -> (*BISECT-IGNORE*)
        warn "Contents.of_module_type: Tmty_with" empty
      | Typedtree.Tmty_typeof _ -> (*BISECT-IGNORE*)
        warn "Contents.of_module_type: Tmty_typeof" empty
      | Typedtree.Tmty_alias (_, _) -> (*BISECT-IGNORE*)
        warn "Contents.of_module_type: Tmty_alias" empty

  let of_module_type_option = Opt.value_map ~f:of_module_type ~def:empty
end

and ModuleType: sig
  val of_module_type_declaration: Typedtree.module_type_declaration -> J.t
end = struct
  let of_module_type_declaration {Typedtree.mtd_id=_; mtd_name; mtd_type; mtd_attributes; mtd_loc=_} =
    J.obj "signature_item:module_type" [
      Name.of_string_loc mtd_name;
      Hidden.of_attributes mtd_attributes;
      Doc.of_attributes mtd_attributes;
      Contents.of_module_type_option mtd_type;
    ]
end

and Include: sig
  val of_include_description: Typedtree.include_description -> J.t
end = struct
  let of_include_description {Typedtree.incl_mod; incl_type=_; incl_loc=_; incl_attributes} =
    J.obj "signature_item:include" [
      Hidden.of_attributes incl_attributes;
      Doc.of_attributes incl_attributes;
      Contents.of_module_type incl_mod;
    ]
end

and Module: sig
  val of_signature: name:string -> signature:Typedtree.signature -> J.t

  val of_declaration: Typedtree.module_declaration -> J.t
end = struct
  let of_signature ~name ~signature =
    J.obj "signature_item:module" [
      Name.of_string name;
      Hidden.default;
      Doc.empty;
      FunctorParameters.empty;
      Contents.of_signature signature;
    ]

  let of_declaration {Typedtree.md_id=_; md_name; md_type; md_attributes; md_loc=_} =
    J.obj "signature_item:module" [
      Name.of_string_loc md_name;
      Hidden.of_attributes md_attributes;
      Doc.of_attributes md_attributes;
      FunctorParameters.of_module_type md_type;
      Contents.of_module_type md_type;
    ]
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
    Module.of_signature ~name ~signature
    |> J.to_string
    |> StdOut.print "%s\n"
  with
    exc -> begin (*BISECT-IGNORE*)
      Location.report_exception OCamlStandard.Format.err_formatter exc;
      Exit.(exit (Failure 1)) (*BISECT-IGNORE*)
    end
