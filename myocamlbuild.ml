let () = Ocamlbuild_plugin.dispatch (fun hook ->
  Ocamlbuild_cppo.dispatcher hook;
  Ocamlbuild_js_of_ocaml.dispatcher hook
)
