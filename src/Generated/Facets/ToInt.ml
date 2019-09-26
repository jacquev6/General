module type S0 = sig
  type t
  val to_int: t -> int
end

module Tests_alpha(Testing: Testing) = struct
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

  module MakeMakers(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      let test = "ToInt" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
