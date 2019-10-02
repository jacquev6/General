#include "../Generated/Facets/RealNumber.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module ComparableTests = Comparable.Tests_beta(Testing)
  module RingoidTests = Ringoid.Tests_beta(Testing)
  module ToIntTests = ToInt.Tests_beta(Testing)
  module ToFloatTests = ToFloat.Tests_beta(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_negation: (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let check_m = M.(check ~repr ~equal)

    let test_negation ((x, rx), (y, ry)) = [
      ~: "RealNumber: abs %s" rx (lazy (M.abs x |> check_m ~expected:x));
      ~: "RealNumber: abs %s" ry (lazy (M.abs y |> check_m ~expected:x));
    ]
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = RingoidTests.MakeExpectations(M)(E)
    module Testers = MakeTesters(M)
    module ComparableTesters = ComparableTests.MakeTesters(M)
    module ToIntTesters = ToIntTests.MakeTesters(M)
    module ToFloatTesters = ToFloatTests.MakeTesters(M)

    let zero = (M.zero, "zero")
    let one = (M.one, "one")

    let tests = []
      @ (List.flat_map Expectations.negations ~f:Testers.test_negation)
      @ (ComparableTesters.test_ordered_pair (zero, one))
      @ (ToIntTesters.test_conversion (zero, 0))
      @ (ToIntTesters.test_conversion (one, 1))
      @ (ToFloatTesters.test_conversion (zero, 0.))
      @ (ToFloatTesters.test_conversion (one, 1.))
  end)
end
