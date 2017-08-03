type 'a t = 'a list

open Functions.Function1.O

let empty = []
let cons x xs = x::xs
let of_list = Functions.Function1.identity
let to_list = Functions.Function1.identity
(* @todo Test everything for stack overflow. Including to/of_array. *)
let of_array = OCamlStandard.Array.to_list
let to_array = OCamlStandard.Array.of_list

let try_head = function
  | [] -> None
  | x::_ -> Some x

let try_tail = function
  | [] -> None
  | _::xs -> Some xs

(* @todo Find a suitable module for 'or_failure'? (If yes, accept a Format.t) *)
let or_failure message = function
  | None ->
    Exception.failure message
  | Some x ->
    x

let head xs =
  try_head xs
  |> or_failure "List.head"

let tail xs =
  try_tail xs
  |> or_failure "List.tail"

let reverse xs =
  let rec aux ys = function
    | [] -> ys
    | x::xs -> aux (x::ys) xs
  in
  aux [] xs

let append xs ys=
  let rec aux ys = function
    | [] -> ys
    | x::xs -> aux (x::ys) xs
  in
  aux ys (reverse xs)

module O = struct
  let (@) = append
end

let fold xs ~init ~f =
  let rec aux y = function
    | [] -> y
    | x::xs -> aux (f y x) xs
  in
  aux init xs

let fold_i xs ~init ~f =
  let rec aux i y = function
    | [] -> y
    | x::xs -> aux (Int.succ i) (f i y x) xs
  in
  aux 0 init xs

let try_reduce xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold xs ~init ~f)

let reduce xs ~f =
  try_reduce xs ~f
  |> or_failure "List.reduce"

let map xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs -> aux ((f x)::ys) xs
  in
  aux [] xs

let iter xs ~f =
  let rec aux = function
    | [] -> ()
    | x::xs -> f x; aux xs
  in
  aux xs

let iter_i xs ~f =
  let rec aux i = function
    | [] -> ()
    | x::xs -> f i x; aux (Int.succ i) xs
  in
  aux 0 xs

let repr xs ~repr_a =
  xs
  |> map ~f:repr_a
  |> OCamlStandard.StringLabels.concat ~sep:"; "
  |> Format_.sprintf "[%s]"

let filter xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs -> aux (if f x then x::ys else ys) xs
  in
  aux [] xs

let filter_map xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs ->
      let ys = match f x with
        | Some y -> y::ys
        | None -> ys
      in
      aux ys xs
  in
  aux [] xs

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



(* @todo Remove *)
module OCLL = OCamlStandard.ListLabels

let equal xs ys ~equal_a =
  try
    OCLL.for_all2 ~f:equal_a xs ys
  with
    | Invalid_argument _ -> false

(* @todo Make terminal recursive *)
let concat_map xs ~f =
  OCLL.concat (OCLL.map xs ~f)

(* @todo Make terminal recursive *)
let rec cartesian_product xs ys =
  match xs with
    | [] -> []
    | x::xs -> OCLL.append (OCLL.map ys ~f:(fun y -> (x, y))) (cartesian_product xs ys)
