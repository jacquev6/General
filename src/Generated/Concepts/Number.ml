module Operators = struct
  module type S0 = sig
    type t
    include Identifiable.Operators.S0 with type t := t
    include Traits.Ringoid.Operators.S0 with type t := t
  end
end
module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Identifiable.S0 with type t := t and module O := O
  include Stringable.S0 with type t := t
  include Traits.Ringoid.S0 with type t := t and module O := O
  include Traits.OfStandardNumbers.S0 with type t := t
end
module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      include Identifiable.Tests.Examples.S0 with type t := t
      include Stringable.Tests.Examples.S0 with type t := t
      include Traits.Ringoid.Tests.Examples.S0 with type t := t
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
      let test = "Number" >:: [
        (let module T = Identifiable.Tests.Make0(M)(E) in T.test);
        (let module T = Stringable.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Ringoid.Tests.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
