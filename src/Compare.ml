type t = LT | EQ | GT

module Poly = struct
  let compare a b =
    let c = compare a b in
    if c = 0 then EQ else if c < 0 then LT else GT
end
