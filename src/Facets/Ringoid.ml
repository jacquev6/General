#include "../Generated/Facets/Ringoid.ml"

module Square = struct
  include Square_.MakeMakers(struct
    let square ~multiply x =
      multiply x x
  end)
end

module Exponentiate = struct
  include Exponentiate_.MakeMakers(struct
    let exponentiate ~one ~square ~multiply ~exponentiate_negative_exponent x n =
      let rec aux y x n =
        if n < 0 then
          exponentiate_negative_exponent ~exponentiate:(aux one) x n
        else if n = 0 then
          y
        else if n = 1 then
          multiply x y
        else if n mod 2 = 0 then
          aux y (square x) (n / 2)
        else
          aux (multiply x y) (square x) ((n - 1) / 2)
      in
      aux one x n
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
    val test_exponentiation: (M.t * string) * int * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let equal_mr = Tuple2.equal ~equal_a:M.equal ~equal_b:String.equal

    let check_m = M.(check ~repr ~equal)

    let zero = (M.zero, "zero")
    let one = (M.one, "one")

    let test_addition' ((x, rx), (y, ry), (z, rz)) = [
      ~: "Ringoid: %s + %s" rx ry (lazy (M.O.(x + y) |> check_m ~expected:z));
      ~: "Ringoid: %s - %s" rz rx (lazy (M.O.(z - x) |> check_m ~expected:y));
    ]

    let test_addition (x, y, z) =
      if equal_mr x y then
        test_addition' (x, y, z)
      else
        (test_addition' (x, y, z)) @ (test_addition' (y, x, z))

    let test_negation' ((x, rx), (y, ry)) =
      [
        ~: "Ringoid: - %s" rx (lazy (M.O.(-x) |> check_m ~expected:y));
      ]
      @ test_addition' ((x, rx), (y, ry), (M.zero, "zero"))

    let test_negation (x, y) =
      if equal_mr x y then
        test_negation' (x, y)
      else
        (test_negation' (x, y)) @ (test_negation' (y, x))

    let test_multiplication' ((x, rx), (y, ry), (z, _rz)) = [
      ~: "Ringoid: %s * %s" rx ry (lazy (M.O.(x * y) |> check_m ~expected:z));
    ]

    let test_multiplication (x, y, z) =
      if equal_mr x y then
        test_multiplication' (x, y, z)
      else
        (test_multiplication' (x, y, z)) @ (test_multiplication' (y, x, z))

    let test_division ((x, rx), (y, ry), (z, _rz)) = [
      ~: "Ringoid: %s / %s" rx ry (lazy (M.O.(x / y) |> check_m ~expected:z));
    ]

    let test_exponentiation ((x, rx), y, (z, _rz)) = [
      ~: "Ringoid: exponentiate %s %i" rx y (lazy (M.exponentiate x y |> check_m ~expected:z));
      ~: "Ringoid: %s ** %i" rx y (lazy (M.O.(x ** y) |> check_m ~expected:z));
    ]

    let test_value x = []
      @ (test_addition (x, zero, x))
      @ (test_multiplication (x, one, x))
      @ (test_multiplication (x, zero, zero))
      @ (test_division (x, one, x))
      @ (test_exponentiation (x, 1, x))
      @ (test_exponentiation (x, 0, one))
  end

  module RingoidBasicTests = RingoidBasic.Tests_beta(Testing)

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    include RingoidBasicTests.MakeExpectations(M)(E)

    let exponentiations =
      E.exponentiations
      |> List.map ~f:(fun (x, y, z) -> ((x, M.repr x), y, (z, M.repr z)))
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
      @ (List.flat_map Expectations.exponentiations ~f:Testers.test_exponentiation)
      @ (Testers.test_value zero)
      @ (Testers.test_value one)
      @ (Testers.test_negation (zero, zero))
      @ (Testers.test_exponentiation (zero, 7, zero))
      @ (Testers.test_exponentiation (one, 42, one))
  end)
end
