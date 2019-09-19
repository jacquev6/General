#include "../Generated/Wrappers/Tuple2.ml"

module SelfA = Foundations.Tuple2

module SelfB = struct
  include SelfA
  include Traits.Comparable.GreaterLessThan.Make2(SelfA)
  include Traits.Comparable.MinMax.Make2(SelfA)
  include Traits.Equatable.Different.Make2(SelfA)
end

module Self = struct
  include SelfB
  include Traits.Comparable.Between.Make2(SelfB)
end

include Self

module Tests = Tests_.Make(Self)(struct
  module A = Foundations.Int
  module B = Foundations.String

  let representations = [
    ((1, "a"), "(1, \"a\")");
  ]

  let equalities = [
    [(1, "a")];
  ]

  let differences = [
    ((1, "a"), (1, "b"));
    ((1, "a"), (2, "a"));
  ]

  let orders = [
    [(0, "a"); (0, "b"); (1, "a")]
  ]
end)(struct
  open Testing

  let tests = [
    "make" >: (lazy (check_int_tuple2 ~expected:(1, 2) (make 1 2)));
    "flip" >: (lazy (check_int_tuple2 ~expected:(1, 2) (flip (2, 1))));
    "get_0" >: (lazy (check_42 (get_0 (42, 0))));
    "get_1" >: (lazy (check_42 (get_1 (0, 42))));
  ]
end)
