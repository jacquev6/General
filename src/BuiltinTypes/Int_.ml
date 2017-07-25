include Concepts_.Integer_.Make0(struct
  type t = int

  let equal x y =
    OCamlStandard.Pervasives.(=) x y

  let compare x y =
    Compare.Poly.compare x y

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
end)
