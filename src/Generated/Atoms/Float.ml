module Tests_ = struct
  module type Examples = sig
    include Concepts.RealNumber.Tests.Examples.S0 with type t := float
  end

  module type Testable = sig
    type t = float
    include Concepts.RealNumber.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Float" >:: [
      (let module T = Concepts.RealNumber.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
