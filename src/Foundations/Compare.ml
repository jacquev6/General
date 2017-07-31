type t = LT | EQ | GT

let of_standard compare =
  fun x y ->
    match compare x y with
      | 0 -> EQ
      | c when OCSP.(<) c 0 -> LT
      | _ -> GT

module Poly = struct
  let compare x y = of_standard OCSP.compare x y
  let less_than = OCSP.(<)
  let less_or_equal = OCSP.(<=)
  let greater_or_equal = OCSP.(>=)
  let greater_than = OCSP.(>)
  let min = OCSP.min
  let max = OCSP.max

  let min_max x y =
    match compare x y with LT -> (x, y) | GT | EQ -> (y, x)

  module O = struct
    let (<) = OCSP.(<)
    let (<=) = OCSP.(<=)
    let (>=) = OCSP.(>=)
    let (>) = OCSP.(>)
  end
end
