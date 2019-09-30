#include "../Generated/Facets/Integer.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module PredSuccTests = PredSucc.Tests_beta(Testing)
  module OfFloatTests = OfFloat.Tests_beta(Testing)
  module DisplayableTests = Displayable.Tests_beta(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module PredSuccTesters = PredSuccTests.MakeTesters(M)
    module OfFloatTesters = OfFloatTests.MakeTesters(M)
    module DisplayableTesters = DisplayableTests.MakeTesters(M)

    let tests = []
      @ (PredSuccTesters.test_succession ((M.zero, "zero"), (M.one, "one")))
      @ (OfFloatTesters.test_conversion (-0.99, M.zero))
      @ (OfFloatTesters.test_conversion (0.99, M.zero))
      @ (OfFloatTesters.test_conversion (1.99, M.one))
      @ (DisplayableTesters.test_conversion ((M.zero, "zero"), "0"))
      @ (DisplayableTesters.test_conversion ((M.one, "one"), "1"))
      @ (E.values |> List.flat_map ~f:(fun x -> let y = M.add x M.one in PredSuccTesters.test_succession ((x, M.repr x), (y, M.repr y))))
  end)
end
