(* The position of these symbols is unit-tested. Moving them requires fixing the tests. *)
let rec stack = function
  | 0 -> [Some (current ())]
  | n -> None::(stack Int.O.(n - 1))

let stack =
  stack 4
  |> List.filter_map ~f:Function1.identity
  |> List.head
