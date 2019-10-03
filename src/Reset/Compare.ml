type t = LT | EQ | GT

let of_standard compare =
  fun x y ->
    match compare x y with
      | 0 -> EQ
      | c when OCamlStandard.Pervasives.( < ) c 0 -> LT
      | _ -> GT

let repr = function
  | LT -> "LT"
  | EQ -> "EQ"
  | GT -> "GT"

let equal = Equate.Poly.equal

module Poly = struct
  let compare x y = of_standard OCamlStandard.Pervasives.compare x y
  let less_than = OCamlStandard.Pervasives.( < )
  let less_or_equal = OCamlStandard.Pervasives.( <= )
  let greater_or_equal = OCamlStandard.Pervasives.( >= )
  let greater_than = OCamlStandard.Pervasives.( > )

  let between x ~low ~high =
    OCamlStandard.Pervasives.(&&) (less_than low x) (greater_than high x)

  let between_or_equal x ~low ~high =
    OCamlStandard.Pervasives.(&&) (less_or_equal low x) (greater_or_equal high x)

  let min = OCamlStandard.Pervasives.min
  let max = OCamlStandard.Pervasives.max

  let min_max x y =
    match compare x y with LT -> (x, y) | GT | EQ -> (y, x)

  module O = struct
    let ( < ) = OCamlStandard.Pervasives.( < )
    let ( <= ) = OCamlStandard.Pervasives.( <= )
    let ( >= ) = OCamlStandard.Pervasives.( >= )
    let ( > ) = OCamlStandard.Pervasives.( > )
  end
end
