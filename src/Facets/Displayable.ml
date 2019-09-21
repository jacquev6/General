#include "../Generated/Facets/Displayable.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M

    let tests = (
      E.displays
      |> List.map ~f:(fun (v, expected) ->
        ~: "to_string %s" expected (lazy (check_string ~expected (to_string v)))
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
