type 'a t = 'a option

let equal x y ~equal_a =
  match (x, y) with
    | (None, None) -> true
    | (None, Some _) | (Some _, None) -> false
    | (Some x, Some y) -> equal_a x y

let compare x y ~compare_a =
  match (x, y) with
    | (None, None) -> Compare.EQ
    | (None, Some _) -> Compare.LT
    | (Some _, None) -> Compare.GT
    | (Some x, Some y) -> compare_a x y

let repr x ~repr_a =
  match x with
    | None -> "None"
    | Some x -> Format_.sprintf "Some %s" (repr_a x)

let some_if condition value =
  if condition then Some (Lazy_.value value) else None

let some_if' condition value =
  if condition then Some value else None

let value_def x ~def =
  match x with
    | Some x -> x
    | None -> def

let value ?(exc=Failure "Option.value") x =
  match x with
    | Some x -> x
    | None -> Exception.raise exc

let map x ~f =
  match x with
    | None -> None
    | Some x -> Some (f x)

let value_map x ~def ~f =
  match x with
    | None -> def
    | Some x -> f x

let is_some = function
  | None -> false
  | Some _ -> true

let is_none = function
  | None -> true
  | Some _ -> false

let iter x ~f =
  match x with
    | None -> ()
    | Some x -> f x

let filter x ~f =
  match x with
    | None -> None
    | Some x -> some_if' (f x) x

let filter_map x ~f =
  match x with
    | None -> None
    | Some x -> (f x)
