let test = Testing.("General" >:: [
  BuiltinTypes.Float.test;
  BuiltinTypes.Int.test;
])

let () =
  test
  |> Testing.run
  |> Testing.report_to_console
