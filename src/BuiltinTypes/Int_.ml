module SelfA = struct
  type t = int

  let equal x y =
    OCamlStandard.Pervasives.(=) x y

  let zero = 0

  let one = 1

  let of_int x =
    x

  let to_int x =
    x

  let of_float x =
    OCamlStandard.Pervasives.int_of_float x

  let to_float x =
    OCamlStandard.Pervasives.float_of_int x

  let of_string x =
    OCamlStandard.Pervasives.int_of_string x

  let to_string x =
    OCamlStandard.Pervasives.string_of_int x

  let repr x =
    OCamlStandard.Pervasives.string_of_int x

  let add x y =
    OCamlStandard.Pervasives.(+) x y

  let substract x y =
    OCamlStandard.Pervasives.(-) x y

  let negate x =
    OCamlStandard.Pervasives.(~-) x

  let multiply x y =
    OCamlStandard.Pervasives.( * ) x y

  let divide x y =
    OCamlStandard.Pervasives.(/) x y

  let abs x =
    OCamlStandard.Pervasives.abs x

  let exponentiate_negative_exponent ~exponentiate:_ _ _ =
    OCamlStandard.Pervasives.invalid_arg "Negative exponent"
end

module SelfB = struct
  include Traits_.Ringoid_.Square.Make0(SelfA)
  include SelfA
end

module SelfC = struct
  include Concepts_.Integer_.PredSucc.Make0(SelfB)
  include Traits_.Equatable_.Different.Make0(SelfB)
  include Traits_.Ringoid_.Exponentiate.Make0(SelfB)
  include SelfB
end

include SelfC

module O = struct
  include Compare_.Poly.O
  include Traits_.Equatable_.Operators.Make0(SelfC)
  include Traits_.Ringoid_.Operators.Make0(SelfC)
end

include (Compare_.Poly: module type of Compare_.Poly with module O := O)
