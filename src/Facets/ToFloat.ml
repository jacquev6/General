#include "../Generated/Facets/ToFloat.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_conversion: (M.t * string) * float -> Test.t list
  end = struct
    open Testing

    let test_conversion ((x, rx), y) = [
      ~: "ToFloat: to_float %s" rx (lazy (M.to_float x |> check_float_exact ~expected:y));
    ]
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Testers = MakeTesters(M)

    let tests = []
      @ (List.flat_map E.conversions_to_float ~f:(fun (x, y) -> Testers.test_conversion ((x, M.repr x), y)))
  end)
end
