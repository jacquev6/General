type t = LT | EQ | GT

open OCamlStandard.Pervasives

let of_standard compare =
  fun x y ->
    match compare x y with
      | 0 -> EQ
      | c when c < 0 -> LT
      | _ -> GT

module Poly = struct
  let compare x y =
    of_standard compare x y

  let less_than x y =
    x < y

  let less_or_equal x y =
    x <= y

  let greater_or_equal x y =
    x >= y

  let greater_than x y =
    x > y

  let min x y =
    match compare x y with LT -> x | GT | EQ -> y

  let max x y =
    match compare x y with GT -> x | LT | EQ -> y

  let min_max x y =
    match compare x y with LT -> (x, y) | GT | EQ -> (y, x)

  module O = struct
    let (<) x y =
      x < y

    let (<=) x y =
      x <= y

    let (>=) x y =
      x >= y

    let (>) x y =
      x > y
  end
end
