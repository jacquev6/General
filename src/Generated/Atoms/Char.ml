module Tests_ = struct
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S0 with type t := char
    include Traits.Displayable.Tests.Examples.S0 with type t := char
    include Traits.OfInt.Tests.Examples.S0 with type t := char
    include Traits.ToInt.Tests.Examples.S0 with type t := char
  end

  module type Testable = sig
    type t = char
    include Concepts.Able.Tests.Testable.S0 with type t := t
    include Traits.Displayable.Tests.Testable.S0 with type t := t
    include Traits.OfInt.Tests.Testable.S0 with type t := t
    include Traits.ToInt.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Char" >:: [
      (let module T = Concepts.Able.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.OfInt.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.ToInt.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
