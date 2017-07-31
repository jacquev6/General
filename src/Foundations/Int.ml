type t = int

let zero = 0
let one = 1
let smallest = OCSP.min_int
let greatest = OCSP.max_int

let of_int = Function.identity
let to_int = Function.identity
let of_float = OCSP.int_of_float
let to_float = OCSP.float_of_int
let of_string = OCSP.int_of_string
let to_string = OCSP.string_of_int

let repr = OCSP.string_of_int

let add = OCSP.(+)
let substract = OCSP.(-)
let negate = OCSP.(~-)
let posate = OCSP.(~+)
let multiply = OCSP.( * )
let divide = OCSP.(/)
let square x = multiply x x
let abs = OCSP.abs
let modulo = OCSP.(mod)
let pred = OCSP.pred
let succ = OCSP.succ

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let (~-) = OCSP.(~-)
  let (~+) = OCSP.(~+)
  let (+) = OCSP.(+)
  let (-) = OCSP.(-)
  let ( * ) = OCSP.( * )
  let (/) = OCSP.(/)
  let (mod) = OCSP.(mod)
end

include (Compare.Poly: module type of Compare.Poly with module O := O)
include (Equate.Poly: module type of Equate.Poly with module O := O)
