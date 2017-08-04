open Implementation

open Testing

let test = "General" >:: [
  BigInt.Tests.test;
  Bool.Tests.test;
  Exception.Tests.test;
  Float.Tests.test;
  Functions.Tests.test;
  Int.Tests.test;
  Lazy_.Tests.test;
  List_.Tests.test;
  Option.Tests.test;
  String_.Tests.test;
  Tuples.Tests.test;

  TestingTests.Tests.test;
]

let () =
  let argv = OCamlStandard.(Array.to_list Sys.argv) in
  Exit.exit (command_line_main ~argv test)
