module Operators = struct
  module type S0 = sig
    type t
    include Number.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t
    val ( mod ): t -> t -> t
  end

  module Make0(M: sig
    type t
    val modulo: t -> t -> t
  end) = struct
    let ( mod ) = M.modulo
  end
end

module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Number.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O
  include Traits.ToStandardNumbers.S0 with type t := t
  val abs: t -> t
  val modulo: t -> t -> t
end

module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      include Number.Tests.Examples.S0 with type t := t
      include Traits.Comparable.Tests.Examples.S0 with type t := t
      include Traits.ToStandardNumbers.Tests.Examples.S0 with type t := t
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
      let test = "RealNumber" >:: [
        (let module T = Number.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.ToStandardNumbers.Tests.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
