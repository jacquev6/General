type 'a t = 'a option

let equal x y ~equal =
  match (x, y) with
    | (None, None) -> true
    | (None, Some _) | (Some _, None) -> false
    | (Some x, Some y) -> equal x y

let compare x y ~compare =
  match (x, y) with
    | (None, None) -> Compare.EQ
    | (None, Some _) -> Compare.LT
    | (Some _, None) -> Compare.GT
    | (Some x, Some y) -> compare x y

let repr x ~repr =
  match x with
    | None -> "None"
    | Some x -> Format_.sprintf "Some %s" (repr x)

let some_if condition value =
  if condition then Some (Lazy_.force value) else None
