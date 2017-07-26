module Basic = RealNumber_.Basic

module Operators = RealNumber_.Operators

module type S0 = sig
  include RealNumber_.S0

  val succ: t -> t
  val pred: t -> t
end

module Makeable = struct
  module type S0 = sig
    include Basic.S0

    include Traits_.Ringoid_.Makeable.S0 with type t := t
  end
end

module Make0(B: Makeable.S0) = struct
  include RealNumber_.Make0(B)

  let succ x =
    add x one

  let pred x =
    substract x one
end
