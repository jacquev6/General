open Abbr_

include (Traits_.Equatable_: module type of Equatable_)

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
    include Representable_.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M
    open M.O

    let test = "Equatable" >:: (
      E.equal
      |> Li.concat_map ~f:(fun xs ->
        Li.cartesian_product xs xs
        |> Li.concat_map ~f:(fun (x, y) ->
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
      |> Li.concat_map ~f:(fun (x, y) ->
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
    include Representable_.Basic.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t) = struct
    open M

    let test = "Equatable" >:: (
      E.equal
      |> Li.concat_map ~f:(fun xs ->
        Li.cartesian_product xs xs
        |> Li.concat_map ~f:(fun (x, y) ->
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
      |> Li.concat_map ~f:(fun (x, y) ->
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
