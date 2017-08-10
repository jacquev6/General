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
      J.str (Frmt.apply "NOT HANDLED: %s" s)
  (*BISECT-IGNORE-END*)

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
          | _ -> (*BISECT-IGNORE*)
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
          | Tobject _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tobject" loc
          | Tfield _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tfield" loc
          | Tnil -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tnil" loc
          | Tsubst _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tsubst" loc
          | Tvariant _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tvariant" loc
          | Tunivar _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tunivar" loc
          | Tpoly (x, []) ->
              aux x
          | Tpoly _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tpoly" loc
          | Tpackage _ -> (*BISECT-IGNORE*)
            not_handled "type_expr: Tpackage" loc
      )
    in
    aux

  open Typedtree

  let path path =
    J.str (Path.name path)

  (* let longident_loc {Asttypes.txt=longident; loc=_} =
    J.str (Longident.flatten longident |> StrLi.concat ~sep:".") *)

  let string_loc {Asttypes.txt; loc=_} =
    J.str txt

  let value_description {val_id=_; val_name; val_desc; val_val=_; val_prim=_; val_loc; val_attributes} =
    (
      "signature_item:value",
      [
        ("name", string_loc val_name);
        ("type", type_expr val_loc val_desc.ctyp_type);
      ],
      val_attributes
    )

  let attribute attr =
    filter_attributes ~key:"ocaml.text" [attr]
    |> Li.map ~f:(fun s ->
      J.obj "signature_item:floating_documentation" [
        ("text", s);
      ]
    )
    |> Li.head

  let type_parameters ~typ_loc typ_params =
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
    | Ttype_open -> (*BISECT-IGNORE*)
      not_handled "type_kind: Ttype_open" typ_loc

  let with_constraint (p, _, constraint_) =
    let type_ {typ_name; typ_params; typ_manifest; typ_loc; _} =
      [
        ("name", string_loc typ_name);
        ("parameters", type_parameters ~typ_loc typ_params);
        ("manifest", type_manifest ~typ_loc typ_manifest);
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
        ("parameters", type_parameters ~typ_loc typ_params);
        ("manifest", type_manifest ~typ_loc typ_manifest);
        ("kind", type_kind ~typ_loc typ_kind);
      ],
      typ_attributes
    )

  let exception_ {ext_id=_; ext_name; ext_type={Types.ext_args; _}; ext_kind=_; ext_loc; ext_attributes} =
    (
      "signature_item:exception",
      [
        ("name", string_loc ext_name);
        ("arguments", ext_args |> Li.map ~f:(type_expr ext_loc) |> J.li);
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
      | Tsig_type [decl] ->
        foo (type_declaration decl)
      | Tsig_type decls ->
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
        ("contents", module_type incl_mod);
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
          (* @todo List elements *)
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
    OCamlStandard.Sys.argv.(1)
    |> Pparse.parse_interface ~tool_name:"autoocamldoc" OCamlStandard.Format.err_formatter
    |> Typemod.type_interface (Compmisc.initial_env ())
    |> TypedtreeToJson.signature
    |> J.to_string
    |> StdOut.print "%s\n"
  with
    exc -> begin (*BISECT-IGNORE*)
      Location.report_exception OCamlStandard.Format.err_formatter exc;
      Exit.(exit (Failure 1)) (*BISECT-IGNORE*)
    end
