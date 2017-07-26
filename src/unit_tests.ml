let test = Testing.("General" >:: [
  BuiltinTypes.Bool.Tests.test;
  BuiltinTypes.Exception.Tests.test;
  BuiltinTypes.Float.Tests.test;
  BuiltinTypes.Int.Tests.test;
  BuiltinTypes.Option.Tests.test;
  BuiltinTypes.StringInternal.Tests.test;
])

let () =
  Testing.report_to_console (Testing.run test)
