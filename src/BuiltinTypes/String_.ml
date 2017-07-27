type t = string

include Equate_.Poly

let repr x =
  Format_.sprintf "%S" x
