module Basic = struct
  module type SP = sig
    val compare: 'a -> 'a -> Compare_.t
  end

  module type S0 = sig
    type t

    val compare: t -> t -> Compare_.t
  end
end

module Operators = struct
  module type SP = sig
    val (<): 'a -> 'a -> bool
    val (<=): 'a -> 'a -> bool
    val (>): 'a -> 'a -> bool
    val (>=): 'a -> 'a -> bool
  end

  module type S0 = sig
    type t

    val (<): t -> t -> bool
    val (<=): t -> t -> bool
    val (>): t -> t -> bool
    val (>=): t -> t -> bool
  end

  module Make0(M: sig
    type t

    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool
  end) = struct
    open M

    let (<) x y =
      less_than x y

    let (<=) x y =
      less_or_equal x y
    let (>) x y =
      greater_than x y

    let (>=) x y =
      greater_or_equal x y
  end
end

module type SP = sig
  include Basic.SP

  val less_than: 'a -> 'a -> bool
  val less_or_equal: 'a -> 'a -> bool
  val greater_than: 'a -> 'a -> bool
  val greater_or_equal: 'a -> 'a -> bool

  val min: 'a -> 'a -> 'a
  val max: 'a -> 'a -> 'a
  val min_max: 'a -> 'a -> 'a * 'a

  module O: Operators.SP
end

module type S0 = sig
  include Basic.S0

  val less_than: t -> t -> bool
  val less_or_equal: t -> t -> bool
  val greater_than: t -> t -> bool
  val greater_or_equal: t -> t -> bool

  val min: t -> t -> t
  val max: t -> t -> t
  val min_max: t -> t -> t * t

  module O: Operators.S0 with type t := t
end

module GreaterLessThan = struct
  module Make0(M: sig
    type t

    val compare: t -> t -> Compare_.t
  end) = struct
    open M
    open Compare_

    let less_than x y =
      match compare x y with
        | LT -> true
        | _ -> false

    let less_or_equal x y =
      match compare x y with
        | GT -> false
        | _ -> true

    let greater_than x y =
      match compare x y with
        | GT -> true
        | _ -> false

    let greater_or_equal x y =
      match compare x y with
        | LT -> false
        | _ -> true
  end
end

module MinMax = struct
  module Make0(M: sig
    type t

    val compare: t -> t -> Compare_.t
  end) = struct
    open M
    open Compare_

    let min x y =
      match compare x y with LT -> x | GT | EQ -> y

    let max x y =
      match compare x y with GT -> x | LT | EQ -> y

    let min_max x y =
      match compare x y with LT -> (x, y) | GT | EQ -> (y, x)
  end
end
