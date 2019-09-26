#include "../Generated/Facets/ComparableBasic.ml"

(* @todo Test compare like we test everything in Comparable.ml *)

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let equal_pairs =
      E.order_classes
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = M.repr x and ry = M.repr y in
          let pairs = [(y, ry, x, rx)] in
          if Equate.Phys.equal x y then pairs else (x, rx, y, ry)::pairs
        )
      )

    let ordered_pairs =
      E.strict_orders
      |> List.flat_map ~f:(fun xs ->
        List.fold ~init:(List.head xs, []) (List.tail xs) ~f:(fun (x, pairs) y ->
          let rx = M.repr x and ry = M.repr y in
          (y, (x, rx, y, ry)::pairs)
        )
        |> Tuple2.get_1
      )
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let tests =
      let module Expectations = MakeExpectations(M)(E) in []
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "compare %s %s" rx ry (lazy (M.compare x y |> check_eq))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "compare %s %s" rx ry (lazy (M.compare x y |> check_lt));
        ~: "compare %s %s" ry rx (lazy (M.compare y x |> check_gt));
      ]))
  end)
end
