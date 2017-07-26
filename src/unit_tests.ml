let test = Testing.("General" >:: [
  BuiltinTypes.Float.Tests.test;
  BuiltinTypes.Int.Tests.test;
])

let () =
  Testing.report_to_console (Testing.run test)
