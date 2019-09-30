module Tests_ = struct
  module type Examples = sig
    include Facets.RealNumber.Tests.Examples.S0 with type t := float
    include Facets.Bounded.Tests.Examples.S0 with type t := float
  end

  module type Testable = sig
    type t = float
    include Facets.RealNumber.Tests.Testable.S0 with type t := t
    include Facets.Bounded.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Float" >:: OCamlStandard.Pervasives.( @ ) [
      (let module T = Facets.RealNumber.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.Bounded.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end
