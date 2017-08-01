include Foundations.Reference

module Specialize(E: sig type t end) = struct
  type t = E.t Foundations.Reference.t

  include (
    Foundations.Reference:
    module type of Foundations.Reference
    with type 'a t := 'a Foundations.Reference.t
  )
end

module SpecializePredSucc(E: Traits.PredSucc.S0) = struct
  open Foundations.Reference.O

  let increment r =
    r := E.succ !r

  let decrement r =
    r := E.pred !r
end
