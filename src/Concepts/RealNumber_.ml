module Operators = struct
  module type S0 = sig
    include Number_.Operators.S0
    include Traits_.Comparable_.Operators.S0 with type t := t

    val (mod): t -> t -> t
  end
end

module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Number_.S0 with type t := t and module O := O
  include Traits_.Comparable_.S0 with type t := t and module O := O

  val abs: t -> t
  val modulo: t -> t -> t

  val to_int: t -> int
  val to_float: t -> float
end
