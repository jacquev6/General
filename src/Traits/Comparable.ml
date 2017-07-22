module Result = struct
  type t = GT | EQ | LT
end

module Basic = struct
  module type S0 = sig
    type t

    val compare: t -> t -> Result.t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (<): t -> t -> bool
    val (<=): t -> t -> bool
    val (>): t -> t -> bool
    val (>=): t -> t -> bool
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool

    val min: t -> t -> t
    val max: t -> t -> t

    module O: Operators.S0 with type t := t
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    open B
    open Result

    let less_than a b = compare a b = LT
    let less_or_equal a b = compare a b <> GT
    let greater_than a b = compare a b = GT
    let greater_or_equal a b = compare a b <> LT

    let min a b = match compare a b with LT -> a | GT | EQ -> b
    let max a b = match compare a b with GT -> a | LT | EQ -> b

    module O = struct
      let (<) = less_than
      let (<=) = less_or_equal
      let (>) = greater_than
      let (>=) = greater_or_equal
    end
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end
