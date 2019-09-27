#include "../Generated/Facets/RingoidBasic.ml"

module Subtract = struct
  include Subtract_.MakeMakers(struct
    let subtract ~negate ~add x y =
      add x (negate y)
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0): sig
    val test_value: M.t * string -> Test.t list
    val test_addition: (M.t * string) * (M.t * string) * (M.t * string) -> Test.t list
    val test_negation: (M.t * string) * (M.t * string) -> Test.t list
    val test_multiplication: (M.t * string) * (M.t * string) * (M.t * string) -> Test.t list
    val test_division: (M.t * string) * (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let equal_mr = Tuple2.equal ~equal_a:M.equal ~equal_b:String.equal

    let check_m = M.(check ~repr ~equal)

    let zero = (M.zero, "zero")
    let one = (M.one, "one")

    let test_addition' ((x, rx), (y, ry), (z, rz)) = [
      ~: "RingoidBasic: add %s %s" rx ry (lazy (M.add x y |> check_m ~expected:z));
      ~: "RingoidBasic: subtract %s %s" rz rx (lazy (M.subtract z x |> check_m ~expected:y));
    ]

    let test_addition (x, y, z) =
      if equal_mr x y then
        test_addition' (x, y, z)
      else
        (test_addition' (x, y, z)) @ (test_addition' (y, x, z))

    let test_negation' ((x, rx), (y, ry)) =
      [
        ~: "RingoidBasic: negate %s" rx (lazy (M.negate x |> check_m ~expected:y));
      ]
      @ test_addition' ((x, rx), (y, ry), (M.zero, "zero"))

    let test_negation (x, y) =
      if equal_mr x y then
        test_negation' (x, y)
      else
        (test_negation' (x, y)) @ (test_negation' (y, x))

    let test_multiplication' ((x, rx), (y, ry), (z, _rz)) = [
      ~: "RingoidBasic: multiply %s %s" rx ry (lazy (M.multiply x y |> check_m ~expected:z));
    ]

    let test_multiplication (x, y, z) =
      if equal_mr x y then
        test_multiplication' (x, y, z)
      else
        (test_multiplication' (x, y, z)) @ (test_multiplication' (y, x, z))

    let test_division ((x, rx), (y, ry), (z, _rz)) = [
      ~: "RingoidBasic: divide %s %s" rx ry (lazy (M.divide x y |> check_m ~expected:z));
    ]

    let test_value x = []
      @ (test_addition (x, zero, x))
      @ (test_multiplication (x, one, x))
      @ (test_multiplication (x, zero, zero))
      @ (test_division (x, one, x))
  end

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let values =
      E.values
      |> List.map ~f:(fun x -> (x, M.repr x))

    let additions =
      E.additions
      |> List.map ~f:(fun (x, y, z) -> ((x, M.repr x), (y, M.repr y), (z, M.repr z)))

    let negations =
      E.negations
      |> List.map ~f:(fun (x, y) -> ((x, M.repr x), (y, M.repr y)))

    let multiplications =
      E.multiplications
      |> List.map ~f:(fun (x, y, z) -> ((x, M.repr x), (y, M.repr y), (z, M.repr z)))

    let divisions =
      E.divisions
      |> List.map ~f:(fun (x, y, z) -> ((x, M.repr x), (y, M.repr y), (z, M.repr z)))
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = MakeExpectations(M)(E)
    module Testers = MakeTesters(M)

    let zero = (M.zero, "zero")
    let one = (M.one, "one")

    let tests = []
      @ (List.flat_map Expectations.values ~f:Testers.test_value)
      @ (List.flat_map Expectations.additions ~f:Testers.test_addition)
      @ (List.flat_map Expectations.negations ~f:Testers.test_negation)
      @ (List.flat_map Expectations.multiplications ~f:Testers.test_multiplication)
      @ (List.flat_map Expectations.divisions ~f:Testers.test_division)
      @ (Testers.test_value zero)
      @ (Testers.test_value one)
      @ (Testers.test_negation (zero, zero))
  end)
end
