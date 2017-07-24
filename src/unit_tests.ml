let test = Testing.("General" >:: [
  BuiltinTypes_Tests.Float_Tests.test;
  BuiltinTypes_Tests.Int_Tests.test;
])

let () =
  test
  |> Testing.run
  |> Testing.report_to_console
