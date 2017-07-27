module P = OCamlStandard.Pervasives

type t = bool

include Equate_.Poly

let repr x =
  P.string_of_bool x
