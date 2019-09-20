#include "../Generated/Facets/Equatable.ml"

module Different = struct
  include Different_.MakeMakers(struct
    let different ~equal x y = not (equal x y)
  end)
end

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M
    open M.O

    let tests = (
      E.equalities
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "different %s %s" rx ry (lazy (check_false (different x y)));
            ~: "%s = %s" rx ry (lazy (check_true (x = y)));
            ~: "%s <> %s" rx ry (lazy (check_false (x <> y)));

            ~: "different %s %s" ry rx (lazy (check_false (different y x)));
            ~: "%s = %s" ry rx (lazy (check_true (y = x)));
            ~: "%s <> %s" ry rx (lazy (check_false (y <> x)));
          ]
        )
      )
    ) @ (
      E.differences
      |> List.flat_map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "different %s %s" rx ry (lazy (check_true (different x y)));
          ~: "%s = %s" rx ry (lazy (check_false (x = y)));
          ~: "%s <> %s" rx ry (lazy (check_true (x <> y)));

          ~: "different %s %s" ry rx (lazy (check_true (different y x)));
          ~: "%s = %s" ry rx (lazy (check_false (y = x)));
          ~: "%s <> %s" ry rx (lazy (check_true (y <> x)));
        ]
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
