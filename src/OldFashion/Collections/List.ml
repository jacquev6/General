module Basic = struct
  type 'a t = 'a list

  (* @feature Add a 'Small' module with the same interface but non-terminal-recursive implementations *)

  let empty = []
  let singleton x = [x]
  let prepend x xs = x::xs
  let of_list = Function1.identity
  let to_list = Function1.identity
  (* @todo Test everything for stack overflow. Including to/of_array. *)
  let of_array = OCamlStandard.Array.to_list
  let to_array = OCamlStandard.Array.of_list

  let is_empty = function
    | [] -> true
    | _ -> false

  let try_head = function
    | [] -> None
    | x::_ -> Some x

  let try_tail = function
    | [] -> None
    | _::xs -> Some xs

  let head xs =
    try_head xs
    |> Option.or_failure "List.head"

  let tail xs =
    try_tail xs
    |> Option.or_failure "List.tail"

  let reverse xs =
    let rec aux ys = function
      | [] -> ys
      | x::xs -> aux (x::ys) xs
    in
    aux [] xs

  let rev_concat xs ys =
    let rec aux ys = function
      | [] -> ys
      | x::xs -> aux (x::ys) xs
    in
    aux ys xs

  let concat xs ys =
    rev_concat (reverse xs) ys

  module O = struct
    let (@) = concat
  end


  let map xs ~f =
    let rec aux ys = function
      | [] -> reverse ys
      | x::xs -> let y = f x in aux (y::ys) xs
    in
    aux [] xs

  let map_acc ~acc xs ~f =
    let rec aux acc ys = function
      | [] -> reverse ys
      | x::xs -> let (acc, y) = f ~acc x in aux acc (y::ys) xs
    in
    aux acc [] xs

  let map_i xs ~f =
    map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


  let flat_map xs ~f =
    let rec aux ys = function
      | [] -> reverse ys
      | x::xs -> let y = f x in aux (rev_concat y ys) xs
    in
    aux [] xs

  let flat_map_acc ~acc xs ~f =
    let rec aux acc ys = function
      | [] -> reverse ys
      | x::xs -> let (acc, y) = f ~acc x in aux acc (rev_concat y ys) xs
    in
    aux acc [] xs

  let flat_map_i xs ~f =
    flat_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


  let filter xs ~f =
    let rec aux ys = function
      | [] -> reverse ys
      | x::xs ->
        let b = f x in
        aux (if b then x::ys else ys) xs
    in
    aux [] xs

  let filter_acc ~acc xs ~f =
    let rec aux acc ys = function
      | [] -> reverse ys
      | x::xs ->
        let (acc, b) = f ~acc x in
        aux acc (if b then x::ys else ys) xs
    in
    aux acc [] xs

  let filter_i xs ~f =
    filter_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


  let filter_map xs ~f =
    let rec aux ys = function
      | [] -> reverse ys
      | x::xs ->
        let y = f x in
        let ys = match y with
          | Some y -> y::ys
          | None -> ys
        in
        aux ys xs
    in
    aux [] xs

  let filter_map_acc ~acc xs ~f =
    let rec aux acc ys = function
      | [] -> reverse ys
      | x::xs ->
        let (acc, y) = f ~acc x in
        let ys = match y with
          | Some y -> y::ys
          | None -> ys
        in
        aux acc ys xs
    in
    aux acc [] xs

  let filter_map_i xs ~f =
    filter_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


  let fold ~init xs ~f =
    let rec aux y = function
      | [] -> y
      | x::xs -> let y = f y x in aux y xs
    in
    aux init xs

  let fold_acc ~acc ~init xs ~f =
    let rec aux acc y = function
      | [] -> y
      | x::xs -> let (acc, y) = f ~acc y x in aux acc y xs
    in
    aux acc init xs

  let fold_i ~init xs ~f =
    fold_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> (Int.succ i, f ~i y x))


  let try_reduce_acc ~acc xs ~f =
    match xs with
      | [] -> None
      | init::xs -> Some (fold_acc ~acc xs ~init ~f)

  let try_reduce xs ~f =
    match xs with
      | [] -> None
      | init::xs -> Some (fold xs ~init ~f)

  let try_reduce_i xs ~f =
    match xs with
      | [] -> None
      | init::xs -> Some (fold_i xs ~init ~f)


  let reduce_acc ~acc xs ~f =
    try_reduce_acc ~acc xs ~f
    |> Option.or_failure "List.reduce_acc"

  let reduce xs ~f =
    try_reduce xs ~f
    |> Option.or_failure "List.reduce"

  let reduce_i xs ~f =
    try_reduce_i xs ~f
    |> Option.or_failure "List.reduce_i"


  let scan ~init xs ~f =
    let rec aux y ys = function
      | [] -> reverse (y::ys)
      | x::xs -> let y = f y x in aux y (y::ys) xs
    in
    aux init [] xs

  let scan_acc ~acc ~init xs ~f =
    let rec aux acc y ys = function
      | [] -> reverse (y::ys)
      | x::xs -> let (acc, y) = f ~acc y x in aux acc y (y::ys) xs
    in
    aux acc init [] xs

  let scan_i ~init xs ~f =
    scan_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> (Int.succ i, f ~i y x))


  let iter xs ~f =
    let rec aux = function
      | [] -> ()
      | x::xs -> let () = f x in aux xs
    in
    aux xs

  let iter_acc ~acc xs ~f =
    let rec aux acc = function
      | [] -> ()
      | x::xs -> let acc = f ~acc x in aux acc xs
    in
    aux acc xs

  let iter_i xs ~f =
    iter_acc ~acc:0 xs ~f:(fun ~acc:i x -> f ~i x; Int.succ i)


  let count xs ~f =
    fold xs ~init:0 ~f:(fun n x -> let b = f x in if b then Int.succ n else n)

  let count_acc ~acc xs ~f =
    fold_acc ~acc xs ~init:0 ~f:(fun ~acc n x -> let (acc, b) = f ~acc x in (acc, if b then Int.succ n else n))

  let count_i xs ~f =
    fold_i xs ~init:0 ~f:(fun ~i n x -> let b = f ~i x in if b then Int.succ n else n)


  let try_find xs ~f =
    let rec aux = function
      | [] -> None
      | x::xs -> let b = f x in if b then Some x else aux xs
    in
    aux xs

  let try_find_acc ~acc xs ~f =
    let rec aux acc = function
      | [] -> None
      | x::xs -> let (acc, b) = f ~acc x in if b then Some x else aux acc xs
    in
    aux acc xs

  let try_find_i xs ~f =
    try_find_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


  let find xs ~f =
    try_find xs ~f
    |> Option.value ~exc:Exception.NotFound

  let find_acc ~acc xs ~f =
    try_find_acc ~acc xs ~f
    |> Option.value ~exc:Exception.NotFound

  let find_i xs ~f =
    try_find_i xs ~f
    |> Option.value ~exc:Exception.NotFound


  let there_exists xs ~f =
    try_find xs ~f
    |> Option.is_some

  let there_exists_acc ~acc xs ~f =
    try_find_acc ~acc xs ~f
    |> Option.is_some

  let there_exists_i xs ~f =
    try_find_i xs ~f
    |> Option.is_some


  let for_all xs ~f =
    not (there_exists xs ~f:(not % f))

  let for_all_acc ~acc xs ~f =
    not (there_exists_acc ~acc xs ~f:(fun ~acc x -> let (acc, b) = f ~acc x in (acc, not b)))

  let for_all_i xs ~f =
    not (there_exists_i xs ~f:(fun ~i x -> not (f ~i x)))


  let try_find_map xs ~f =
    let rec aux = function
      | [] -> None
      | x::xs -> let b = f x in if Option.is_some b then b else aux xs
    in
    aux xs

  let try_find_map_acc ~acc xs ~f =
    let rec aux acc = function
      | [] -> None
      | x::xs -> let (acc, b) = f ~acc x in if Option.is_some b then b else aux acc xs
    in
    aux acc xs

  let try_find_map_i xs ~f =
    try_find_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


  let find_map xs ~f =
    try_find_map xs ~f
    |> Option.value ~exc:Exception.NotFound

  let find_map_acc ~acc xs ~f =
    try_find_map_acc ~acc xs ~f
    |> Option.value ~exc:Exception.NotFound

  let find_map_i xs ~f =
    try_find_map_i xs ~f
    |> Option.value ~exc:Exception.NotFound


  let fold_short ~init xs ~f =
    let rec aux y = function
      | [] -> y
      | x::xs ->
        let (s, y) = f y x in
        match s with
          | Shorten.GoOn -> aux y xs
          | Shorten.ShortCircuit -> y
    in
    aux init xs

  let fold_short_acc ~acc ~init xs ~f =
    let rec aux acc y = function
      | [] -> y
      | x::xs ->
        let (acc, s, y) = f ~acc y x in
        match s with
          | Shorten.GoOn -> aux acc y xs
          | Shorten.ShortCircuit -> y
    in
    aux acc init xs

  let fold_short_i ~init xs ~f =
    fold_short_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> let (s, y) = f ~i y x in (Int.succ i, s, y))


  let try_reduce_short_acc ~acc xs ~f =
    match xs with
      | [] -> None
      | init::xs -> Some (fold_short_acc ~acc xs ~init ~f)

  let try_reduce_short xs ~f =
    match xs with
      | [] -> None
      | init::xs -> Some (fold_short xs ~init ~f)

  let try_reduce_short_i xs ~f =
    match xs with
      | [] -> None
      | init::xs -> Some (fold_short_i xs ~init ~f)


  let reduce_short_acc ~acc xs ~f =
    try_reduce_short_acc ~acc xs ~f
    |> Option.or_failure "List.reduce_short_acc"

  let reduce_short xs ~f =
    try_reduce_short xs ~f
    |> Option.or_failure "List.reduce_short"

  let reduce_short_i xs ~f =
    try_reduce_short_i xs ~f
    |> Option.or_failure "List.reduce_short_i"


  let scan_short ~init xs ~f =
    let rec aux y ys = function
      | [] -> reverse (y::ys)
      | x::xs ->
        let (s, y) = f y x in
        match s with
          | Shorten.GoOn -> aux y (y::ys) xs
          | Shorten.ShortCircuit -> reverse (y::ys)
    in
    aux init [] xs

  let scan_short_acc ~acc ~init xs ~f =
    let rec aux acc y ys = function
      | [] -> reverse (y::ys)
      | x::xs ->
        let (acc, s, y) = f ~acc y x in
        match s with
          | Shorten.GoOn -> aux acc y (y::ys) xs
          | Shorten.ShortCircuit -> reverse (y::ys)
    in
    aux acc init [] xs

  let scan_short_i ~init xs ~f =
    scan_short_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> let (s, y) = f ~i y x in (Int.succ i, s, y))


  let iter_short xs ~f =
    let rec aux = function
      | [] -> ()
      | x::xs ->
        match f x with
          | Shorten.GoOn -> aux xs
          | Shorten.ShortCircuit -> ()
    in
    aux xs

  let iter_short_acc ~acc xs ~f =
    let rec aux acc = function
      | [] -> ()
      | x::xs ->
        let (acc, s) = f ~acc x in
        match s with
          | Shorten.GoOn -> aux acc xs
          | Shorten.ShortCircuit -> ()
    in
    aux acc xs

  let iter_short_i xs ~f =
    iter_short_acc ~acc:0 xs ~f:(fun ~acc:i x -> let s = f ~i x in (Int.succ i, s))


  let contains xs x ~equal_a =
    there_exists xs ~f:(equal_a x)

  module Poly = struct
    let contains xs x =
      let rec aux = function
        | [] -> false
        | x'::_ when Equate.Poly.equal x' x -> true
        | _::xs -> aux xs
      in
      aux xs
  end

  let size xs =
    let rec aux s = function
      | [] -> s
      | _::xs -> aux (Int.succ s) xs
    in
    aux 0 xs

  let join_string_list ?(sep="") xs =
    xs
    |> try_reduce ~f:(fun a b -> Format.apply "%s%s%s" a sep b)
    |> Option.value_def ~def:""

  let repr xs ~repr_a =
    xs
    |> map ~f:repr_a
    |> join_string_list ~sep:"; "
    |> Format.apply "[%s]"


  module Two = struct
    let to_pair_list xs ys =
      let rec aux zs = function
        | ([], []) ->
          reverse zs
        | (x::xs, y::ys) ->
          aux ((x, y)::zs) (xs, ys)
        | _ ->
          Exception.invalid_argument "List.Two.to_pair_list"
      in
      aux [] (xs, ys)

    let to_pair_list_short xs ys =
      let rec aux zs = function
        | ([], _)
        | (_, []) ->
          reverse zs
        | (x::xs, y::ys) ->
          aux ((x, y)::zs) (xs, ys)
      in
      aux [] (xs, ys)
  end


  (* @todo Remove *)
  module OCLL = OCamlStandard.ListLabels

  let equal xs ys ~equal_a =
    try
      OCLL.for_all2 ~f:equal_a xs ys
    with
      | Invalid_argument _ -> false

  (* @todo Make terminal recursive *)
  let rec cartesian_product xs ys =
    match xs with
      | [] -> []
      | x::xs -> OCLL.append (OCLL.map ys ~f:(fun y -> (x, y))) (cartesian_product xs ys)
end

module Extended(Facets: Facets) = struct
  module Self = struct
    include Facets.Equatable.Different.Make1(Basic)
    include Basic
  end

  include Self

  module Specialize(A: sig type t end) = struct
    type t = A.t list

    include (Self: module type of Self with type 'a t := 'a Self.t)

    module ToList = struct
      let map = map
      let map_acc = map_acc
      let map_i = map_i
      let filter = filter
      let filter_acc = filter_acc
      let filter_i = filter_i
      let filter_map = filter_map
      let filter_map_acc = filter_map_acc
      let filter_map_i = filter_map_i
      let flat_map = flat_map
      let flat_map_acc = flat_map_acc
      let flat_map_i = flat_map_i
      let scan = scan
      let scan_acc = scan_acc
      let scan_i = scan_i
      let scan_short = scan_short
      let scan_short_acc = scan_short_acc
      let scan_short_i = scan_short_i
    end
  end

  module SpecializeEquatable(A: Facets.EquatableBasic.S0) = struct
    type t = A.t list

    let contains xs x =
      Self.contains xs x ~equal_a:A.equal
  end

  module SpecializeRepresentable(A: Facets.Representable.S0) = struct
    type t = A.t list

    let repr xs =
      Self.repr xs ~repr_a:A.repr
  end

  #ifdef TESTING_GENERAL
  module MakeTests(Standard: Standard) = struct
    open Standard

    module Examples = struct
      module A = Int

      let values = [[]; [1]; [1; 2; 3]]

      let representations = [
        ([], "[]");
        ([1], "[1]");
        ([1; 2; 3], "[1; 2; 3]");
      ]

      let equalities = [
        [empty; []];
      ]

      let differences = [
        ([], [1]);
        ([1], [2]);
        ([1; 1; 1], [1; 1; 2]);
        ([1; 1; 1], [1; 1; 1; 1]);
      ]
    end

    open Testing

    let test = "List" >:: [
      (* @todo Generate in geni.py *)
      (let module T = Facets.Representable.Tests.Make1(Self)(Examples) in T.test);
      (let module T = Facets.Equatable.Tests.Make1(Self)(Examples) in T.test);
      (* (let module T = Facets.FilterMapable.Tests.Make1(Self) in T.test); *)
      "reverse" >: (lazy (check_string_list ~expected:["3"; "2"; "1"] (reverse ["1"; "2"; "3"])));
      "concat" >: (lazy (check_int_list ~expected:[1; 2; 3; 4; 5; 6] (concat [1; 2; 3] [4; 5; 6])));
      "prepend" >: (lazy (check_int_list ~expected:[1; 2; 3] (prepend 1 [2; 3])));
      "try_head" >: (lazy (check_some_int ~expected:1 (try_head [1; 2; 3])));
      "try_head []" >: (lazy (check_none_int (try_head [])));
      "try_tail" >: (lazy (check_some ~repr:(repr ~repr_a:Int.repr) ~equal:(equal ~equal_a:Int.equal) ~expected:[2; 3] (try_tail [1; 2; 3])));
      "try_tail []" >: (lazy (check_none ~repr:(repr ~repr_a:Float.repr) ~equal:(equal ~equal_a:Float.equal) (try_tail [])));
      "head" >: (lazy (check_int ~expected:1 (head [1; 2; 3])));
      "head []" >: (lazy (expect_exception ~expected:(Exception.Failure "List.head") (lazy (head []))));
      "tail" >: (lazy (check_int_list ~expected:[2; 3] (tail [1; 2; 3])));
      "tail []" >: (lazy (expect_exception ~expected:(Exception.Failure "List.tail") (lazy (tail []))));
      "fold []" >: (lazy (check_int ~expected:0 (fold ~init:0 ~f:(fun _ -> Exception.failure "Don't call me") []))); (*BISECT-IGNORE*)
      "fold" >: (lazy (check_string ~expected:"init-3-4" (fold ~init:"init" ~f:(Format.apply "%s-%d") [3; 4])));
      "reduce [0]" >: (lazy (check_int ~expected:0 (reduce ~f:(fun _ -> Exception.failure "Don't call me") [0]))); (*BISECT-IGNORE*)
      "reduce" >: (lazy (check_int ~expected:4096 (reduce ~f:Int.exponentiate [2; 3; 4])));
      "try_reduce" >: (lazy (check_some_int ~expected:4096 (try_reduce ~f:Int.exponentiate [2; 3; 4])));
      "try_reduce []" >: (lazy (check_none_int (try_reduce ~f:Int.exponentiate [])));
      "iter" >: (lazy (check_int ~expected:4096 (let p = ref 2 in iter ~f:(fun n -> p := Int.exponentiate !p n) [3; 4]; !p)));
    ]
  end
  #endif
end
