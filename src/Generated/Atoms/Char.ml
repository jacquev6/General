module Tests_ = struct
  module type Examples = sig
    include Facets.Able.Tests.Examples.S0 with type t := char
    include Facets.Displayable.Tests.Examples.S0 with type t := char
    include Facets.OfInt.Tests.Examples.S0 with type t := char
    include Facets.ToInt.Tests.Examples.S0 with type t := char
  end

  module type Testable = sig
    type t = char
    include Facets.Able.Tests.Testable.S0 with type t := t
    include Facets.Displayable.Tests.Testable.S0 with type t := t
    include Facets.OfInt.Tests.Testable.S0 with type t := t
    include Facets.ToInt.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Char" >:: OCamlStandard.Pervasives.( @ ) [
      (let module T = Facets.Able.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.OfInt.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.ToInt.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end
