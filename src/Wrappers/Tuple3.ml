#include "../Generated/Wrappers/Tuple3.ml"

module SelfA = Foundations.Tuple3

module SelfB = struct
  include SelfA
  include Traits.Comparable.GreaterLessThan.Make3(SelfA)
  include Traits.Comparable.MinMax.Make3(SelfA)
  include Traits.Equatable.Different.Make3(SelfA)
end

module Self = struct
  include SelfB
  include Traits.Comparable.Between.Make3(SelfB)
end

include Self

module Tests = Tests_.Make(Self)(struct
  module A = Foundations.Int
  module B = Foundations.String
  module C = Foundations.Float

  let representations = [
    ((1, "a", 2.), "(1, \"a\", 2.)");
  ]

  let equalities = [
    [(1, "a", 2.)];
  ]

  let differences = [
    ((1, "a", 2.), (1, "a", 3.));
    ((1, "a", 2.), (1, "b", 2.));
    ((1, "a", 2.), (2, "a", 2.));
  ]

  let orders = [
    [(0, "a", 0.); (0, "a", 1.); (0, "b", 0.); (1, "a", 0.)]
  ]
end)(struct
  open Testing

  let tests = [
    "make" >: (lazy (check_int_tuple3 ~expected:(1, 2, 3) (make 1 2 3)));
    "flip" >: (lazy (check_int_tuple3 ~expected:(1, 2, 3) (flip (3, 2, 1))));
    "get_0" >: (lazy (check_42 (get_0 (42, 0, 0))));
    "get_1" >: (lazy (check_42 (get_1 (0, 42, 0))));
    "get_2" >: (lazy (check_42 (get_2 (0, 0, 42))));
  ]
end)
