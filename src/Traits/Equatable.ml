open Foundations

module Basic = struct
  module type SP = sig
    val equal: 'a -> 'a -> bool
  end

  module type S0 = sig
    type t

    val equal: t -> t -> bool
  end

  module type S1 = sig
    type 'a t

    val equal: 'a t -> 'a t -> equal:('a -> 'a -> bool) -> bool
  end
end

module Operators = struct
  module type SP = sig
    val (=): 'a -> 'a -> bool
    val (<>): 'a -> 'a -> bool
  end

  module type S0 = sig
    type t

    val (=): t -> t -> bool
    val (<>): t -> t -> bool
  end

  module Make0(M: sig
    type t

    val equal: t -> t -> bool
    val different: t -> t -> bool
  end) = struct
    open M

    let (=) x y =
      equal x y

    let (<>) x y =
      different x y
  end
end

module type SP = sig
  include Basic.SP

  val different: 'a -> 'a -> bool

  module O: sig include Operators.SP end
end

module type S0 = sig
  include Basic.S0

  val different: t -> t -> bool

  module O: Operators.S0 with type t := t
end

module type S1 = sig
  include Basic.S1

  val different: 'a t -> 'a t -> equal:('a -> 'a -> bool) -> bool
end

module Different = struct
  module Make0(M: sig
    type t

    val equal: t -> t -> bool
  end) = struct
    open M

    let different x y =
      OCamlStandard.Pervasives.not (equal x y)
  end

  module type M1 = sig
    type 'a t

    val equal: 'a t -> 'a t -> equal:('a -> 'a -> bool) -> bool
  end

  module Make1(M: M1) = struct
    open M

    let different x y ~equal:eq =
      OCamlStandard.Pervasives.not (equal x y ~equal:eq)
  end
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val equal: t list list
      val different: (t * t) list
    end

    module type S1 = sig
      module Element: sig
        include Basic.S0
        include Representable.Basic.S0 with type t := t
      end

      type 'a t

      val equal: Element.t t list list
      val different: (Element.t t * Element.t t) list
    end
  end

  module Make0(M: sig
    include S0
    include Representable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M
    open M.O

    let test = "Equatable" >:: (
      E.equal
      |> List_.concat_map ~f:(fun xs ->
        List_.cartesian_product xs xs
        |> List_.concat_map ~f:(fun (x, y) ->
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
      |> List_.concat_map ~f:(fun (x, y) ->
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

  module Make1(M: sig
    include S1
    include Representable.Basic.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t) = struct
    open M

    let test = "Equatable" >:: (
      E.equal
      |> List_.concat_map ~f:(fun xs ->
        List_.cartesian_product xs xs
        |> List_.concat_map ~f:(fun (x, y) ->
          let rx = repr ~repr:E.Element.repr x and ry = repr ~repr:E.Element.repr y in
          [
            ~: "equal %s %s" rx ry (lazy (check_true (equal ~equal:E.Element.equal x y)));
            ~: "different %s %s" rx ry (lazy (check_false (different ~equal:E.Element.equal x y)));

            ~: "equal %s %s" ry rx (lazy (check_true (equal ~equal:E.Element.equal y x)));
            ~: "different %s %s" ry rx (lazy (check_false (different ~equal:E.Element.equal y x)));
          ]
        )
      )
    ) @ (
      E.different
      |> List_.concat_map ~f:(fun (x, y) ->
        let rx = repr ~repr:E.Element.repr x and ry = repr ~repr:E.Element.repr y in
        [
          ~: "equal %s %s" rx ry (lazy (check_false (equal ~equal:E.Element.equal x y)));
          ~: "different %s %s" rx ry (lazy (check_true (different ~equal:E.Element.equal x y)));

          ~: "equal %s %s" ry rx (lazy (check_false (equal ~equal:E.Element.equal y x)));
          ~: "different %s %s" ry rx (lazy (check_true (different ~equal:E.Element.equal y x)));
        ]
      )
    )
  end
end
