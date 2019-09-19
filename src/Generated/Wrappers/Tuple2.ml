module Tests_ = struct
  type ('a, 'b) t = 'a * 'b
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t
  end

  module type Testable = sig
    type ('a, 'b) t = 'a * 'b
    include Concepts.Able.Tests.Testable.S2 with type ('a, 'b) t := ('a, 'b) t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Tuple2" >:: [
      (let module T = Concepts.Able.Tests.Make2(M)(E) in T.test);
    ] @ Tests.tests
  end
end
