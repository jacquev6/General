#include "../Generated/Wrappers/Tuple4.ml"

module Basic = struct
  type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd

  let make x y z u =
    (x, y, z, u)

  let get_0 (x, _, _, _) =
    x

  let get_1 (_, y, _, _) =
    y

  let get_2 (_, _, z, _) =
    z

  let get_3 (_, _, _, u) =
    u

  let flip (x, y, z, u) =
    (u, z, y, x)

  let compare (x, y, z, u) (x', y', z', u') ~compare_a ~compare_b ~compare_c ~compare_d =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> (match compare_b y y' with
        | LT -> LT
        | GT -> GT
        | EQ -> (match compare_c z z' with
          | LT -> LT
          | GT -> GT
          | EQ -> compare_d u u'
        )
      )
    )

  let equal (x, y, z, u) (x', y', z', u') ~equal_a ~equal_b ~equal_c ~equal_d =
    Bool.O.(equal_a x x' && equal_b y y' && equal_c z z' && equal_d u u')

  let repr (x, y, z, u) ~repr_a ~repr_b ~repr_c ~repr_d =
    Format.apply "(%s, %s, %s, %s)" (repr_a x) (repr_b y) (repr_c z) (repr_d u)
end

module Extended(Facets: Facets) = struct
  module SelfA = Basic

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
end

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
