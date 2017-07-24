include Concepts.Numbers.Integer.Make0(struct
  type t = int

  let equal x y =
    Pervasives.(=) x y

  let compare x y =
    Compare.Poly.compare x y

  let zero = 0

  let one = 1

  let of_int x =
    x

  let to_int x =
    x

  let of_float x =
    Pervasives.int_of_float x

  let to_float x =
    Pervasives.float_of_int x

  let of_string x =
    Pervasives.int_of_string x

  let repr x =
    Pervasives.string_of_int x

  let add x y =
    Pervasives.(+) x y

  let substract x y =
    Pervasives.(-) x y

  let negate x =
    Pervasives.(~-) x

  let multiply x y =
    Pervasives.( * ) x y

  let divide x y =
    Pervasives.(/) x y

  let abs x =
    Pervasives.abs x
end)
