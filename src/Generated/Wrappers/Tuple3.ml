module Tests_ = struct
  type ('a, 'b, 'c) t = 'a * 'b * 'c
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end

  module type Testable = sig
    type ('a, 'b, 'c) t = 'a * 'b * 'c
    include Concepts.Able.Tests.Testable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Tuple3" >:: [
      (let module T = Concepts.Able.Tests.Make3(M)(E) in T.test);
    ] @ Tests.tests
  end
end
