module type S0 = sig
  type t
  include ToInt.S0 with type t := t
  include ToFloat.S0 with type t := t
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type S0 = sig
      type t
      include ToInt.Tests_beta(Testing).Examples.S0 with type t := t
      include ToFloat.Tests_beta(Testing).Examples.S0 with type t := t
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
      include Representable.S0 with type t := t
    end
  end

  module MakeMakers(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      let test = "ToStandardNumber" >:: [
        (let module T_alpha = ToInt.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
        (let module T_alpha = ToFloat.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
