open Abbr_

include (Traits_.Ringoid_: module type of Ringoid_)

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val add_substract: (t * t * t) list
      val negate: (t * t) list
      val multiply: (t * t * t) list
      val divide: (t * t * t) list
    end
  end

  module Make0(M: sig
    include S0
    include Representable_.Basic.S0 with type t := t
    include Equatable_.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M
    open M.O

    module E = struct
      include E

      let add_substract = add_substract @ [
        (zero, zero, zero);
        (one, zero, one);
      ]

      let negate = negate @ [
        (zero, zero);
      ]

      let multiply = multiply @ [
        (zero, zero, zero);
        (one, zero, zero);
      ]

      let divide = divide @ [
        (zero, one, zero);
        (one, one, one);
      ]
    end

    let check = check ~repr ~equal

    let test = "Ringoid" >:: (
      E.add_substract
      |> Li.concat_map ~f:(fun (x, y, z) ->
        let rx = repr x and ry = repr y and rz = repr z in
        [
          ~: "add %s %s" rx ry (lazy (check ~expected:z (add x y)));
          ~: "add %s %s" ry rx (lazy (check ~expected:z (add y x)));
          ~: "%s + %s" rx ry (lazy (check ~expected:z (x + y)));
          ~: "%s + %s" ry rx (lazy (check ~expected:z (y + x)));
          ~: "sub %s %s" rz ry (lazy (check ~expected:x (substract z y)));
          ~: "%s - %s" rz ry (lazy (check ~expected:x (z - y)));
          ~: "sub %s %s" rz rx (lazy (check ~expected:y (substract z x)));
          ~: "%s - %s" rz rx (lazy (check ~expected:y (z - x)));
        ]
      )
    ) @ (
      E.negate
      |> Li.concat_map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "negate %s" rx (lazy (check ~expected:y (negate x)));
          ~: "negate %s" ry (lazy (check ~expected:x (negate y)));
          ~: "-%s" rx (lazy (check ~expected:y (-x)));
          ~: "-%s" ry (lazy (check ~expected:x (-y)));
          ~: "substract zero %s" rx (lazy (check ~expected:y (substract zero x)));
          ~: "substract zero %s" ry (lazy (check ~expected:x (substract zero y)));
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
      E.multiply
      |> Li.concat_map ~f:(fun (x, y, z) ->
        let rx = repr x and ry = repr y in
        [
          ~: "multiply %s %s" rx ry (lazy (check ~expected:z (multiply x y)));
          ~: "%s * %s" rx ry (lazy (check ~expected:z (x * y)));
        ]
      )
    ) @ (
      E.divide
      |> Li.concat_map ~f:(fun (x, y, z) ->
        let rx = repr x and ry = repr y in
        [
          ~: "divide %s %s" rx ry (lazy (check ~expected:z (divide x y)));
          ~: "%s / %s" rx ry (lazy (check ~expected:z (x / y)));
        ]
      )
    )
  end
end
