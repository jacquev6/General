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
