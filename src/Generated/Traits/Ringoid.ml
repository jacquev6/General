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
  module Testable = struct
    module type S0 = sig
      include S0
      include Equatable.Basic.S0 with type t := t
      include Representable.S0 with type t := t
    end
  end
  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "Ringoid" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
