open General.Abbr

module J = struct
  type t = Yojson.Basic.json

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

  let (obj: string -> (string * t) list -> t) = fun kind attributes ->
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

(* module TypesToJson = struct
  open Types

  let type_expr t =
    Printtyp.reset ();
    Printtyp.type_expr OCamlStandard.Format.str_formatter t;
    J.str (OCamlStandard.Format.flush_str_formatter ())

  let ident {Ident.name; stamp=_; flags=_} =
    J.str name

  let rec signature_item = function
    | Sig_value (id, {val_type; val_kind=_; val_loc=_; val_attributes}) ->
      J.obj "signature_item:value" [
        ("doc", filter_ocaml_doc_attributes val_attributes);
        ("hidden", J.bo false);
        ("name", ident id);
        ("type", type_expr val_type);
      ]
    | Sig_type (id, {type_params=_; type_arity=_; type_kind=_; type_private=_; type_manifest; type_variance=_; type_newtype_level=_; type_loc=_; type_attributes; type_immediate=_; type_unboxed=_}, _) ->
      J.obj "signature_item:value" [
        ("doc", filter_ocaml_doc_attributes type_attributes);
        ("hidden", J.bo false);
        ("name", ident id);
        ("manifest", type_manifest |> Opt.map ~f:type_expr |> J.opt);
      ]      
    | Sig_typext (_, _, _) ->
      J.str "TypesToJson.signature_item: Sig_typext"
    | Sig_module (id, {md_type; md_attributes; md_loc=_}, _) ->
      J.obj "signature_item:module" [
        ("doc", filter_ocaml_doc_attributes md_attributes);
        ("hidden", J.bo false);
        ("name", ident id);
        ("type", module_type [] md_type);
      ]
    | Sig_modtype (_, _) ->
      J.str "TypesToJson.signature_item: Sig_modtype"
    | Sig_class (_, _, _) ->
      J.str "TypesToJson.signature_item: Sig_class"
    | Sig_class_type (_, _, _) ->
      J.str "TypesToJson.signature_item: Sig_class_type"

  and module_type attributes = function
    | Mty_ident _ ->
      J.str "TypesToJson.module_type: Mty_ident"
    | Mty_signature elements ->
      J.obj "module_type:signature" [
        ("doc", filter_ocaml_doc_attributes attributes);
        ("elements", elements |> Li.map ~f:signature_item |> J.li)
      ]
    | Mty_functor (_, _, _) ->
      J.str "TypesToJson.module_type: Mty_functor"
    | Mty_alias (_, _) ->
      J.str "TypesToJson.module_type: Mty_alias"

  let modtype_declaration {Types.mtd_type; mtd_attributes; mtd_loc=_} =
    mtd_type |> Opt.map ~f:(module_type mtd_attributes) |> J.opt
end *)

module TypedtreeToJson: sig
  val signature: Typedtree.signature -> J.t
end = struct
  (*BISECT-IGNORE-BEGIN*)
  let not_handled =
    let count = ref 0 in
    fun s {Location.loc_start; _} ->
      if !count < 10 then begin
        IntRef.increment count;
        let (file, line, char) = Location.get_pos_info loc_start in
        StdErr.print "autodoc (OCaml): [WARNING] %s not handled at %s:%i:%i\n" s file line char
      end else if !count = 10 then begin
        IntRef.increment count;
        StdErr.print "autodoc (OCaml): [WARNING] more items not handled\n"
      end;
      J.obj "not_handled" [
        ("hidden", J.bo false);
        ("reason", J.str s)
      ]
  (*BISECT-IGNORE-END*)

  let hidden attributes =
    attributes
    |> Li.there_exists ~f:(fun ({Asttypes.txt; loc=_}, payload) ->
      txt = "autodoc.hide" && payload = Parsetree.PStr []
    )

  let type_expr' t =
    Printtyp.reset ();
    Printtyp.type_expr OCamlStandard.Format.str_formatter t;
    OCamlStandard.Format.flush_str_formatter ()

  let type_expr t =
    J.str (type_expr' t)

  open Typedtree

  let path path =
    J.str (Path.name path)

  (* let longident_loc {Asttypes.txt=longident; loc=_} =
    J.str (Longident.flatten longident |> StrLi.concat ~sep:".") *)

  let string_loc ?(format=Frmt.of_string "%s") {Asttypes.txt; loc=_} =
    J.str (Frmt.apply format txt)

  let value_description {val_id; val_name; val_desc; val_val=_; val_prim=_; val_loc=_; val_attributes} =
    let format =
      Opt.some_if'
        (Oprint.parenthesized_ident (Ident.name val_id))
        (Frmt.of_string "(%s)") (* This is not strictly correct for ( * ) but it's prettier for everything else. *)
    in
    (
      "signature_item:value",
      [
        ("name", string_loc ?format val_name);
        ("type", type_expr val_desc.ctyp_type);
      ],
      val_attributes
    )

  let attribute attr =
    filter_attributes ~key:"ocaml.text" [attr]
    |> Li.map ~f:(fun s ->
      J.obj "signature_item:floating_documentation" [
        ("hidden", J.bo false);
        ("text", s);
      ]
    )
    |> Li.head

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

  let type_kind ~typ_loc = function
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
      not_handled "type_kind: Ttype_open" typ_loc

  let with_constraint (p, _, constraint_) =
    let type_ {typ_name; typ_params; typ_manifest; typ_loc=_; _} =
      [
        ("name", string_loc typ_name);
        ("parameters", type_parameters typ_params);
        ("manifest", type_manifest typ_manifest);
      ]
    and module_ p' =
      [
        ("name", path p);
        ("manifest", path p');
      ]
    in
    match constraint_ with
      | Twith_type typ ->
        J.obj "with:type" (type_ typ)
      | Twith_module (p', _) ->
        J.obj "with:module" (module_ p')
      | Twith_typesubst typ ->
        J.obj "with:type_subst" (type_ typ)
      | Twith_modsubst (p', _) ->
        J.obj "with:module_subst" (module_ p')

  let type_declaration {typ_id=_; typ_name; typ_params; typ_type=_; typ_cstrs=_; typ_kind; typ_private=_; typ_manifest; typ_loc; typ_attributes} =
    (
      "signature_item:type",
      [
        ("name", string_loc typ_name);
        ("parameters", type_parameters typ_params);
        ("manifest", type_manifest typ_manifest);
        ("kind", type_kind ~typ_loc typ_kind);
      ],
      typ_attributes
    )

  let exception_ {ext_id=_; ext_name; ext_type=_; ext_kind; ext_loc=_; ext_attributes} =
    let arguments =
      match ext_kind with
        | Text_decl (arguments, _) -> arguments
        | Text_rebind (_, _) -> Cstr_tuple []
    in
    (
      "signature_item:exception",
      [
        ("name", string_loc ext_name);
        ("arguments", constructor_arguments arguments);
      ],
      ext_attributes
    )

  let rec signature {sig_items; sig_type=_; sig_final_env=_} =
    J.li (Li.map ~f:signature_item sig_items)

  and signature_item {sig_desc; sig_env=_; sig_loc} =
    let foo (kind, json_attributes, ocaml_attributes) =
      (
        J.obj kind (
          ("doc", filter_ocaml_doc_attributes ocaml_attributes)::
          ("hidden", J.bo (hidden ocaml_attributes))::
          json_attributes
        )
      )
    in
    match sig_desc with
      | Tsig_attribute attr ->
        attribute attr
      | Tsig_modtype decl ->
        foo (module_type_declaration decl)
      | Tsig_value desc ->
        foo (value_description desc)
      | Tsig_module decl ->
        foo (module_declaration decl)
      | Tsig_include desc ->
        foo (include_description desc)
      | Tsig_type (_, [decl]) ->
        foo (type_declaration decl)
      | Tsig_type (_, decls) ->
        foo (
          "signature_item:recursive_types",
          [
            ("types", decls |> Li.map ~f:type_declaration |> Li.map ~f:foo |> J.li)
          ],
          []
        )
      | Tsig_typext _ -> (*BISECT-IGNORE*)
        not_handled "signature_item: sig_desc=Tsig_typext" sig_loc
      | Tsig_exception desc ->
        foo (exception_ desc)
      | Tsig_recmodule _ -> (*BISECT-IGNORE*)
        not_handled "signature_item: sig_desc=Tsig_recmodule" sig_loc
      | Tsig_open _ -> (*BISECT-IGNORE*)
        not_handled "signature_item: sig_desc=Tsig_open" sig_loc
      | Tsig_class _ -> (*BISECT-IGNORE*)
        not_handled "signature_item: sig_desc=Tsig_class" sig_loc
      | Tsig_class_type _ -> (*BISECT-IGNORE*)
        not_handled "signature_item: sig_desc=Tsig_class_type" sig_loc

  and module_type_declaration {mtd_id=_; mtd_name; mtd_type; mtd_attributes; mtd_loc=_} =
    (
      "signature_item:module_type",
      [
        ("name", string_loc mtd_name);
        ("type", mtd_type |> Opt.map ~f:module_type |> J.opt);
      ],
      mtd_attributes
    )

  and module_declaration {md_id=_; md_name; md_type; md_attributes; md_loc=_} =
    (
      "signature_item:module",
      [
        ("name", string_loc md_name);
        ("type", module_type md_type);
      ],
      md_attributes
    )

  and include_description {incl_mod; incl_type=_; incl_loc=_; incl_attributes} =
    (
      "signature_item:include",
      [
        ("type", module_type incl_mod);
      ],
      incl_attributes
    )

  and module_type {mty_desc; mty_type=_; mty_env=_; mty_loc; mty_attributes=_} =
    match mty_desc with
      | Tmty_signature signature_ ->
        J.obj "module_type:signature" [
          ("elements", signature signature_);
        ]
      | Tmty_ident (p, _) ->
        J.obj "module_type:identifier" [
          ("name", path p);
          (* ("resolved_type", TypesToJson.modtype_declaration (Env.find_modtype p mty_env)); *)
        ]
      | Tmty_functor (_, parameter_name, parameter_type, contents) ->
        let rec aux parameters parameter_name parameter_type contents =
          let parameter = J.obj "functor_parameter" [
            ("name", string_loc parameter_name);
            ("type", parameter_type |> Opt.map ~f:module_type |> J.opt);
          ] in
          let parameters = parameter::parameters in
          match contents with
            | {mty_desc=Tmty_functor (_, parameter_name, parameter_type, contents); _} ->
              aux parameters parameter_name parameter_type contents
            | _ ->
              (Li.reverse parameters, module_type contents)
        in
        let (parameters, contents) = aux [] parameter_name parameter_type contents in
        J.obj "module_type:functor" [
          ("parameters", J.li parameters);
          ("contents", contents);
        ]
      | Tmty_with (module_, constaints) ->
        J.obj "module_type:with" [
          ("module", module_type module_);
          ("constaints", constaints |> Li.map ~f:with_constraint |> J.li);
          (* @todo List elements *)
        ]
      | Tmty_typeof module_ ->
        J.obj "module_type:of" [
          ("module", module_expr module_);
          (* @todo List elements *)
        ]
      | Tmty_alias (_, _) -> (*BISECT-IGNORE*)
        not_handled "module_type: mty_desc=Tmty_alias" mty_loc

  and module_expr {mod_desc; mod_loc; mod_type=_; mod_env=_; mod_attributes=_} =
    match mod_desc with
      | Tmod_ident (p, _) ->
        J.obj "module_expr:identifier" [("name", path p)]
      | Tmod_structure _ -> (*BISECT-IGNORE*)
        not_handled "module_expr: mod_desc=Tmod_structure" mod_loc
      | Tmod_functor (_, _, _, _) -> (*BISECT-IGNORE*)
        not_handled "module_expr: mod_desc=Tmod_functor" mod_loc
      | Tmod_apply (functor_, argument, _) ->
        let rec aux arguments functor_ argument =
          let arguments = (module_expr argument)::arguments in
          match functor_ with
            | {mod_desc=Tmod_apply (functor_, argument, _); _} ->
              aux arguments functor_ argument
            | _ ->
              (module_expr functor_, arguments)
        in
        let (functor_, arguments) = aux [] functor_ argument in
        J.obj "module_expr:apply" [
          ("functor", functor_);
          ("arguments", J.li arguments);
        ]
      | Tmod_constraint (_, _, _, _) -> (*BISECT-IGNORE*)
        not_handled "module_expr: mod_desc=Tmod_constraint" mod_loc
      | Tmod_unpack (_, _) -> (*BISECT-IGNORE*)
        not_handled "module_expr: mod_desc=Tmod_unpack" mod_loc
end


let () =
  Clflags.dont_write_files := true;
  Compmisc.init_path false;
  try
    let signature =
      OCamlStandard.Sys.argv.(1)
      |> Pparse.parse_interface ~tool_name:"autoocamldoc" OCamlStandard.Format.err_formatter
      |> Typemod.type_interface "Foo?" (Compmisc.initial_env ())
      |> TypedtreeToJson.signature
    in
    J.obj "signature_item:module" [
      ("name", OCamlStandard.Sys.argv.(1) |> Str.drop_suffix ~suf:".mli" |> J.str);
      ("doc", J.li []);
      ("hidden", J.bo false);
      (
        "type",
        J.obj "module_type:signature" [
          ("elements", signature);
        ]
      )
    ]
    |> J.to_string
    |> StdOut.print "%s\n"
  with
    exc -> begin (*BISECT-IGNORE*)
      Location.report_exception OCamlStandard.Format.err_formatter exc;
      Exit.(exit (Failure 1)) (*BISECT-IGNORE*)
    end
