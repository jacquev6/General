module Tests_ = struct
  type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end

  module type Testable = sig
    type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e
    include Concepts.Able.Tests.Testable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Tuple5" >:: [
      (let module T = Concepts.Able.Tests.Make5(M)(E) in T.test);
    ] @ Tests.tests
  end
end
