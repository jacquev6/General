module Generated = struct
  #include "../Generated/Traits/Representable.ml"
end

include Generated

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing

    let tests = (
      E.repr
      |> List.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (M.repr v)))
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
