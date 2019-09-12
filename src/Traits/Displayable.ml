#include "../Generated/Traits/Displayable.ml"

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M

    let tests = (
      E.to_string
      |> List.map ~f:(fun (v, expected) ->
        ~: "to_string %s" expected (lazy (check_string ~expected (to_string v)))
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
