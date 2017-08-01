module OCSP = OCamlStandard.Pervasives

module Self = struct
  type 'a t = 'a OCSP.ref = {
    mutable contents: 'a;
  }

  let of_contents = OCSP.ref
  let contents = OCSP.(!)
  let assign = OCSP.(:=)

  module O = struct
    let ref = OCSP.ref
    let (!) = OCSP.(!)
    let (:=) = OCSP.(:=)
  end
end

include Self

module Specialize(E: sig type t end) = struct
  type t = E.t Self.t

  include (
    Self:
    module type of Self
    with type 'a t := 'a Self.t
  )
end

module SpecializePredSucc(E: Traits.PredSucc.S0) = struct
  open Self.O

  let increment r =
    r := E.succ !r

  let decrement r =
    r := E.pred !r
end
