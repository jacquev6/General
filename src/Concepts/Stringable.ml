#include "../Generated/Concepts/Stringable.ml"

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let tests = []
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
