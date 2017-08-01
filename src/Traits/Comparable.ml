open Foundations

(* @todo Descending, ascending *)
(* @todo val between[_or_equal]: t -> low:t -> high:t -> bool *)

module Basic = struct
  module type SP = sig
    val compare: 'a -> 'a -> Compare.t
  end

  module type S0 = sig
    type t

    val compare: t -> t -> Compare.t
  end

  module type S1 = sig
    type 'a t

    val compare: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> Compare.t
  end
end

module Operators = struct
  module type SP = sig
    val (<): 'a -> 'a -> bool
    val (<=): 'a -> 'a -> bool
    val (>): 'a -> 'a -> bool
    val (>=): 'a -> 'a -> bool
  end

  module type S0 = sig
    type t

    val (<): t -> t -> bool
    val (<=): t -> t -> bool
    val (>): t -> t -> bool
    val (>=): t -> t -> bool
  end

  module Make0(M: sig
    type t

    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool
  end) = struct
    open M

    let (<) x y =
      less_than x y

    let (<=) x y =
      less_or_equal x y
    let (>) x y =
      greater_than x y

    let (>=) x y =
      greater_or_equal x y
  end
end

module type SP = sig
  include Basic.SP

  val less_than: 'a -> 'a -> bool
  val less_or_equal: 'a -> 'a -> bool
  val greater_than: 'a -> 'a -> bool
  val greater_or_equal: 'a -> 'a -> bool

  val min: 'a -> 'a -> 'a
  val max: 'a -> 'a -> 'a
  val min_max: 'a -> 'a -> 'a * 'a

  module O: sig include Operators.SP end
end

module type S0 = sig
  include Basic.S0

  val less_than: t -> t -> bool
  val less_or_equal: t -> t -> bool
  val greater_than: t -> t -> bool
  val greater_or_equal: t -> t -> bool

  val min: t -> t -> t
  val max: t -> t -> t
  val min_max: t -> t -> t * t

  module O: Operators.S0 with type t := t
end

module type S1 = sig
  include Basic.S1

  val less_than: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> bool
  val less_or_equal: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> bool
  val greater_than: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> bool
  val greater_or_equal: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> bool

  val min: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> 'a t
  val max: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> 'a t
  val min_max: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> 'a t * 'a t
end

module GreaterLessThan = struct
  module Make0(M: sig
    type t

    val compare: t -> t -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y =
      match compare x y with
        | LT -> true
        | _ -> false

    let less_or_equal x y =
      match compare x y with
        | GT -> false
        | _ -> true

    let greater_than x y =
      match compare x y with
        | GT -> true
        | _ -> false

    let greater_or_equal x y =
      match compare x y with
        | LT -> false
        | _ -> true
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare:cmp =
      match compare x y ~compare:cmp with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare:cmp =
      match compare x y ~compare:cmp with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare:cmp =
      match compare x y ~compare:cmp with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare:cmp =
      match compare x y ~compare:cmp with
        | LT -> false
        | _ -> true
  end
end

module MinMax = struct
  module Make0(M: sig
    type t

    val compare: t -> t -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y =
      match compare x y with LT -> x | GT | EQ -> y

    let max x y =
      match compare x y with GT -> x | LT | EQ -> y

    let min_max x y =
      match compare x y with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t -> compare:('a -> 'a -> Compare.t) -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare:cmp =
      match compare x y ~compare:cmp with LT -> x | GT | EQ -> y

    let max x y ~compare:cmp =
      match compare x y ~compare:cmp with GT -> x | LT | EQ -> y

    let min_max x y ~compare:cmp =
      match compare x y ~compare:cmp with LT -> (x, y) | GT | EQ -> (y, x)
  end
end

module Specialize1(M: S1)(E: Basic.S0): S0 with type t = E.t M.t = struct
  module Self = struct
    type t = E.t M.t

    let compare x y =
      M.compare x y ~compare:E.compare

    let less_than x y =
      M.less_than x y ~compare:E.compare

    let less_or_equal x y =
      M.less_or_equal x y ~compare:E.compare

    let greater_than x y =
      M.greater_than x y ~compare:E.compare

    let greater_or_equal x y =
      M.greater_or_equal x y ~compare:E.compare

    let min x y =
      M.min x y ~compare:E.compare

    let max x y =
      M.max x y ~compare:E.compare

    let min_max x y =
      M.min_max x y ~compare:E.compare
  end

  module O = Operators.Make0(Self)

  include Self
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val ordered: t list list
      val equal: t list list
    end

    module type S1 = sig
      module Element: sig
        include Basic.S0
        include Equatable.Basic.S0 with type t := t
        include Representable.Basic.S0 with type t := t
      end

      type 'a t

      val ordered: Element.t t list list
      val equal: Element.t t list list
    end
  end

  module Make0(M: sig
    include S0
    include Representable.Basic.S0 with type t := t
    include Equatable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M
    open M.O

    let repr_pair (x, y) =
      (* @todo General.Tuple2.repr *)
      Format_.sprintf "(%s, %s)" (repr x) (repr y) (*BISECT-IGNORE*)

    let equal_pair (x, y) (x', y') =
      (* @todo General.Tuple2.equal *)
      (equal x x') && (equal y y')

    let check_pair = check ~repr:repr_pair ~equal:equal_pair

    let check = check ~repr ~equal

    let test = "Comparable" >:: (
      E.ordered
      |> List_.concat_map ~f:(fun xs ->
        List_.fold ~init:(List_.head xs, []) (List_.tail xs) ~f:(fun (x, tests) y ->
          let rx = repr x and ry = repr y in
          let new_tests = [
            ~: "less_than %s %s" rx ry (lazy (check_true (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_false (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_true (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_false (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_false (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_true (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_false (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_true (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
          ] in
          (y, new_tests @ tests)
        )
        |> Tuple2.get_1
      )
    ) @ (
      E.equal
      |> List_.concat_map ~f:(fun xs ->
        List_.cartesian_product xs xs
        |> List_.concat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "less_than %s %s" rx ry (lazy (check_false (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_true (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_false (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_true (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:y (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:x (max x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_true (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_false (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_true (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_false (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:y (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:x (max y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, y) (min_max y x)));
          ]
        )
      )
    )
  end

  module Make1(M: sig
    include S1
    include Equatable.Basic.S1 with type 'a t := 'a t
    include Representable.Basic.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t): sig val test: Test.t end = struct
    include Make0(struct
      include Specialize1(M)(E.Element)
      include (Representable.Basic.Specialize1(M)(E.Element): module type of Representable.Basic.Specialize1(M)(E.Element) with type t := t)
      include (Equatable.Basic.Specialize1(M)(E.Element): module type of Equatable.Basic.Specialize1(M)(E.Element) with type t := t)
    end)(E)
  end
end
