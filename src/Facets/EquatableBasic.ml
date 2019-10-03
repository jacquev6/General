#include "../Generated/Facets/EquatableBasic.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_value: M.t * string -> Test.t list
    val test_equal_pair: (M.t * string) * (M.t * string) -> Test.t list
    val test_different_pair: (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let test_equal_pair' ((x, rx), (y, ry)) = [
      ~: "EquatableBasic: equal %s %s" rx ry (lazy (M.equal x y |> check_true));
    ]

    let test_value x = test_equal_pair' (x, x)

    let test_equal_pair (x, y) =
      if Tuple2.equal ~equal_a:Equate.Phys.equal ~equal_b:String.equal x y then
        test_equal_pair' (x, y)
      else
        (test_equal_pair' (x, y)) @ (test_equal_pair' (y, x))

    let test_different_pair' ((x, rx), (y, ry)) = [
      ~: "EquatableBasic: equal %s %s" rx ry (lazy (M.equal x y |> check_false));
    ]

    let test_different_pair (x, y) =
      (test_different_pair' (x, y)) @ (test_different_pair' (y, x))
  end

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let values =
      E.values
      |> List.map ~f:(fun x -> (x, M.repr x))

    let equal_pairs =
      E.equalities
      |> List.flat_map ~f:(fun xs -> List.cartesian_product xs xs)
      |> List.map ~f:(fun (x, y) -> ((x, M.repr x), (y, M.repr y)))

    let different_pairs =
      E.differences
      |> List.map ~f:(fun (x, y) -> ((x, M.repr x), (y, M.repr y)))
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = MakeExpectations(M)(E)
    module Testers = MakeTesters(M)

    let tests = []
      @ (List.flat_map Expectations.values ~f:Testers.test_value)
      @ (List.flat_map Expectations.equal_pairs ~f:Testers.test_equal_pair)
      @ (List.flat_map Expectations.different_pairs ~f:Testers.test_different_pair)
  end)
end
