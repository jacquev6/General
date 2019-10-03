module Tests_ = struct
  module type Examples = sig
    include Facets.FixedWidthInteger.Tests.Examples.S0 with type t := OCamlStandard.Nativeint.t
  end

  module type Testable = sig
    type t = OCamlStandard.Nativeint.t
    include Facets.FixedWidthInteger.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "NativeInt" >:: OCamlStandard.Pervasives.( @ ) [
      (let module T = Facets.FixedWidthInteger.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end
