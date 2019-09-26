#include "../Generated/Facets/RealNumber.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  (*
  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    include E

    let strict_orders = strict_orders @ [
      [M.zero; M.one];
    ]
  end
  *)

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing

    let tests = (
      E.negations
      |> List.flat_map ~f:(fun (x, y) ->
        let abs_x = M.(if greater_or_equal x zero then x else y)
        and abs_y = M.(if greater_or_equal y zero then y else x) in
        [
          ~: "abs %s" (M.repr x) (lazy M.(check ~repr ~equal ~expected:abs_x (abs x)));
          ~: "abs %s" (M.repr y) (lazy M.(check ~repr ~equal ~expected:abs_y (abs y)));
        ]
      )
    ) @ [
      "to_int zero" >: (lazy (check_int ~expected:0 M.(to_int zero)));
      "to_float zero" >: (lazy (check_float_exact ~expected:0. M.(to_float zero)));
      "to_int one" >: (lazy (check_int ~expected:1 M.(to_int one)));
      "to_float one" >: (lazy (check_float_exact ~expected:1. M.(to_float one)));
    ]
  end

  include MakeMakers(MakeTests)
end
