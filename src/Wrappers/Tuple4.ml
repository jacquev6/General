#include "../Generated/Wrappers/Tuple4.ml"

module SelfA = Foundations.Tuple4

module SelfB = struct
  include SelfA
  include Facets.Comparable.GreaterLessThan.Make4(SelfA)
  include Facets.Comparable.MinMax.Make4(SelfA)
  include Facets.Equatable.Different.Make4(SelfA)
end

module Self = struct
  include SelfB
  include Facets.Comparable.Between.Make4(SelfB)
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
  module A = Foundations.Int
  module B = Foundations.String
  module C = Foundations.Float
  module D = Foundations.Int

  let representations = [
    ((1, "a", 2., 3), "(1, \"a\", 2., 3)");
  ]

  let equalities = [
    [(1, "a", 2., 3)];
  ]

  let differences = [
    ((1, "a", 2., 3), (1, "a", 2., 4));
    ((1, "a", 2., 3), (1, "a", 3., 3));
    ((1, "a", 2., 3), (1, "b", 2., 3));
    ((1, "a", 2., 3), (0, "a", 2., 3));
  ]

  let orders = [
    [(1, "a", 2., 3); (1, "a", 2., 4); (1, "a", 3., 3); (1, "b", 2., 3); (2, "a", 2., 3)]
  ]
end)(struct
  open Testing

  let tests = [
    "make" >: (lazy (check_int_tuple4 ~expected:(1, 2, 3, 4) (make 1 2 3 4)));
    "flip" >: (lazy (check_int_tuple4 ~expected:(1, 2, 3, 4) (flip (4, 3, 2, 1))));
    "get_0" >: (lazy (check_42 (get_0 (42, 0, 0, 0))));
    "get_1" >: (lazy (check_42 (get_1 (0, 42, 0, 0))));
    "get_2" >: (lazy (check_42 (get_2 (0, 0, 42, 0))));
    "get_3" >: (lazy (check_42 (get_3 (0, 0, 0, 42))));
  ]
end)
*)
