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

module TypedtreeToJson: sig
  val signature: Typedtree.signature -> J.t
end = struct
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
      J.str (Frmt.apply "NOT HANDLED: %s" s)

  let hidden attributes =
    attributes
    |> Li.there_exists ~f:(fun ({Asttypes.txt; loc=_}, payload) ->
      txt = "autodoc.hide" && payload = Parsetree.PStr []
    )

  let filter_attributes ~key attributes =
    attributes
    |> Li.filter_map ~f:(fun ({Asttypes.txt; loc}, payload) ->
      Opt.some_if (txt = key) (lazy Parsetree.(
        match payload with
          | PStr [{pstr_desc=Pstr_eval ({pexp_desc=Pexp_constant (Asttypes.Const_string (s, _)); _}, _); _}] ->
            J.str s
          | _ ->
            not_handled "attribute" loc
      ))
    )

  let filter_ocaml_doc_attributes attributes =
    J.li (filter_attributes ~key:"ocaml.doc" attributes)

  let type_expr loc =
    let rec aux {Types.desc; level=_; id=_} =
      Types.(
        match desc with
          | Tvar name ->
            J.obj "value_type:variable" [
              ("name", name |> Opt.map ~f:J.str |> J.opt);
            ]
          | Tarrow (label, left, right, _) ->
            J.obj "value_type:function" [
              ("label", Opt.some_if' (label <> "") (J.str label) |> J.opt);
              ("left", aux left);
              ("right", aux right);
            ]
          | Tconstr (name, arguments, _) ->
            J.obj "value_type:constructor" [
              ("name", J.str (Path.name name));
              ("arguments", arguments |> Li.map ~f:aux |> J.li);
            ]
          | Tlink expr ->
            aux expr
          | Ttuple elements ->
            J.obj "value_type:tuple" [
              ("elements", elements |> Li.map ~f:aux |> J.li);
            ]
          | Tobject _ ->
            not_handled "type_expr: Tobject" loc
          | Tfield _ ->
            not_handled "type_expr: Tfield" loc
          | Tnil ->
            not_handled "type_expr: Tnil" loc
          | Tsubst _ ->
            not_handled "type_expr: Tsubst" loc
          | Tvariant _ ->
            not_handled "type_expr: Tvariant" loc
          | Tunivar _ ->
            not_handled "type_expr: Tunivar" loc
          | Tpoly (x, []) ->
              aux x
          | Tpoly _ ->
            not_handled "type_expr: Tpoly" loc
          | Tpackage _ ->
            not_handled "type_expr: Tpackage" loc
      )
    in
    aux

  open Typedtree

  let path path =
    J.str (Path.name path)

  let longident_loc {Asttypes.txt=longident; loc=_} =
    J.str (Longident.flatten longident |> StrLi.concat ~sep:".")

  let string_loc {Asttypes.txt; loc=_} =
    J.str txt

  let value_description {val_id=_; val_name; val_desc; val_val=_; val_prim=_; val_loc; val_attributes} =
    J.obj "signature_item:value" [
      ("doc", filter_ocaml_doc_attributes val_attributes);
      ("name", string_loc val_name);
      ("type", type_expr val_loc val_desc.ctyp_type);
    ]

  let attribute attr =
    filter_attributes ~key:"ocaml.text" [attr]
    |> Li.map ~f:(fun s ->
      J.obj "signature_item:floating_documentation" [
        ("text", s);
      ]
    )
    |> Li.head

  let type_parameters ~typ_loc typ_params =
    (* let rec aux = Types.(function
      | {desc=Tvar name; _} ->
        name |> Opt.map ~f:J.str |> J.opt
      | {desc=Tlink t; _} ->
        aux t
      | {desc=Tarrow (_, _, _, _); _} ->
        not_handled "type_parameter: desc=Tarrow" typ_loc
      | {desc=Ttuple _; _} ->
        not_handled "type_parameter: desc=Ttuple" typ_loc
      | {desc=Tconstr (_, _, _); _} ->
        not_handled "type_parameter: desc=Tconstr" typ_loc
      | {desc=Tobject (_, _); _} ->
        not_handled "type_parameter: desc=Tobject" typ_loc
      | {desc=Tfield (_, _, _, _); _} ->
        not_handled "type_parameter: desc=Tfield" typ_loc
      | {desc=Tnil; _} ->
        not_handled "type_parameter: desc=Tnil" typ_loc
      | {desc=Tsubst _; _} ->
        not_handled "type_parameter: desc=Tsubst" typ_loc
      | {desc=Tvariant _; _} ->
        not_handled "type_parameter: desc=Tvariant" typ_loc
      | {desc=Tunivar _; _} ->
        not_handled "type_parameter: desc=Tunivar" typ_loc
      | {desc=Tpoly (_, _); _} ->
        not_handled "type_parameter: desc=Tpoly" typ_loc
      | {desc=Tpackage (_, _, _); _} ->
        not_handled "type_parameter: desc=Tpackage" typ_loc
    ) in *)
    typ_params
    |> Li.map ~f:(fun ({ctyp_type; _}, variance) ->
      let variance = match variance with
        | Asttypes.Covariant -> J.str "+"
        | Asttypes.Contravariant -> J.str "-"
        | Asttypes.Invariant -> J.null
      in
      J.obj "type_parameter" [
        ("type", type_expr typ_loc ctyp_type);
        ("variance", variance);
      ]
    )
    |> J.li

  let type_manifest ~typ_loc typ_manifest =
    typ_manifest
    |> Opt.map ~f:(fun {ctyp_type; _} -> type_expr typ_loc ctyp_type)
    |> J.opt

  let type_kind ~typ_loc = function
    | Ttype_abstract ->
      J.obj "type_kind:abstract" [
      ]
    | Ttype_variant constructors ->
      J.obj "type_kind:variant" [
        (
          "constructors",
          constructors
          |> Li.map ~f:(fun {cd_id=_; cd_name; cd_args; cd_res=_; cd_loc; cd_attributes} ->
            J.obj "type_constructor" [
              ("doc", filter_ocaml_doc_attributes cd_attributes);
              ("name", string_loc cd_name);
              ("arguments", cd_args |> Li.map ~f:(fun {ctyp_type; _} -> type_expr cd_loc ctyp_type) |> J.li);
            ]
          )
          |> J.li
        )
      ]
    | Ttype_record labels ->
      J.obj "type_kind:record" [
        (
          "labels",
          labels
          |> Li.map ~f:(fun {ld_id=_; ld_name; ld_mutable; ld_type={ctyp_type; _}; ld_loc; ld_attributes} ->
            J.obj "type_label" [
              ("doc", filter_ocaml_doc_attributes ld_attributes);
              ("name", string_loc ld_name);
              ("mutable", J.bo (ld_mutable = Asttypes.Mutable));
              ("type", type_expr ld_loc ctyp_type);
            ]
          )
          |> J.li
        )
      ]
    | Ttype_open ->
      not_handled "type_kind: Ttype_open" typ_loc

  let with_constraint =
    let type_ {typ_name; typ_params; typ_manifest; typ_loc; _} =
      [
        ("name", string_loc typ_name);
        ("parameters", type_parameters ~typ_loc typ_params);
        ("manifest", type_manifest ~typ_loc typ_manifest);
      ]
    and module_ p ident =
      [
        ("name", path p);
        ("manifest", longident_loc ident);
      ]
    in
    function
      | Twith_type typ ->
        J.obj "with:type" (type_ typ)
      | Twith_module (p, ident) ->
        J.obj "with:module" (module_ p ident)
      | Twith_typesubst typ ->
        J.obj "with:type_subst" (type_ typ)
      | Twith_modsubst (p, ident) ->
        J.obj "with:module_subst" (module_ p ident)

  let type_declaration {typ_id=_; typ_name; typ_params; typ_type=_; typ_cstrs=_; typ_kind; typ_private=_; typ_manifest; typ_loc; typ_attributes} =
    J.obj "signature_item:type" [
      ("doc", filter_ocaml_doc_attributes typ_attributes);
      ("name", string_loc typ_name);
      ("parameters", type_parameters ~typ_loc typ_params);
      ("manifest", type_manifest ~typ_loc typ_manifest);
      ("kind", type_kind ~typ_loc typ_kind);
    ]

  let exception_ {ext_id=_; ext_name; ext_type={Types.ext_args; _}; ext_kind=_; ext_loc; ext_attributes} =
    J.obj "signature_item:exception" [
      ("doc", filter_ocaml_doc_attributes ext_attributes);
      ("name", string_loc ext_name);
      ("arguments", ext_args |> Li.map ~f:(type_expr ext_loc) |> J.li);
    ]

  let rec signature {sig_items; sig_type=_; sig_final_env=_} =
    J.li (Li.filter_map ~f:signature_item sig_items)

  and signature_item {sig_desc; sig_env=_; sig_loc} =
    match sig_desc with
      | Tsig_attribute attr ->
        Some (attribute attr)
      | Tsig_modtype _ ->
        Some (not_handled "signature_item: sig_desc=Tsig_modtype" sig_loc)
      | Tsig_value desc ->
        Some (value_description desc)
      | Tsig_module decl ->
        Some (module_declaration decl)
      | Tsig_include desc ->
        include_description desc
      | Tsig_type [decl] ->
        Some (type_declaration decl)
      | Tsig_type decls ->
        Some (J.obj "signature_item:recursive_types" [
          ("types", decls |> Li.map ~f:type_declaration |> J.li)
        ])
      | Tsig_typext _ ->
        Some (not_handled "signature_item: sig_desc=Tsig_typext" sig_loc)
      | Tsig_exception desc ->
        Some (exception_ desc)
      | Tsig_recmodule _ ->
        Some (not_handled "signature_item: sig_desc=Tsig_recmodule" sig_loc)
      | Tsig_open _ ->
        Some (not_handled "signature_item: sig_desc=Tsig_open" sig_loc)
      | Tsig_class _ ->
        Some (not_handled "signature_item: sig_desc=Tsig_class" sig_loc)
      | Tsig_class_type _ ->
        Some (not_handled "signature_item: sig_desc=Tsig_class_type" sig_loc)

  and module_declaration {md_id=_; md_name; md_type; md_attributes; md_loc=_} =
    J.obj "signature_item:module" [
      ("doc", filter_ocaml_doc_attributes md_attributes);
      ("name", string_loc md_name);
      ("type", module_type md_type);
    ]

  and include_description {incl_mod; incl_type=_; incl_loc=_; incl_attributes} =
    (* @todo Factorize the logic of hidding and extracting the doc for all signature items, by making them return their attributes *)
    Opt.some_if
      (not (hidden incl_attributes))
      (lazy (
        J.obj "signature_item:include" [
          ("doc", filter_ocaml_doc_attributes incl_attributes);
          ("contents", module_type incl_mod);
        ]
      ))

  and module_type {mty_desc; mty_type=_; mty_env=_; mty_loc; mty_attributes=_} =
    match mty_desc with
      | Tmty_signature signat ->
        J.obj "module_type:signature" [
          ("elements", signature signat);
        ]
      | Tmty_ident (p, _) ->
        J.obj "module_type:identifier" [
          ("name", path p);
        ]
      | Tmty_functor (_, parameter_name, parameter_type, contents) ->
        (* @todo Flatten functors with several parameters *)
        J.obj "module_type:functor" [
          (
            "parameters",
            J.li [
              J.obj "functor_parameter" [
                ("name", string_loc parameter_name);
                ("type", parameter_type |> Opt.map ~f:module_type |> J.opt);
              ];
            ]
          );
          ("contents", module_type contents);
        ]
      | Tmty_with (base, constaints) ->
        J.obj "module_type:with" [
          ("base", module_type base);
          ("constaints", constaints |> Li.map ~f:(fun (_, _, c) -> with_constraint c) |> J.li);
        ]
      | Tmty_typeof base ->
        J.obj "module_type:of" [
          ("base", module_expr base);
        ]
      | Tmty_alias (_, _) ->
        not_handled "module_type: mty_desc=Tmty_alias" mty_loc

  and module_expr {mod_desc; mod_loc; mod_type=_; mod_env=_; mod_attributes=_} =
    match mod_desc with
      | Tmod_ident (p, _) ->
        J.obj "module_expr:identifier" [("name", path p)]
      | Tmod_structure _ ->
        not_handled "module_expr: mod_desc=Tmod_structure" mod_loc
      | Tmod_functor (_, _, _, _) ->
        not_handled "module_expr: mod_desc=Tmod_functor" mod_loc
      | Tmod_apply (functor_, argument, _) ->
        (* @todo Flatten application of multi-parameter functors (argument -> argumentS) *)
        J.obj "module_expr:apply" [
          ("functor", module_expr functor_);
          ("arguments", J.li [module_expr argument]);
        ]
      | Tmod_constraint (_, _, _, _) ->
        not_handled "module_expr: mod_desc=Tmod_constraint" mod_loc
      | Tmod_unpack (_, _) ->
        not_handled "module_expr: mod_desc=Tmod_unpack" mod_loc
end


let () =
  Clflags.dont_write_files := true;
  Compmisc.init_path false;
  try
    OCamlStandard.Sys.argv.(1)
    |> Pparse.parse_interface ~tool_name:"autoocamldoc" OCamlStandard.Format.err_formatter
    |> Typemod.type_interface (Compmisc.initial_env ())
    |> TypedtreeToJson.signature
    |> J.to_string
    |> StdOut.print "%s\n"
  with
    exc -> Location.report_exception OCamlStandard.Format.err_formatter exc
