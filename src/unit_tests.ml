open Implementation

open Testing

let test = "General" >:: [
  Bool.Tests.test;
  Exception.Tests.test;
  Float.Tests.test;
  Int.Tests.test;
  Option.Tests.test;
  String_.Tests.test;
  TestingTests.Tests.test;
]

let () =
  let argv = OCamlStandard.(Array.to_list Sys.argv) in
  Exit.exit (command_line_main ~argv test)
