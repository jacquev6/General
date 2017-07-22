module Basic = struct
  type t = int

  let equal = (=)
end

include Basic

include Traits.Equatable.Make0(Basic)

let zero = 0
let one = 1

let add = (+)
let sub = (-)
