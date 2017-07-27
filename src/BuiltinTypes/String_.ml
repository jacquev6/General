type t = string

include Equate_.Poly

let repr x =
  OCamlStandard.Printf.sprintf "%S" x
