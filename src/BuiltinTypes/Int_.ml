module P = OCamlStandard.Pervasives

module SelfA = struct
  type t = int

  let zero = 0
  let one = 1
  let smallest = P.min_int
  let greatest = P.max_int

  let of_int x =
    x

  let to_int x =
    x

  let of_float x =
    P.int_of_float x

  let to_float x =
    P.float_of_int x

  let of_string x =
    P.int_of_string x

  let to_string x =
    P.string_of_int x

  let repr x =
    P.string_of_int x

  let add x y =
    P.(+) x y

  let substract x y =
    P.(-) x y

  let negate x =
    P.(~-) x

  let multiply x y =
    P.( * ) x y

  let divide x y =
    P.(/) x y

  let abs x =
    P.abs x

  let modulo x y =
    P.(mod) x y

  let exponentiate_negative_exponent ~exponentiate:_ _ n =
    Exception_.invalid_argument "Int.exponentiate: Negative exponent: %i" n
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
    P.(mod) x y
end

include (Compare_.Poly: module type of Compare_.Poly with module O := O)
include (Equate_.Poly: module type of Equate_.Poly with module O := O)
include SelfC
