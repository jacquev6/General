include (Traits.Comparable: module type of Traits.Comparable)

module Tests = struct
  module Make0(M: sig
    include Traits.Comparable.S0
    include Traits.Representable.S0 with type t := t
    include Traits.Equatable.Basic.S0 with type t := t
  end)(E: Traits.Comparable.Examples.S0 with type t := M.t) = struct
    open Testing
    open StdLabels

    open M
    open M.O

    (* @todo (Make terminal recursive and) Put in General.List *)
    let rec cartesian_product xs ys =
      match xs with
        | [] -> []
        | x::xs -> (List.map ys ~f:(fun y -> (x, y))) @ (cartesian_product xs ys)

    let repr_pair (x, y) =
      (* @todo General.Tuple2.repr *)
      Printf.sprintf "(%s, %s)" (repr x) (repr y) (*BISECT-IGNORE*)

    let equal_pair (x, y) (x', y') =
      (* @todo General.Tuple2.equal *)
      Pervasives.(&&) (equal x x') (equal y y')

    let check_pair = check ~repr:repr_pair ~equal:equal_pair

    let check = check ~repr ~equal

    let test = "Comparable" >:: (
      E.ordered
      |> List.map ~f:(fun xs ->
        List.fold_left ~init:(List.hd xs, []) (List.tl xs) ~f:(fun (x, tests) y ->
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
        |> Pervasives.snd
      )
      |> List.concat (* @todo General.List.concat_map (in all tests) *)
    ) @ (
      E.equal
      |> List.map ~f:(fun xs ->
        cartesian_product xs xs
        |> List.map ~f:(fun (x, y) ->
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
        |> List.concat
      )
      |> List.concat
    )
  end
end
