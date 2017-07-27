module P = OCamlStandard.Pervasives

module SelfA = struct
  type t = float

  let zero = 0.
  let one = 1.
  let greatest = P.max_float
  let smallest = P.min_float
  let epsilon = P.epsilon_float
  let infinity = P.infinity
  let negative_infinity = P.neg_infinity
  let not_a_number = P.nan

  let of_int x =
    P.float_of_int x

  let to_int x =
    P.int_of_float x

  let of_float x =
    x

  let to_float x =
    x

  let of_string x =
    P.float_of_string x

  let to_string x =
    P.string_of_float x

  let repr x =
    P.string_of_float x

  let add x y =
    P.(+.) x y

  let substract x y =
    P.(-.) x y

  let negate x =
    P.(~-.) x

  let multiply x y =
    P.( *. ) x y

  let divide x y =
    P.(/.) x y

  let abs x =
    P.abs_float x

  let modulo x y =
    P.mod_float x y

  let exponentiate_negative_exponent ~exponentiate x n =
    exponentiate (divide 1. x) P.(-n)
end

module SelfB = struct
  include Traits_.Ringoid_.Square.Make0(SelfA)
  include SelfA
end

module SelfC = struct
  include Concepts_.Integer_.PredSucc.Make0(SelfB)
  include Traits_.Ringoid_.Exponentiate.Make0(SelfB)
  include SelfB
end

module O = struct
  include Compare_.Poly.O
  include Equate_.Poly.O
  include Traits_.Ringoid_.Operators.Make0(SelfC)

  let (mod) x y =
    P.mod_float x y
end

include (Compare_.Poly: module type of Compare_.Poly with module O := O)
include (Equate_.Poly: module type of Equate_.Poly with module O := O)
include SelfC

module Class = struct
  type t =
    | Normal
    | SubNormal
    | Zero
    | Infinite
    | NotANumber

  let of_float x =
    match P.classify_float x with
      | P.FP_normal -> Normal
      | P.FP_subnormal -> SubNormal
      | P.FP_zero -> Zero
      | P.FP_infinite -> Infinite
      | P.FP_nan -> NotANumber

  let repr = function
    | Normal -> "Normal"
    | SubNormal -> "SubNormal"
    | Zero -> "Zero"
    | Infinite -> "Infinite"
    | NotANumber -> "NotANumber"

  module O = struct
    include Compare_.Poly.O
    include Equate_.Poly.O
  end

  include (Compare_.Poly: module type of Compare_.Poly with module O := O)
  include (Equate_.Poly: module type of Equate_.Poly with module O := O)
end
