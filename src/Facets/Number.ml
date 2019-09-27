#include "../Generated/Facets/Number.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module EquatableTests = Equatable.Tests_beta(Testing)
  module OfIntTests = OfInt.Tests_beta(Testing)
  module OfFloatTests = OfFloat.Tests_beta(Testing)
  module ParsableTests = Parsable.Tests_beta(Testing)
  module DisplayableTests = Displayable.Tests_beta(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module EquatableTesters = EquatableTests.MakeTesters(M)
    module OfIntTesters = OfIntTests.MakeTesters(M)
    module OfFloatTesters = OfFloatTests.MakeTesters(M)
    module ParsableTesters = ParsableTests.MakeTesters(M)(E)
    module DisplayableTesters = DisplayableTests.MakeTesters(M)

    let tests = []
      @ (EquatableTesters.test_different_pair ((M.zero, "zero"), (M.one, "one")))
      @ (OfIntTesters.test_conversion (0, M.zero))
      @ (OfIntTesters.test_conversion (1, M.one))
      @ (OfFloatTesters.test_conversion (-0.99, M.zero))
      @ (OfFloatTesters.test_conversion (0., M.zero))
      @ (OfFloatTesters.test_conversion (0.99, M.zero))
      @ (OfFloatTesters.test_conversion (1., M.one))
      @ (OfFloatTesters.test_conversion (1.99, M.one))
      @ (ParsableTesters.test_conversion ("0", M.zero))
      @ (ParsableTesters.test_conversion ("1", M.one))
      @ (DisplayableTesters.test_conversion ((M.zero, "zero"), "0"))
      @ (DisplayableTesters.test_conversion ((M.one, "one"), "1"))
  end)
end
