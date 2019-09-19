module Tests_ = struct
  module type Examples = sig
    include Concepts.Able.Tests.Examples.S0 with type t := Pervasives.OCamlStandard.Printexc.location = {filename: string; line_number: int; start_char: int; end_char: int}
  end

  module type Testable = sig
    type t = Pervasives.OCamlStandard.Printexc.location = {filename: string; line_number: int; start_char: int; end_char: int}
    include Concepts.Able.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Location" >:: [
      (let module T = Concepts.Able.Tests.Make0(M)(E) in T.test);
    ] @ Tests.tests
  end
end
