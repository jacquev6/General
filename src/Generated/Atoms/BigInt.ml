module Tests_ = struct
  module type Examples = sig
    include Facets.Integer.Tests.Examples.S0 with type t := OCamlStandard.Big_int.big_int
  end

  module type Testable = sig
    type t = OCamlStandard.Big_int.big_int
    include Facets.Integer.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "BigInt" >:: OCamlStandard.Pervasives.( @ ) [
      (let module T = Facets.Integer.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end
