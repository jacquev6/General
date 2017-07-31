type t = int Implementation.Reference.t

include (
  Implementation.Reference:
  module type of Implementation.Reference
  with type 'a t := 'a Implementation.Reference.t
)

let increment = OCSP.incr
let decrement = OCSP.decr
