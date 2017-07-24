include ListLabels

(* @todo Make terminal recursive *)
let concat_map xs ~f =
  xs
  |> map ~f
  |> concat

(* @todo Make terminal recursive *)
let rec cartesian_product xs ys =
  match xs with
    | [] -> []
    | x::xs -> (map ys ~f:(fun y -> (x, y))) @ (cartesian_product xs ys)

let fold = fold_left

let head = hd

let tail = tl
