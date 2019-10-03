#include "../Generated/Facets/Equatable.ml"

module Different = struct
  include Different_.MakeMakers(struct
    let different ~equal x y = not (equal x y)
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeOwnTesters(M: Testable.S0): sig
    val test_value: M.t * string -> Test.t list
    val test_equal_pair: (M.t * string) * (M.t * string) -> Test.t list
    val test_different_pair: (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let test_equal_pair' ((x, rx), (y, ry)) = [
      ~: "Equatable: %s = %s" rx ry (lazy (M.O.(x = y) |> check_true));
      ~: "Equatable: different %s %s" rx ry (lazy (M.different x y |> check_false));
      ~: "Equatable: %s <> %s" rx ry (lazy (M.O.(x <> y) |> check_false));
    ]

    let test_value x = test_equal_pair' (x, x)

    let test_equal_pair (x, y) =
      if Tuple2.equal ~equal_a:Equate.Phys.equal ~equal_b:String.equal x y then
        test_equal_pair' (x, y)
      else
        (test_equal_pair' (x, y)) @ (test_equal_pair' (y, x))

    let test_different_pair' ((x, rx), (y, ry)) = [
      ~: "Equatable: %s = %s" rx ry (lazy (M.O.(x = y) |> check_false));
      ~: "Equatable: different %s %s" rx ry (lazy (M.different x y |> check_true));
      ~: "Equatable: %s <> %s" rx ry (lazy (M.O.(x <> y) |> check_true));
    ]

    let test_different_pair (x, y) =
      (test_different_pair' (x, y)) @ (test_different_pair' (y, x))
  end

  module EquatableBasicTests = EquatableBasic.Tests_beta(Testing)

  module MakeTesters(M: Testable.S0) = struct
    module EquatableBasicTesters = EquatableBasicTests.MakeTesters(M)
    module EquatableTesters = MakeOwnTesters(M)

    (* let test_value x =
      (EquatableBasicTesters.test_value x) @ (EquatableTesters.test_value x) *)

    (* let test_equal_pair p =
      (EquatableBasicTesters.test_equal_pair p) @ (EquatableTesters.test_equal_pair p) *)

    let test_different_pair p =
      (EquatableBasicTesters.test_different_pair p) @ (EquatableTesters.test_different_pair p)
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = EquatableBasicTests.MakeExpectations(M)(E)
    module Testers = MakeOwnTesters(M)

    let tests = []
      @ (List.flat_map Expectations.values ~f:Testers.test_value)
      @ (List.flat_map Expectations.equal_pairs ~f:Testers.test_equal_pair)
      @ (List.flat_map Expectations.different_pairs ~f:Testers.test_different_pair)
  end)
end
