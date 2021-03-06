module OCSP = OCamlStandard.Pervasives
module OCSS = OCamlStandard.String

type t = char

let of_int = OCSP.char_of_int
let to_int = OCSP.int_of_char

let repeat c ~len =
  OCSS.make len c

let to_string c =
  OCSS.make 1 c

let repr c =
  to_string c

(* @todo include Equate.Poly *)
let equal = Equate.Poly.equal
include Compare.Poly
