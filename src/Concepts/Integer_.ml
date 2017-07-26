module type S0 = sig
  include RealNumber_.S0

  val succ: t -> t
  val pred: t -> t
end

module PredSucc = struct
  module Make0(M: sig
    type t

    val one: t

    val add: t -> t -> t
    val substract: t -> t -> t
  end) = struct
    open M

    let pred x =
      substract x one

    let succ x =
      add x one
  end
end
