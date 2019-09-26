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

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type S0 = sig
      type t
      val additions: (t * t * t) list
      val negations: (t * t) list
      val multiplications: (t * t * t) list
      val divisions: (t * t * t) list
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
      include EquatableBasic.S0 with type t := t
      include Representable.S0 with type t := t
    end
  end

  module MakeMakers(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      let test = "RingoidBasic" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
