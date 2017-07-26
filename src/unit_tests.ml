open Abbr_
open Testing_

let test = "General" >:: [
  BuiltinTypes.Bool.Tests.test;
  BuiltinTypes.Exception.Tests.test;
  BuiltinTypes.Float.Tests.test;
  BuiltinTypes.Int.Tests.test;
  BuiltinTypes.Option.Tests.test;
  BuiltinTypes.String'.Tests.test;
  Testing.Tests.test;
]

let () =
  let argv = OCamlStandard.(Array.to_list Sys.argv) in
  exit (command_line_main ~argv test)
