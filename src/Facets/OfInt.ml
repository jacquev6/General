#include "../Generated/Facets/OfInt.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_conversion: int * M.t -> Test.t list
  end = struct
    open Testing

    let check_m = M.(check ~equal ~repr)

    let test_conversion (x, y) = [
      ~: "OfInt: of_int %i" x (lazy (M.of_int x |> check_m ~expected:y));
    ]
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Testers = MakeTesters(M)

    let tests = []
      @ (List.flat_map E.conversions_from_int ~f:Testers.test_conversion)
  end)
end
