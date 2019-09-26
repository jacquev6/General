module Operators = struct
  module type S0 = sig
    type t
    include Identifiable.Operators.S0 with type t := t
    include Ringoid.Operators.S0 with type t := t
  end
end

module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Identifiable.S0 with type t := t and module O := O
  include Stringable.S0 with type t := t
  include Ringoid.S0 with type t := t and module O := O
  include OfStandardNumber.S0 with type t := t
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type S0 = sig
      type t
      include Identifiable.Tests_beta(Testing).Examples.S0 with type t := t
      include Stringable.Tests_beta(Testing).Examples.S0 with type t := t
      include Ringoid.Tests_beta(Testing).Examples.S0 with type t := t
      include OfStandardNumber.Tests_beta(Testing).Examples.S0 with type t := t
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
      let test = "Number" >:: [
        (let module T_alpha = Identifiable.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
        (let module T_alpha = Stringable.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
        (let module T_alpha = Ringoid.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
        (let module T_alpha = OfStandardNumber.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
