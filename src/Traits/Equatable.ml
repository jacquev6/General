module Basic = struct
  module type S0 = sig
    type t

    val equal: t -> t -> bool
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (=): t -> t -> bool
    val (<>): t -> t -> bool
  end
end

module type S0 = sig
  include Basic.S0

  val different: t -> t -> bool

  module O: Operators.S0 with type t := t
end

module Make0(B: Basic.S0) = struct
  include B

  let different x y =
    Pervasives.not (equal x y)

  module O = struct
    let (=) x y =
      equal x y

    let (<>) x y =
      different x y
  end
end

module Examples = struct
  module type S0 = sig
    type t

    val equal: t list list
    val different: (t * t) list
  end
end

module Tests = struct
  module Make0(M: sig
    include S0
    include Representable.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open StdLabels

    open M
    open M.O

    (* @todo (Make terminal recursive and) Put in General.List *)
    let rec cartesian_product xs ys =
      match xs with
        | [] -> []
        | x::xs -> (List.map ys ~f:(fun y -> (x, y))) @ (cartesian_product xs ys)

    let test = "Equatable" >:: (
      E.equal
      |> List.map ~f:(fun xs ->
        cartesian_product xs xs
        |> List.map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "equal %s %s" rx ry (lazy (check_true (equal x y)));
            ~: "different %s %s" rx ry (lazy (check_false (different x y)));
            ~: "%s = %s" rx ry (lazy (check_true (x = y)));
            ~: "%s <> %s" rx ry (lazy (check_false (x <> y)));

            ~: "equal %s %s" ry rx (lazy (check_true (equal y x)));
            ~: "different %s %s" ry rx (lazy (check_false (different y x)));
            ~: "%s = %s" ry rx (lazy (check_true (y = x)));
            ~: "%s <> %s" ry rx (lazy (check_false (y <> x)));
          ]
        )
        |> List.concat
      )
      |> List.concat
    ) @ (
      E.different
      |> List.map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "equal %s %s" rx ry (lazy (check_false (equal x y)));
          ~: "different %s %s" rx ry (lazy (check_true (different x y)));
          ~: "%s = %s" rx ry (lazy (check_false (x = y)));
          ~: "%s <> %s" rx ry (lazy (check_true (x <> y)));

          ~: "equal %s %s" ry rx (lazy (check_false (equal y x)));
          ~: "different %s %s" ry rx (lazy (check_true (different y x)));
          ~: "%s = %s" ry rx (lazy (check_false (y = x)));
          ~: "%s <> %s" ry rx (lazy (check_true (y <> x)));
        ]
      )
      |> List.concat
    )
  end
end
