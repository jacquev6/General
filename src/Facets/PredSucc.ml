#include "../Generated/Facets/PredSucc.ml"

module PredSucc = struct
  include PredSucc_.MakeMakers(struct
    let pred ~one ~add:_ ~subtract x = subtract x one
    let succ ~one ~add ~subtract:_ x = add x one
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_succession: (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let check_m = M.(check ~repr ~equal)

    let test_succession ((x, rx), (y, ry)) = [
      ~: "PredSucc: succ %s" rx (lazy (M.succ x |> check_m ~expected:y));
      ~: "PredSucc: pred %s" ry (lazy (M.pred y |> check_m ~expected:x));
    ]
  end

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let successions =
      E.successions
      |> List.map ~f:(fun (x, y) -> ((x, M.repr x), (y, M.repr y)))
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = MakeExpectations(M)(E)
    module Testers = MakeTesters(M)

    let tests = []
      @ (List.flat_map Expectations.successions ~f:Testers.test_succession)
  end)
end
