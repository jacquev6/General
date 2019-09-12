module Generated = struct
  #include "../Generated/Concepts/Integer.ml"
end

include Generated

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    include E

    let succ = succ @ [
      (M.zero, M.one);
    ]
  end

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let tests = []
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
