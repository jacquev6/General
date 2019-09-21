(*
module Tests_ = struct
  module type Examples = sig
    include Facets.Able.Tests.Examples.S0 with type t := bool
    include Facets.Stringable.Tests.Examples.S0 with type t := bool
  end

  module type Testable = sig
    type t = bool
    include Facets.Able.Tests.Testable.S0 with type t := t
    include Facets.Stringable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Bool" >:: [
      (let module T = Facets.Able.Tests.Make0(M)(E) in T.test);
      (let module T = Facets.Stringable.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end

*)
