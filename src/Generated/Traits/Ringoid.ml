module Operators = struct
  module type S0 = sig
    type t
    val ( ~- ): t -> t
    val ( + ): t -> t -> t
    val ( - ): t -> t -> t
    val ( * ): t -> t -> t
    val ( / ): t -> t -> t
    val ( ** ): t -> int -> t
  end
  module Make0(M: sig
    type t
    val negate: t -> t
    val add: t -> t -> t
    val substract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t
    val exponentiate: t -> int -> t
  end) = struct
    let ( ~- ) = M.negate
    let ( + ) = M.add
    let ( - ) = M.substract
    let ( * ) = M.multiply
    let ( / ) = M.divide
    let ( ** ) = M.exponentiate
  end
end
module Basic = struct
  module type S0 = sig
    type t
    val zero: t
    val one: t
    val negate: t -> t
    val add: t -> t -> t
    val substract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t
  end
end
module type S0 = sig
  include Basic.S0
  module O: Operators.S0 with type t := t
  val square: t -> t
  val exponentiate: t -> int -> t
end
module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      val add_substract: (t * t * t) list
      val negate: (t * t) list
      val multiply: (t * t * t) list
      val divide: (t * t * t) list
      val exponentiate: (t * int * t) list
    end
  end
end
