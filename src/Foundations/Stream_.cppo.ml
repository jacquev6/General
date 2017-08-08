module OCSS = OCamlStandard.Stream

open Reference.O
open Int.O
open Functions.Function1.O

type 'a t = 'a OCSS.t

let empty = OCSS.sempty

let of_list = OCSS.of_list

let singleton = OCSS.ising

let to_list xs =
  let ys = ref [] in
  OCSS.iter (fun x ->
    ys := x::!ys
  ) xs;
  List_.reverse !ys

let concat = OCSS.iapp

let prepend = OCSS.icons

#define FILTER_MAP_I_ACC(NAME) \
let NAME xs ~f = \
  let aux _ = \
    CONCAT(NAME, _next) xs ~f \
  in \
  OCSS.from aux \
\
let CONCAT(NAME, _i) xs ~f = \
  let i = ref (-1) in \
  let aux _ =  \
    CONCAT(NAME, _next) xs ~f:(fun x -> \
      OCSP.incr i; \
      f ~i:!i x \
    ) \
  in \
  OCSS.from aux \
\
let CONCAT(NAME, _acc) ~acc xs ~f = \
  let acc = ref acc in \
  let aux _ = \
    CONCAT(NAME, _next) xs ~f:(fun x -> \
      let (acc', y) = f ~acc:!acc x in \
      acc := acc'; \
      y \
    ) \
  in \
  OCSS.from aux

let map_next xs ~f =
  OCSS.peek xs
  |> Option.map ~f:(fun x ->
    OCSS.junk xs;
    f x
  )

FILTER_MAP_I_ACC(map)

let filter_next xs ~f =
  let rec aux () =
    OCSS.peek xs
    |> Option.filter_map ~f:(fun x ->
      OCSS.junk xs;
      if f x then
        Some x
      else
        aux ()
    )
  in
  aux ()

FILTER_MAP_I_ACC(filter)

let filter_map_next xs ~f =
  let rec aux () =
    OCSS.peek xs
    |> Option.filter_map ~f:(fun x ->
      OCSS.junk xs;
      match f x with
        | None -> aux ()
        | y -> y
    )
  in
  aux ()

FILTER_MAP_I_ACC(filter_map)

let flat_map xs ~f =
  let current = ref None in
  let rec aux n =
    if Option.is_none !current then current := map_next xs ~f;
    match !current with
      | None -> None
      | Some ys -> begin
        match OCSS.peek ys with
          | None -> current := None; aux n
          | x -> OCSS.junk ys; x
      end
  in
  OCSS.from aux

let flat_map_i xs ~f =
  let i = ref (-1)
  and current = ref None in
  let rec aux n =
    if Option.is_none !current then current := map_next xs ~f:(fun x -> OCSP.incr i; f ~i:!i x);
    match !current with
      | None -> None
      | Some ys -> begin
        match OCSS.peek ys with
          | None -> current := None; aux n
          | x -> OCSS.junk ys; x
      end
  in
  OCSS.from aux

let flat_map_acc ~acc xs ~f =
  let acc = ref acc
  and current = ref None in
  let rec aux n =
    if Option.is_none !current then current := map_next xs ~f:(fun x -> let (acc', y) = f ~acc:!acc x in acc := acc'; y);
    match !current with
      | None -> None
      | Some ys -> begin
        match OCSS.peek ys with
          | None -> current := None; aux n
          | x -> OCSS.junk ys; x
      end
  in
  OCSS.from aux
