#include "../Generated/Wrappers/Tuple2.ml"

module Basic = struct
  type ('a, 'b) t = 'a * 'b

  let make x y =
    (x, y)

  let get_0 (x, _) =
    x

  let get_1 (_, y) =
    y

  let flip (x, y) =
    (y, x)

  let compare (x, y) (x', y') ~compare_a ~compare_b =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> compare_b y y'
    )

  let equal (x, y) (x', y') ~equal_a ~equal_b =
    Bool.O.(equal_a x x' && equal_b y y')

  let repr (x, y) ~repr_a ~repr_b =
    Format.apply "(%s, %s)" (repr_a x) (repr_b y)
end

module Extended(Facets: Facets) = struct
  module SelfA = Basic

  module SelfB = struct
    include SelfA
    include Facets.Comparable.GreaterLessThan.Make2(SelfA)
    include Facets.Comparable.MinMax.Make2(SelfA)
    include Facets.Equatable.Different.Make2(SelfA)
  end

  module Self = struct
    include SelfB
    include Facets.Comparable.Between.Make2(SelfB)
  end

  include Self
end

(*
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
*)
