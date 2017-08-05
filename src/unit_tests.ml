open Implementation

module DummyForCoverage = Specializations
module OCSS = OCamlStandard.Sys

open Testing

let test = "General" >:: [
  BigInt.Tests.test;
  Bool.Tests.test;
  CallStack.Tests.test;
  Exception.Tests.test;
  Float.Tests.test;
  Functions.Tests.test;
  Int.Tests.test;
  Int32_.Tests.test;
  Int64_.Tests.test;
  Lazy_.Tests.test;
  List_.Tests.test;
  NativeInt_.Tests.test;
  Option.Tests.test;
  String_.Tests.test;
  Tuples.Tests.test;

  TestingTests.Tests.test;
]


let () =
  let argv = List_.of_array OCSS.argv in
  Exit.exit (command_line_main ~argv test)
