module Tests_ = struct
  module type Examples = sig
    include Concepts.Identifiable.Tests.Examples.S0 with type t := exn
    include Traits.Displayable.Tests.Examples.S0 with type t := exn
  end

  module type Testable = sig
    type t = exn
    include Concepts.Identifiable.Tests.Testable.S0 with type t := t
    include Traits.Displayable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Exception" >:: [
      (let module T = Concepts.Identifiable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
