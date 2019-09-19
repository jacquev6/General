module type S0 = sig
  type t
  module Bitwise: sig
    val logical_and: t -> t -> t
    val logical_or: t -> t -> t
    val logical_xor: t -> t -> t
    val logical_not: t -> t
    val logical_shift_left: t -> shift:(int) -> t
    val logical_shift_right: t -> shift:(int) -> t
    val arithmetic_shift_right: t -> shift:(int) -> t
  end
end

module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
    end
  end

  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "Bitwise" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
