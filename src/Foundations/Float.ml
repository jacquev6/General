type t = float

let zero = 0.
let one = 1.
let smallest = OCSP.min_float
let greatest = OCSP.max_float
let epsilon = OCSP.epsilon_float
let infinity = OCSP.infinity
let negative_infinity = OCSP.neg_infinity
let not_a_number = OCSP.nan

let of_int = OCSP.float_of_int
let to_int = OCSP.int_of_float
let of_float = Function.identity
let to_float = Function.identity
let of_string = OCSP.float_of_string
let to_string = OCSP.string_of_float

let repr = OCSP.string_of_float

let add = OCSP.(+.)
let substract = OCSP.(-.)
let negate = OCSP.(~-.)
let posate = OCSP.(~+.)
let multiply = OCSP.( *. )
let divide = OCSP.(/.)
let square x = multiply x x
let abs = OCSP.abs_float
let modulo = OCSP.mod_float

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let (~-) = OCSP.(~-.)
  let (~+) = OCSP.(~+.)
  let (+) = OCSP.(+.)
  let (-) = OCSP.(-.)
  let ( * ) = OCSP.( *. )
  let (/) = OCSP.(/.)
  let (mod) = OCSP.mod_float
end

include (Compare.Poly: module type of Compare.Poly with module O := O)
include (Equate.Poly: module type of Equate.Poly with module O := O)

module O_dot = struct
  let (~-.) = OCSP.(~-.)
  let (~+.) = OCSP.(~+.)
  let (+.) = OCSP.(+.)
  let (-.) = OCSP.(-.)
  let ( *. ) = OCSP.( *. )
  let (/.) = OCSP.(/.)
  let ( ** ) = OCSP.( ** )
end

module Class = struct
  type t =
    | Normal
    | SubNormal
    | Zero
    | Infinite
    | NotANumber

  let of_float x =
    match OCSP.classify_float x with
      | OCSP.FP_normal -> Normal
      | OCSP.FP_subnormal -> SubNormal
      | OCSP.FP_zero -> Zero
      | OCSP.FP_infinite -> Infinite
      | OCSP.FP_nan -> NotANumber

  let repr = function
    | Normal -> "Normal"
    | SubNormal -> "SubNormal"
    | Zero -> "Zero"
    | Infinite -> "Infinite"
    | NotANumber -> "NotANumber"

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)
end
