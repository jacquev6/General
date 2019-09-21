#include "../Generated/Atoms/Unit.ml"

module Self = struct
  include Foundations.Unit

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)

  let repr () = "()"
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
    let representations = [
        ((), "()");
    ]

    let equalities = [
        [()];
    ]

    let differences = []

    let orders = []
end)(struct
  let tests = []
end)
*)
