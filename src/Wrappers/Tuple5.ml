#include "../Generated/Wrappers/Tuple5.ml"

module Basic = struct
  type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e

  let make x y z u v =
    (x, y, z, u, v)

  let get_0 (x, _, _, _, _) =
    x

  let get_1 (_, y, _, _, _) =
    y

  let get_2 (_, _, z, _, _) =
    z

  let get_3 (_, _, _, u, _) =
    u

  let get_4 (_, _, _, _, v) =
    v

  let flip (x, y, z, u, v) =
    (v, u, z, y, x)

  let compare (x, y, z, u, v) (x', y', z', u', v') ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> (match compare_b y y' with
        | LT -> LT
        | GT -> GT
        | EQ -> (match compare_c z z' with
          | LT -> LT
          | GT -> GT
          | EQ -> (match compare_d u u' with
            | LT -> LT
            | GT -> GT
            | EQ -> compare_e v v'
          )
        )
      )
    )

  let equal (x, y, z, u, v) (x', y', z', u', v') ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e =
    Bool.O.(equal_a x x' && equal_b y y' && equal_c z z' && equal_d u u' && equal_e v v')

  let repr (x, y, z, u, v) ~repr_a ~repr_b ~repr_c ~repr_d ~repr_e =
    Format.apply "(%s, %s, %s, %s, %s)" (repr_a x) (repr_b y) (repr_c z) (repr_d u) (repr_e v)
end

module Extended(Facets: Facets) = struct
  module SelfA = Basic

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
end

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
