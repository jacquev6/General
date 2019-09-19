module Tests_ = struct
  module type Examples = sig
    include Facets.Displayable.Tests.Examples.S0 with type t := Pervasives.OCamlStandard.Printexc.raw_backtrace
    include Facets.Representable.Tests.Examples.S0 with type t := Pervasives.OCamlStandard.Printexc.raw_backtrace
  end

  module type Testable = sig
    type t = Pervasives.OCamlStandard.Printexc.raw_backtrace
    include Facets.Displayable.Tests.Testable.S0 with type t := t
    include Facets.Representable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "CallStack" >:: [
      (let module T = Facets.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.Representable.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
