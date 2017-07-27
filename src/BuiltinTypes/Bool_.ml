type t = bool

include Equate_.Poly

let repr x =
  OCamlStandard.Pervasives.string_of_bool x
