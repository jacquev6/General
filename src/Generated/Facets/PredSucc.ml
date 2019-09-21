module type S0 = sig
  type t
  val pred: t -> t
  val succ: t -> t
end

module PredSucc_ = struct
  module MakeMakers(Implementation: sig
    val pred: one:('a) -> add:('a -> 'a -> 'a) -> subtract:('a -> 'a -> 'a) -> 'a -> 'a
    val succ: one:('a) -> add:('a -> 'a -> 'a) -> subtract:('a -> 'a -> 'a) -> 'a -> 'a
  end) = struct
    module Make0(M: sig
      type t
      val one: t
      val add: t -> t -> t
      val subtract: t -> t -> t
    end) = struct
      let pred x = Implementation.pred ~one:(M.one) ~add:(M.add) ~subtract:(M.subtract) x
      let succ x = Implementation.succ ~one:(M.one) ~add:(M.add) ~subtract:(M.subtract) x
    end
  end
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type S0 = sig
      type t
      val successions: (t * t) list
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
      let test = "PredSucc" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
