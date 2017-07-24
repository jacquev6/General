module Basic = RealNumber.Basic

module Operators = RealNumber.Operators

module type S0 = sig
  include RealNumber.S0

  val succ: t -> t
  val pred: t -> t
end

module Make0(B: Basic.S0) = struct
  include RealNumber.Make0(B)

  let succ x =
    add x one

  let pred x =
    substract x one
end
