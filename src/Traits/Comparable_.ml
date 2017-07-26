module Basic = struct
  module type S0 = sig
    type t

    val compare: t -> t -> Compare.t
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

module Make0(B: Basic.S0) = struct
  include B

  open Compare

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

  let min x y =
    match compare x y with LT -> x | GT | EQ -> y

  let max x y =
    match compare x y with GT -> x | LT | EQ -> y

  let min_max x y =
    match compare x y with LT -> (x, y) | GT | EQ -> (y, x)

  module O = struct
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
