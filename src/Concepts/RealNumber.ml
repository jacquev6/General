include (Concepts_.RealNumber_: module type of Concepts_.RealNumber_)

module Tests = struct
  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open StdLabels

    open M

    module E = struct
      include E

      let ordered = ordered @ [
        [zero; one];
      ]
    end

    let check = check ~repr ~equal

    let test = "RealNumber" >:: [
      (let module T = Number.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
    ] @ (
      E.negate
      |> List.map ~f:(fun (x, y) ->
        let abs_x = if greater_or_equal x zero then x else y
        and abs_y = if greater_or_equal y zero then y else x in
        [
          ~: "abs %s" (repr x) (lazy (check ~expected:abs_x (abs x)));
          ~: "abs %s" (repr y) (lazy (check ~expected:abs_y (abs y)));
        ]
      )
      |> List.concat
    ) @ [
      "to_int zero" >: (lazy (check_int ~expected:0 (to_int zero)));
      "to_float zero" >: (lazy (check_float_exact ~expected:0. (to_float zero)));
      "to_int one" >: (lazy (check_int ~expected:1 (to_int one)));
      "to_float one" >: (lazy (check_float_exact ~expected:1. (to_float one)));
    ]
  end
end
