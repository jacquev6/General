module Tests_ = struct
  module type Examples = sig
    include Concepts.Integer.Tests.Examples.S0 with type t := Pervasives.OCamlStandard.Nativeint.t
  end

  module type Testable = sig
    type t = Pervasives.OCamlStandard.Nativeint.t
    include Concepts.Integer.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "NativeInt" >:: [
      (let module T = Concepts.Integer.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
