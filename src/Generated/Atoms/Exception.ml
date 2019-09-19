module Tests_ = struct
  module type Examples = sig
    include Facets.Identifiable.Tests.Examples.S0 with type t := exn
    include Facets.Displayable.Tests.Examples.S0 with type t := exn
  end

  module type Testable = sig
    type t = exn
    include Facets.Identifiable.Tests.Testable.S0 with type t := t
    include Facets.Displayable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Exception" >:: [
      (let module T = Facets.Identifiable.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.Displayable.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
