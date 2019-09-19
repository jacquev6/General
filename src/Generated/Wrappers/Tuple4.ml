module Tests_ = struct
  type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end

  module type Testable = sig
    type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd
    include Concepts.Able.Tests.Testable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Tuple4" >:: [
      (let module T = Concepts.Able.Tests.Make4(M)(E) in T.test);
    ] @ Tests.tests
  end
end
