type t = LT | EQ | GT

module Poly = struct
  let compare x y =
    let c = compare x y in
    if c = 0 then EQ else if c < 0 then LT else GT
end
