#include "../Generated/Facets/Comparable.ml"

(* @feature Descending, ascending *)

module GreaterLessThan = struct
  include GreaterLessThan_.MakeMakers(struct
    let less_than ~compare x y =
      match compare x y with
        | Compare.LT -> true
        | _ -> false

    let less_or_equal ~compare x y =
      match compare x y with
        | Compare.GT -> false
        | _ -> true

    let greater_than ~compare x y =
      match compare x y with
        | Compare.GT -> true
        | _ -> false

    let greater_or_equal ~compare x y =
      match compare x y with
        | Compare.LT -> false
        | _ -> true
  end)
end

module Between = struct
  include Between_.MakeMakers(struct
    let between ~less_than ~less_or_equal:_ ~greater_than ~greater_or_equal:_ x ~low ~high =
      less_than low x && greater_than high x

    let between_or_equal ~less_than:_ ~less_or_equal ~greater_than:_ ~greater_or_equal x ~low ~high =
      less_or_equal low x && greater_or_equal high x
  end)
end

module MinMax = struct
  include MinMax_.MakeMakers(struct
    let min ~compare x y =
      match compare x y with
        | Compare.LT -> x
        | Compare.GT | Compare.EQ -> y

    let max ~compare x y =
      match compare x y with
        | Compare.GT -> x
        | Compare.LT | Compare.EQ -> y

    let min_max ~compare x y =
      match compare x y with
        | Compare.LT -> (x, y)
        | Compare.GT | Compare.EQ -> (y, x)
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeOwnTesters(M: Testable.S0): sig
    val test_value: M.t * string -> Test.t list
    val test_equivalent_pair: (M.t * string) * (M.t * string) -> Test.t list
    val test_ordered_pair: (M.t * string) * (M.t * string) -> Test.t list
  end = struct
    open Testing

    let check_m_pair =
      check
        ~repr:(Tuple2.repr ~repr_a:M.repr ~repr_b:M.repr)
        ~equal:(Tuple2.equal ~equal_a:M.equal ~equal_b:M.equal)

    let check_m = M.(check ~repr ~equal)

    let test_equivalent_pair' ((x, rx), (y, ry)) = [
      ~: "Comparable: less_than %s %s" rx ry (lazy (M.less_than x y |> check_false));
      ~: "Comparable: %s < %s" rx ry (lazy (M.O.(x < y) |> check_false));
      ~: "Comparable: less_or_equal %s %s" rx ry (lazy (M.less_or_equal x y |> check_true));
      ~: "Comparable: %s <= %s" rx ry (lazy (M.O.(x <= y) |> check_true));
      ~: "Comparable: greater_than %s %s" rx ry (lazy (M.greater_than x y |> check_false));
      ~: "Comparable: %s > %s" rx ry (lazy (M.O.(x > y) |> check_false));
      ~: "Comparable: greater_or_equal %s %s" rx ry (lazy (M.greater_or_equal x y |> check_true));
      ~: "Comparable: %s >= %s" rx ry (lazy (M.O.(x >= y) |> check_true));
      ~: "Comparable: min %s %s" rx ry (lazy (M.min x y |> check_m ~expected:x));
      ~: "Comparable: max %s %s" rx ry (lazy (M.max x y |> check_m ~expected:y));
      ~: "Comparable: min_max %s %s" rx ry (lazy (M.min_max x y |> check_m_pair ~expected:(x, y)));
    ]

    let test_value x = test_equivalent_pair' (x, x)

    let test_equivalent_pair (x, y) =
      if Tuple2.equal ~equal_a:Equate.Phys.equal ~equal_b:String.equal x y then
        test_equivalent_pair' (x, y)
      else
        (test_equivalent_pair' (x, y)) @ (test_equivalent_pair' (y, x))

    let test_ordered_pair ((x, rx), (y, ry)) = [
      ~: "Comparable: less_than %s %s" rx ry (lazy (M.less_than x y |> check_true));
      ~: "Comparable: less_than %s %s" ry rx (lazy (M.less_than y x |> check_false));
      ~: "Comparable: %s < %s" rx ry (lazy (M.O.(x < y) |> check_true));
      ~: "Comparable: %s < %s" ry rx (lazy (M.O.(y < x) |> check_false));
      ~: "Comparable: less_or_equal %s %s" rx ry (lazy (M.less_or_equal x y |> check_true));
      ~: "Comparable: less_or_equal %s %s" ry rx (lazy (M.less_or_equal y x |> check_false));
      ~: "Comparable: %s <= %s" rx ry (lazy (M.O.(x <= y) |> check_true));
      ~: "Comparable: %s <= %s" ry rx (lazy (M.O.(y <= x) |> check_false));
      ~: "Comparable: greater_than %s %s" rx ry (lazy (M.greater_than x y |> check_false));
      ~: "Comparable: greater_than %s %s" ry rx (lazy (M.greater_than y x |> check_true));
      ~: "Comparable: %s > %s" rx ry (lazy (M.O.(x > y) |> check_false));
      ~: "Comparable: %s > %s" ry rx (lazy (M.O.(y > x) |> check_true));
      ~: "Comparable: greater_or_equal %s %s" rx ry (lazy (M.greater_or_equal x y |> check_false));
      ~: "Comparable: greater_or_equal %s %s" ry rx (lazy (M.greater_or_equal y x |> check_true));
      ~: "Comparable: %s >= %s" rx ry (lazy (M.O.(x >= y) |> check_false));
      ~: "Comparable: %s >= %s" ry rx (lazy (M.O.(y >= x) |> check_true));
      ~: "Comparable: min %s %s" rx ry (lazy (M.min x y |> check_m ~expected:x));
      ~: "Comparable: min %s %s" ry rx (lazy (M.min y x |> check_m ~expected:x));
      ~: "Comparable: max %s %s" rx ry (lazy (M.max x y |> check_m ~expected:y));
      ~: "Comparable: max %s %s" ry rx (lazy (M.max y x |> check_m ~expected:y));
      ~: "Comparable: min_max %s %s" rx ry (lazy (M.min_max x y |> check_m_pair ~expected:(x, y)));
      ~: "Comparable: min_max %s %s" ry rx (lazy (M.min_max y x |> check_m_pair ~expected:(x, y)));
    ]
  end

  module ComparableBasicTests = ComparableBasic.Tests_beta(Testing)

  module MakeTesters(M: Testable.S0) = struct
    module ComparableBasicTesters = ComparableBasicTests.MakeTesters(M)
    module ComparableTesters = MakeOwnTesters(M)

    (* let test_value x =
      (ComparableBasicTesters.test_value x) @ (ComparableTesters.test_value x) *)

    (* let test_equivalent_pair p =
      (ComparableBasicTesters.test_equivalent_pair p) @ (ComparableTesters.test_equivalent_pair p) *)

    let test_ordered_pair p =
      (ComparableBasicTesters.test_ordered_pair p) @ (ComparableTesters.test_ordered_pair p)
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Expectations = ComparableBasicTests.MakeExpectations(M)(E)
    module Testers = MakeOwnTesters(M)

    let tests = []
      @ (List.flat_map Expectations.values ~f:Testers.test_value)
      @ (List.flat_map Expectations.equivalent_pairs ~f:Testers.test_equivalent_pair)
      @ (List.flat_map Expectations.ordered_pairs ~f:Testers.test_ordered_pair)
  end)
end
