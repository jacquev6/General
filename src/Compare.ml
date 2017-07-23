type t = LT | EQ | GT

module Poly = struct
  let compare x y =
    match Pervasives.compare x y with
      | 0 -> EQ
      | c when Pervasives.(<) c 0 -> LT
      | _ -> GT
end
