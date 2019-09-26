#include "../Generated/Facets/Comparable.ml"

(* @feature Descending, ascending *)

module GreaterLessThan = struct
  include GreaterLessThan_.MakeMakers(struct
    open Compare

    let less_than ~compare x y =
      match compare x y with
        | LT -> true
        | _ -> false

    let less_or_equal ~compare x y =
      match compare x y with
        | GT -> false
        | _ -> true

    let greater_than ~compare x y =
      match compare x y with
        | GT -> true
        | _ -> false

    let greater_or_equal ~compare x y =
      match compare x y with
        | LT -> false
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
    open Compare

    let min ~compare x y =
      match compare x y with
        | LT -> x
        | GT | EQ -> y

    let max ~compare x y =
      match compare x y with
        | GT -> x
        | LT | EQ -> y

    let min_max ~compare x y =
      match compare x y with
        | LT -> (x, y)
        | GT | EQ -> (y, x)
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module ComparableBasicTests = ComparableBasic.Tests_beta(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let check_m_pair =
      check
        ~repr:(Tuple2.repr ~repr_a:M.repr ~repr_b:M.repr)
        ~equal:(Tuple2.equal ~equal_a:M.equal ~equal_b:M.equal)

    let check_m = M.(check ~repr ~equal)

    let tests =
      let module Expectations = ComparableBasicTests.MakeExpectations(M)(E) in []
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "less_than %s %s" rx ry (lazy (M.less_than x y |> check_false))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "less_than %s %s" rx ry (lazy (M.less_than x y |> check_true));
        ~: "less_than %s %s" ry rx (lazy (M.less_than y x |> check_false));
      ]))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s < %s" rx ry (lazy (M.O.(x < y) |> check_false))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "%s < %s" rx ry (lazy (M.O.(x < y) |> check_true));
        ~: "%s < %s" ry rx (lazy (M.O.(y < x) |> check_false));
      ]))

      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "less_or_equal %s %s" rx ry (lazy (M.less_or_equal x y |> check_true))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "less_or_equal %s %s" rx ry (lazy (M.less_or_equal x y |> check_true));
        ~: "less_or_equal %s %s" ry rx (lazy (M.less_or_equal y x |> check_false));
      ]))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s <= %s" rx ry (lazy (M.O.(x <= y) |> check_true))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "%s <= %s" rx ry (lazy (M.O.(x <= y) |> check_true));
        ~: "%s <= %s" ry rx (lazy (M.O.(y <= x) |> check_false));
      ]))

      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "greater_than %s %s" rx ry (lazy (M.greater_than x y |> check_false))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "greater_than %s %s" rx ry (lazy (M.greater_than x y |> check_false));
        ~: "greater_than %s %s" ry rx (lazy (M.greater_than y x |> check_true));
      ]))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s > %s" rx ry (lazy (M.O.(x > y) |> check_false))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "%s > %s" rx ry (lazy (M.O.(x > y) |> check_false));
        ~: "%s > %s" ry rx (lazy (M.O.(y > x) |> check_true));
      ]))

      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "greater_or_equal %s %s" rx ry (lazy (M.greater_or_equal x y |> check_true))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "greater_or_equal %s %s" rx ry (lazy (M.greater_or_equal x y |> check_false));
        ~: "greater_or_equal %s %s" ry rx (lazy (M.greater_or_equal y x |> check_true));
      ]))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "%s >= %s" rx ry (lazy (M.O.(x >= y) |> check_true))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "%s >= %s" rx ry (lazy (M.O.(x >= y) |> check_false));
        ~: "%s >= %s" ry rx (lazy (M.O.(y >= x) |> check_true));
      ]))

      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "min %s %s" rx ry (lazy (M.min x y |> check_m ~expected:x))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "min %s %s" rx ry (lazy (M.min x y |> check_m ~expected:x));
        ~: "min %s %s" ry rx (lazy (M.min y x |> check_m ~expected:x));
      ]))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "max %s %s" rx ry (lazy (M.max x y |> check_m ~expected:y))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "max %s %s" rx ry (lazy (M.max x y |> check_m ~expected:y));
        ~: "max %s %s" ry rx (lazy (M.max y x |> check_m ~expected:y));
      ]))
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "min_max %s %s" rx ry (lazy (M.min_max x y |> check_m_pair ~expected:(x, y)))
      ))
      @ (List.flat_map Expectations.ordered_pairs ~f:(fun (x, rx, y, ry) -> [
        ~: "min_max %s %s" rx ry (lazy (M.min_max x y |> check_m_pair ~expected:(x, y)));
        ~: "min_max %s %s" ry rx (lazy (M.min_max y x |> check_m_pair ~expected:(x, y)));
      ]))
  end)
end
