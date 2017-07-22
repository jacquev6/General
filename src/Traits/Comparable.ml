module Basic = struct
  module type S0 = sig
    type t

    val compare: t -> t -> Compare.t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (<): t -> t -> bool
    val (<=): t -> t -> bool
    val (>): t -> t -> bool
    val (>=): t -> t -> bool
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool

    val min: t -> t -> t
    val max: t -> t -> t

    module O: Operators.S0 with type t := t
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    open B
    open Compare

    let less_than x y = compare x y = LT
    let less_or_equal x y = compare x y <> GT
    let greater_than x y = compare x y = GT
    let greater_or_equal x y = compare x y <> LT

    let min x y = match compare x y with LT -> x | GT | EQ -> y
    let max x y = match compare x y with GT -> x | LT | EQ -> y

    module O = struct
      let (<) = less_than
      let (<=) = less_or_equal
      let (>) = greater_than
      let (>=) = greater_or_equal
    end
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end

module Testable = struct
  module type S0 = sig
    include S0
    include Representable.S0 with type t := t

    val ordered_lists: t list list
    val equal_lists: t list list
  end
end

module Tests = struct
  module Make0(M: Testable.S0) = struct
    open M
    open Testing
    open StdLabels

    (* @todo (Make terminal recursive and) Put in General.List *)
    let rec cartesian_product xs ys =
      match xs with
        | [] -> []
        | x::xs -> (List.map ys ~f:(fun y -> (x, y))) @ (cartesian_product xs ys)

    let test = "Comparable" >::: (
      ordered_lists
      |> List.map ~f:(fun xs ->
        List.fold_left ~init:(List.hd xs, []) (List.tl xs) ~f:(fun (x, tests) y ->
          let rx = repr x and ry = repr y in
          let new_tests = [
            (Printf.sprintf "less_than %s %s" rx ry) >:: (fun () -> check_true (less_than x y));
            (Printf.sprintf "less_or_equal %s %s" rx ry) >:: (fun () -> check_true (less_or_equal x y));
            (Printf.sprintf "greater_or_equal %s %s" rx ry) >:: (fun () -> check_false (greater_or_equal x y));
            (Printf.sprintf "greater_than %s %s" rx ry) >:: (fun () -> check_false (greater_than x y));
            (Printf.sprintf "%s < %s" rx ry) >:: (fun () -> check_true (x < y));
            (Printf.sprintf "%s <= %s" rx ry) >:: (fun () -> check_true (x <= y));
            (Printf.sprintf "%s >= %s" rx ry) >:: (fun () -> check_false (x >= y));
            (Printf.sprintf "%s > %s" rx ry) >:: (fun () -> check_false (x > y));
            (Printf.sprintf "min %s %s" rx ry) >:: (fun () -> check ~repr ~equal:(==) ~expected:x (min x y));
            (Printf.sprintf "max %s %s" rx ry) >:: (fun () -> check ~repr ~equal:(==) ~expected:y (max x y));

            (Printf.sprintf "less_than %s %s" ry rx) >:: (fun () -> check_false (less_than y x));
            (Printf.sprintf "less_or_equal %s %s" ry rx) >:: (fun () -> check_false (less_or_equal y x));
            (Printf.sprintf "greater_or_equal %s %s" ry rx) >:: (fun () -> check_true (greater_or_equal y x));
            (Printf.sprintf "greater_than %s %s" ry rx) >:: (fun () -> check_true (greater_than y x));
            (Printf.sprintf "%s < %s" ry rx) >:: (fun () -> check_false (y < x));
            (Printf.sprintf "%s <= %s" ry rx) >:: (fun () -> check_false (y <= x));
            (Printf.sprintf "%s >= %s" ry rx) >:: (fun () -> check_true (y >= x));
            (Printf.sprintf "%s > %s" ry rx) >:: (fun () -> check_true (y > x));
            (Printf.sprintf "min %s %s" ry rx) >:: (fun () -> check ~repr ~equal:(==) ~expected:x (min y x));
            (Printf.sprintf "max %s %s" ry rx) >:: (fun () -> check ~repr ~equal:(==) ~expected:y (max y x));
          ] in
          (y, new_tests @ tests)
        )
        |> snd
      )
      |> List.concat
    ) @ (
      equal_lists
      |> List.map ~f:(fun xs ->
        cartesian_product xs xs
        |> List.map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            (Printf.sprintf "less_than %s %s" rx ry) >:: (fun () -> check_false (less_than x y));
            (Printf.sprintf "less_or_equal %s %s" rx ry) >:: (fun () -> check_true (less_or_equal x y));
            (Printf.sprintf "greater_or_equal %s %s" rx ry) >:: (fun () -> check_true (greater_or_equal x y));
            (Printf.sprintf "greater_than %s %s" rx ry) >:: (fun () -> check_false (greater_than x y));
            (Printf.sprintf "%s < %s" rx ry) >:: (fun () -> check_false (x < y));
            (Printf.sprintf "%s <= %s" rx ry) >:: (fun () -> check_true (x <= y));
            (Printf.sprintf "%s >= %s" rx ry) >:: (fun () -> check_true (x >= y));
            (Printf.sprintf "%s > %s" rx ry) >:: (fun () -> check_false (x > y));
            (Printf.sprintf "min %s %s" rx ry) >:: (fun () -> check ~repr ~equal:(==) ~expected:x (min x y));
            (Printf.sprintf "min %s %s" rx ry) >:: (fun () -> check ~repr ~equal:(==) ~expected:y (min x y));
            (Printf.sprintf "max %s %s" rx ry) >:: (fun () -> check ~repr ~equal:(==) ~expected:x (max x y));
            (Printf.sprintf "max %s %s" rx ry) >:: (fun () -> check ~repr ~equal:(==) ~expected:y (max x y));

            (Printf.sprintf "less_than %s %s" ry rx) >:: (fun () -> check_false (less_than y x));
            (Printf.sprintf "less_or_equal %s %s" ry rx) >:: (fun () -> check_true (less_or_equal y x));
            (Printf.sprintf "greater_or_equal %s %s" ry rx) >:: (fun () -> check_true (greater_or_equal y x));
            (Printf.sprintf "greater_than %s %s" ry rx) >:: (fun () -> check_false (greater_than y x));
            (Printf.sprintf "%s < %s" ry rx) >:: (fun () -> check_false (y < x));
            (Printf.sprintf "%s <= %s" ry rx) >:: (fun () -> check_true (y <= x));
            (Printf.sprintf "%s >= %s" ry rx) >:: (fun () -> check_true (y >= x));
            (Printf.sprintf "%s > %s" ry rx) >:: (fun () -> check_false (y > x));
            (Printf.sprintf "min %s %s" ry rx) >:: (fun () -> check ~repr ~equal:(==) ~expected:x (min y x));
            (Printf.sprintf "min %s %s" ry rx) >:: (fun () -> check ~repr ~equal:(==) ~expected:y (min y x));
            (Printf.sprintf "max %s %s" ry rx) >:: (fun () -> check ~repr ~equal:(==) ~expected:x (max y x));
            (Printf.sprintf "max %s %s" ry rx) >:: (fun () -> check ~repr ~equal:(==) ~expected:y (max y x));
          ]
        )
        |> List.concat
      )
      |> List.concat
    )
  end
end
