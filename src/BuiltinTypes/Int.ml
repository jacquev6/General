module Basic = struct
  type t = int

  let equal = (=)

  let compare a b =
    let c = compare a b in
    Traits.Comparable.Result.(if c = 0 then EQ else if c < 0 then LT else GT)

  let zero = 0
  let one = 1

  let add = (+)
  let sub = (-)
end

include Basic
include Concepts.Numbers.Integer.Extensions.Make0(Basic)
