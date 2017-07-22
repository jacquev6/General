module Basic = struct
  type t = int

  let equal = (=)

  let compare = Compare.Poly.compare

  let zero = 0
  let one = 1

  let add = (+)
  let sub = (-)
end

include Basic
include Concepts.Numbers.Integer.Extensions.Make0(Basic)
