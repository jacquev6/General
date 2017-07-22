let () =
  General.test
  |> Testing.run
  |> Testing.report_to_console
