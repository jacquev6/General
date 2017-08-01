type t = string list

open Implementation

let concat ?(sep="") xs =
  xs
  |> List_.try_reduce ~f:(fun a b -> a ^ sep ^ b)
  |> Option.value_def ~def:""
