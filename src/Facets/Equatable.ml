#include "../Generated/Facets/Equatable.ml"

module Different = struct
  include Different_.MakeMakers(struct
    let different ~equal x y = not (equal x y)
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module EquatableBasicTests = EquatableBasic.Tests_beta(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let tests =
      let module Expectations = EquatableBasicTests.MakeExpectations(M)(E) in []
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s = %s" rx ry (lazy (M.O.(x = y) |> check_true))
      ))
      @ (List.map Expectations.different_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s = %s" rx ry (lazy (M.O.(x = y) |> check_false))
      ))

      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "different %s %s" rx ry (lazy (M.different x y |> check_false))
      ))
      @ (List.map Expectations.different_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "different %s %s" rx ry (lazy (M.different x y |> check_true))
      ))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s <> %s" rx ry (lazy (M.O.(x <> y) |> check_false))
      ))
      @ (List.map Expectations.different_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s <> %s" rx ry (lazy (M.O.(x <> y) |> check_true))
      ))
  end)
end
