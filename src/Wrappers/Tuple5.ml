#include "../Generated/Wrappers/Tuple5.ml"

module SelfA = Foundations.Tuple5

module SelfB = struct
  include SelfA
  include Facets.Comparable.GreaterLessThan.Make5(SelfA)
  include Facets.Comparable.MinMax.Make5(SelfA)
  include Facets.Equatable.Different.Make5(SelfA)
end

module Self = struct
  include SelfB
  include Facets.Comparable.Between.Make5(SelfB)
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
  module A = Foundations.Int
  module B = Foundations.String
  module C = Foundations.Float
  module D = Foundations.Int
  module E = Foundations.Int

  let representations = [
    ((1, "a", 2., 3, 4), "(1, \"a\", 2., 3, 4)");
  ]

  let equalities = [
    [(1, "a", 2., 3, 4)];
  ]

  let differences = [
    ((1, "a", 2., 3, 4), (1, "a", 2., 3, 5));
    ((1, "a", 2., 3, 4), (1, "a", 2., 4, 4));
    ((1, "a", 2., 3, 4), (1, "a", 3., 3, 4));
    ((1, "a", 2., 3, 4), (1, "b", 2., 3, 4));
    ((1, "a", 2., 3, 4), (0, "a", 2., 3, 4));
  ]

  let orders = [
    [(1, "a", 2., 3, 4); (1, "a", 2., 3, 5); (1, "a", 2., 4, 4); (1, "a", 3., 3, 4); (1, "b", 2., 3, 4); (2, "a", 2., 3, 4)]
  ]
end)(struct
  open Testing

  let tests = [
    "make" >: (lazy (check_int_tuple5 ~expected:(1, 2, 3, 4, 5) (make 1 2 3 4 5)));
    "flip" >: (lazy (check_int_tuple5 ~expected:(1, 2, 3, 4, 5) (flip (5, 4, 3, 2, 1))));
    "get_0" >: (lazy (check_42 (get_0 (42, 0, 0, 0, 0))));
    "get_1" >: (lazy (check_42 (get_1 (0, 42, 0, 0, 0))));
    "get_2" >: (lazy (check_42 (get_2 (0, 0, 42, 0, 0))));
    "get_3" >: (lazy (check_42 (get_3 (0, 0, 0, 42, 0))));
    "get_4" >: (lazy (check_42 (get_4 (0, 0, 0, 0, 42))));
  ]
end)
*)
