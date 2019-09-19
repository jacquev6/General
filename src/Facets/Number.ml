#include "../Generated/Facets/Number.ml"

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    include E

    let equalities = equalities @ [
      [M.zero; M.of_int 0; M.of_float 0.; M.of_string "0"];
      [M.one; M.of_int 1; M.of_float 1.; M.of_string "1"];
    ]

    let differences = differences @ [
      (M.zero, M.one);
    ]
  end

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let tests = []
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
