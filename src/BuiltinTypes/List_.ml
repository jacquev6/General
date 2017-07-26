(*BISECT-IGNORE-BEGIN*) (* @todo Implement, test and publish *)
include OCamlStandard.ListLabels

let (|>) = OCamlStandard.Pervasives.(|>)

(* @todo Make terminal recursive *)
let concat_map xs ~f =
  concat (map xs ~f)

(* @todo Make terminal recursive *)
let rec cartesian_product xs ys =
  match xs with
    | [] -> []
    | x::xs -> append (map ys ~f:(fun y -> (x, y))) (cartesian_product xs ys)

let fold = fold_left

let head = hd

let tail = tl

let reverse = rev

let repr xs ~repr =
  xs
  |> map ~f:repr
  |> OCamlStandard.StringLabels.concat ~sep:", "
  |> OCamlStandard.Printf.sprintf "[%s]"

let equal xs ys ~equal =
  try
    for_all2 ~f:equal xs ys
  with
    | Invalid_argument _ -> false
(*BISECT-IGNORE-END*)
