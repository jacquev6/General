module Tests_ = struct
  module type Examples = sig
    include Facets.Representable.Tests.Examples.S0 with type t := OCamlStandard.Printexc.location
  end

  module type Testable = sig
    type t = OCamlStandard.Printexc.location
    include Facets.Representable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Location" >:: OCSP.(@) [
      (let module T = Facets.Representable.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end
