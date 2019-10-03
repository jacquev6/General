#include "../Generated/Facets/ComparableBasic.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_value: M.t * string -> Test.t list
    val test_equivalent_pair: (M.t * string) * (M.t * string) -> Test.t list
    val test_ordered_pair: (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let test_equivalent_pair' ((x, rx), (y, ry)) = [
      ~: "ComparableBasic: compare %s %s" rx ry (lazy (M.compare x y |> check_eq));
    ]

    let test_value x = test_equivalent_pair' (x, x)

    let test_equivalent_pair (x, y) =
      if Tuple2.equal ~equal_a:Equate.Phys.equal ~equal_b:String.equal x y then
        test_equivalent_pair' (x, y)
      else
        (test_equivalent_pair' (x, y)) @ (test_equivalent_pair' (y, x))

    let test_ordered_pair ((x, rx), (y, ry)) =
      [
        ~: "ComparableBasic: compare %s %s" rx ry (lazy (M.compare x y |> check_lt));
        ~: "ComparableBasic: compare %s %s" ry rx (lazy (M.compare y x |> check_gt));
      ]
  end

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let values =
      E.values
      |> List.map ~f:(fun x -> (x, M.repr x))

    let equivalent_pairs =
      E.order_classes
      |> List.flat_map ~f:(fun xs -> List.cartesian_product xs xs)
      |> List.map ~f:(fun (x, y) -> ((x, M.repr x), (y, M.repr y)))

    let ordered_pairs =
      E.strict_orders
      |> List.flat_map ~f:(fun xs ->
        let ixs = List.map_i xs ~f:(fun ~i x -> (i, x)) in
        List.cartesian_product ixs ixs
        |> List.filter_map ~f:(fun ((ix, x), (iy, y)) -> Option.some_if' (ix < iy) (x, y))
      )
      |> List.map ~f:(fun (x, y) -> ((x, M.repr x), (y, M.repr y)))
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = MakeExpectations(M)(E)
    module Testers = MakeTesters(M)

    let tests = []
      @ (List.flat_map Expectations.values ~f:Testers.test_value)
      @ (List.flat_map Expectations.equivalent_pairs ~f:Testers.test_equivalent_pair)
      @ (List.flat_map Expectations.ordered_pairs ~f:Testers.test_ordered_pair)
  end)
end
