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
    val subtract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t
    val exponentiate: t -> int -> t
  end) = struct
    let ( ~- ) = M.negate
    let ( + ) = M.add
    let ( - ) = M.subtract
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
    val subtract: t -> t -> t
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

module Subtract_ = struct
  module MakeMakers(Implementation: sig
    val subtract: negate:('a -> 'a) -> add:('a -> 'a -> 'a) -> 'a -> 'a -> 'a
  end) = struct
    module Make0(M: sig
      type t
      val negate: t -> t
      val add: t -> t -> t
    end) = struct
      let subtract x y = Implementation.subtract ~negate:(M.negate) ~add:(M.add) x y
    end
  end
end

module Square_ = struct
  module MakeMakers(Implementation: sig
    val square: multiply:('a -> 'a -> 'a) -> 'a -> 'a
  end) = struct
    module Make0(M: sig
      type t
      val multiply: t -> t -> t
    end) = struct
      let square x = Implementation.square ~multiply:(M.multiply) x
    end
  end
end

module Exponentiate_ = struct
  module MakeMakers(Implementation: sig
    val exponentiate: one:('a) -> square:('a -> 'a) -> multiply:('a -> 'a -> 'a) -> exponentiate_negative_exponent:(exponentiate:('a -> int -> 'a) -> 'a -> int -> 'a) -> 'a -> int -> 'a
  end) = struct
    module Make0(M: sig
      type t
      val one: t
      val square: t -> t
      val multiply: t -> t -> t
      val exponentiate_negative_exponent: exponentiate:(t -> int -> t) -> t -> int -> t
    end) = struct
      let exponentiate x y = Implementation.exponentiate ~one:(M.one) ~square:(M.square) ~multiply:(M.multiply) ~exponentiate_negative_exponent:(M.exponentiate_negative_exponent) x y
    end
  end
end

module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      val additions: (t * t * t) list
      val negations: (t * t) list
      val multiplications: (t * t * t) list
      val divisions: (t * t * t) list
      val exponentiations: (t * int * t) list
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
      include EquatableBasic.S0 with type t := t
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
