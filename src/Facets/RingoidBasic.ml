#include "../Generated/Facets/RingoidBasic.ml"

module Subtract = struct
  include Subtract_.MakeMakers(struct
    let subtract ~negate ~add x y =
      add x (negate y)
  end)
end

(* @todo Transfer some tests from Ringoid here. Beware: examples added here won't be applied to tests defined in Ringoid, but we *want* them to. *)
#include "empty_facet.ml"
