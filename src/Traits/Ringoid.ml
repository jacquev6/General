#include "../Generated/Traits/Ringoid.ml"

module Subtract = struct
  include Subtract_.MakeMakers(struct
    let subtract ~negate ~add x y =
      add x (negate y)
  end)
end

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

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open M

    include E

    let additions = additions @ [
      (zero, zero, zero);
      (one, zero, one);
    ]

    let negations = negations @ [
      (zero, zero);
    ]

    let multiplications = multiplications @ [
      (zero, zero, zero);
      (one, zero, zero);
    ]

    let divisions = divisions @ [
      (zero, one, zero);
      (one, one, one);
    ]

    let exponentiations = exponentiations @ [
      (zero, 0, one);
      (zero, 1, zero);
      (zero, 7, zero);
      (one, 0, one);
      (one, 1, one);
      (one, 7, one);
    ]
  end

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M
    open M.O

    let check = check ~repr ~equal

    let tests = (
      E.additions
      |> List.flat_map ~f:(fun (x, y, z) ->
        let rx = repr x and ry = repr y and rz = repr z in
        [
          ~: "add %s %s" rx ry (lazy (check ~expected:z (add x y)));
          ~: "add %s %s" ry rx (lazy (check ~expected:z (add y x)));
          ~: "%s + %s" rx ry (lazy (check ~expected:z (x + y)));
          ~: "%s + %s" ry rx (lazy (check ~expected:z (y + x)));
          ~: "sub %s %s" rz ry (lazy (check ~expected:x (subtract z y)));
          ~: "%s - %s" rz ry (lazy (check ~expected:x (z - y)));
          ~: "sub %s %s" rz rx (lazy (check ~expected:y (subtract z x)));
          ~: "%s - %s" rz rx (lazy (check ~expected:y (z - x)));
        ]
      )
    ) @ (
      E.negations
      |> List.flat_map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "negate %s" rx (lazy (check ~expected:y (negate x)));
          ~: "negate %s" ry (lazy (check ~expected:x (negate y)));
          ~: "-%s" rx (lazy (check ~expected:y (-x)));
          ~: "-%s" ry (lazy (check ~expected:x (-y)));
          ~: "subtract zero %s" rx (lazy (check ~expected:y (subtract zero x)));
          ~: "subtract zero %s" ry (lazy (check ~expected:x (subtract zero y)));
          ~: "zero - %s" rx (lazy (check ~expected:y (zero - x)));
          ~: "zero - %s" ry (lazy (check ~expected:x (zero - y)));
          ~: "add %s %s" rx ry (lazy (check ~expected:zero (add x y)));
          ~: "add %s %s" ry rx (lazy (check ~expected:zero (add y x)));
          ~: "%s + %s" rx ry (lazy (check ~expected:zero (x + y)));
          ~: "%s + %s" ry rx (lazy (check ~expected:zero (y + x)));
          ~: "square %s" rx (lazy (check ~expected:(negate (multiply x y)) (square x)));
          ~: "square %s" ry (lazy (check ~expected:(negate (multiply x y)) (square y)));
        ]
      )
    ) @ (
      E.multiplications
      |> List.flat_map ~f:(fun (x, y, expected) ->
        let rx = repr x and ry = repr y in
        [
          ~: "multiply %s %s" rx ry (lazy (check ~expected (multiply x y)));
          ~: "%s * %s" rx ry (lazy (check ~expected (x * y)));
        ]
      )
    ) @ (
      E.divisions
      |> List.flat_map ~f:(fun (x, y, expected) ->
        let rx = repr x and ry = repr y in
        [
          ~: "divide %s %s" rx ry (lazy (check ~expected (divide x y)));
          ~: "%s / %s" rx ry (lazy (check ~expected (x / y)));
        ]
      )
    ) @ (
      E.exponentiations
      |> List.flat_map ~f:(fun (x, n, expected) ->
        let rx = repr x in
        [
          ~: "exponentiate %s %n" rx n (lazy (check ~expected (exponentiate x n)));
          ~: "%s ** %n" rx n (lazy (check ~expected (x ** n)));
        ]
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
