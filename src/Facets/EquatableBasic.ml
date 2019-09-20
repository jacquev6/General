#include "../Generated/Facets/EquatableBasic.ml"

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M

    let tests = (
      E.equalities
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "equal %s %s" rx ry (lazy (check_true (equal x y)));
            ~: "equal %s %s" ry rx (lazy (check_true (equal y x)));
          ]
        )
      )
    ) @ (
      E.differences
      |> List.flat_map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "equal %s %s" rx ry (lazy (check_false (equal x y)));
          ~: "equal %s %s" ry rx (lazy (check_false (equal y x)));
        ]
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
