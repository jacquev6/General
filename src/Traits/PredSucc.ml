module Generated = struct
  #include "../Generated/Traits/PredSucc.ml"
end

include Generated

module PredSucc = struct
  module Make0(M: sig
    type t
    val one: t
    val add: t -> t -> t
    val substract: t -> t -> t
  end) = struct
    open M
    let pred x = substract x one
    let succ x = add x one
  end
end

module Tests = struct
  include Tests_

  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = E

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M

    let tests = (
      E.succ
      |> List.flat_map ~f:(fun (p, s) ->
        let rp = repr p and rs = repr s in
        [
          ~: "succ %s" rp (lazy (check ~repr ~equal ~expected:s (succ p)));
          ~: "pred %s" rs (lazy (check ~repr ~equal ~expected:p (pred s)));
        ]
      )
    )
  end

  include MakeMakers(MakeExamples)(MakeTests)
end
