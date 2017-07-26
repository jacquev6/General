module Lazy = OCamlStandard.Lazy
module Printf = OCamlStandard.Printf

module Self = struct
  type 'a t = 'a option

  let equal x y ~equal =
    match (x, y) with
      | (None, None) -> true
      | (None, Some _) | (Some _, None) -> false
      | (Some x, Some y) -> equal x y

  let repr x ~repr =
    match x with
      | None -> "None"
      | Some x -> Printf.sprintf "Some %s" (repr x)

  let some_if condition value =
    if condition then Some (Lazy.force value) else None
end

include Traits_.Equatable_.Different.Make1(Self)
include Self
