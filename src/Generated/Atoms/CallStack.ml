module Tests_ = struct
  module type Examples = sig
    include Traits.Displayable.Tests.Examples.S0 with type t := Pervasives.OCamlStandard.Printexc.raw_backtrace
    include Traits.Representable.Tests.Examples.S0 with type t := Pervasives.OCamlStandard.Printexc.raw_backtrace
  end

  module type Testable = sig
    type t = Pervasives.OCamlStandard.Printexc.raw_backtrace
    include Traits.Displayable.Tests.Testable.S0 with type t := t
    include Traits.Representable.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "CallStack" >:: [
      (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Representable.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
