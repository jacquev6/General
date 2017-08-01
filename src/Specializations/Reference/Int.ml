module OCSP = OCamlStandard.Pervasives

include Implementation.Reference.Specialize(Implementation.Int)

let increment = OCSP.incr
let decrement = OCSP.decr
