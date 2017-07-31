type 'a t = 'a list

open Function.O (* We may want to move this file to the next layer and benefit from the automated open *)

module OCLL = OCamlStandard.ListLabels

(* @todo Make terminal recursive *)
let concat_map xs ~f =
  OCLL.concat (OCLL.map xs ~f)

(* @todo Make terminal recursive *)
let map = OCLL.map

(* @todo Make terminal recursive *)
let iter = OCLL.iter

(* @todo Make terminal recursive *)
let rec cartesian_product xs ys =
  match xs with
    | [] -> []
    | x::xs -> OCLL.append (OCLL.map ys ~f:(fun y -> (x, y))) (cartesian_product xs ys)

let fold = OCLL.fold_left

let head = OCLL.hd

let tail = OCLL.tl

let reverse = OCLL.rev

let repr xs ~repr =
  xs
  |> OCLL.map ~f:repr
  |> OCamlStandard.StringLabels.concat ~sep:", "
  |> Format_.sprintf "[%s]"

let equal xs ys ~equal =
  try
    OCLL.for_all2 ~f:equal xs ys
  with
    | Invalid_argument _ -> false

module O = struct
  let (@) = OCSP.(@) (* @todo Make terminal-recursive *)
end
