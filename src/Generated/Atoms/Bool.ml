module Tests_ = struct
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S0 with type t := bool
    include Concepts.Stringable.Tests.Examples.S0 with type t := bool
  end

  module type Testable = sig
    type t = bool
    include Concepts.Able.Tests.Testable.S0 with type t := t
    include Concepts.Stringable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Bool" >:: [
      (let module T = Concepts.Able.Tests.Make0(M)(E) in T.test);
      (let module T = Concepts.Stringable.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
