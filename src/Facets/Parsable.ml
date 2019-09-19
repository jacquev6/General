#include "../Generated/Facets/Parsable.ml"

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M

    let tests = (
      E.literals
      |> List.flat_map ~f:(fun (s, expected) ->
        [
          ~: "of_string %S" s (lazy (check ~repr ~equal ~expected (of_string s)));
          ~: "try_of_string %S" s (lazy (check_some ~repr ~equal ~expected (try_of_string s)));
        ]
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
