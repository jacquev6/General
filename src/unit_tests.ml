let test = Testing.("General" >:: [
  BuiltinTypes.Float.Tests.test;
  BuiltinTypes.Int.Tests.test;
])

let () =
  test
  |> Testing.run
  |> Testing.report_to_console
