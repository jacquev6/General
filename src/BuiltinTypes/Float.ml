include Concepts.Numbers.RealNumber.Make0(struct
  type t = float

  let equal x y =
    Pervasives.(=) x y

  let compare x y =
    Compare.Poly.compare x y

  let zero = 0.

  let one = 1.

  let of_int x =
    Pervasives.float_of_int x

  let to_int x =
    Pervasives.int_of_float x

  let of_float x =
    x

  let to_float x =
    x

  let of_string x =
    Pervasives.float_of_string x

  let repr x =
    Pervasives.string_of_float x

  let add x y =
    Pervasives.(+.) x y

  let substract x y =
    Pervasives.(-.) x y

  let negate x =
    Pervasives.(~-.) x

  let multiply x y =
    Pervasives.( *. ) x y

  let divide x y =
    Pervasives.(/.) x y

  let abs x =
    Pervasives.abs_float x
end)
