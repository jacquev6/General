module Generated = struct
  #include "../Generated/Traits/Equatable.ml"
end

include Generated

module Different = struct
  module Make0(M: sig
    type t

    val equal: t -> t
      -> bool
  end) = struct
    open M

    let different x y =
      not (equal x y)
  end

  module Make1(M: sig
    type 'a t

    val equal: 'a t -> 'a t
      -> equal_a:('a -> 'a -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a =
      not (equal x y ~equal_a)
  end

  module Make2(M: sig
    type ('a, 'b) t

    val equal: ('a, 'b) t -> ('a, 'b) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b =
      not (equal x y ~equal_a ~equal_b)
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> equal_c:('c -> 'c -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b ~equal_c =
      not (equal x y ~equal_a ~equal_b ~equal_c)
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> equal_c:('c -> 'c -> bool)
      -> equal_d:('d -> 'd -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b ~equal_c ~equal_d =
      not (equal x y ~equal_a ~equal_b ~equal_c ~equal_d)
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> equal_c:('c -> 'c -> bool)
      -> equal_d:('d -> 'd -> bool)
      -> equal_e:('e -> 'e -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e =
      not (equal x y ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e)
  end
end

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M
    open M.O

    let tests = (
      E.equal
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
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
      )
    ) @ (
      E.different
      |> List.flat_map ~f:(fun (x, y) ->
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
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
