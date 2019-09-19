module Tests_ = struct
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S1 with type 'a t := 'a option
  end

  module type Testable = sig
    type 'a t = 'a option
    include Concepts.Able.Tests.Testable.S1 with type 'a t := 'a t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Option" >:: [
      (let module T = Concepts.Able.Tests.Make1(M)(E) in T.test);
    ] @ Tests.tests
  end
end
