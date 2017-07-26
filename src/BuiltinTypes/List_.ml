include OCamlStandard.ListLabels

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
