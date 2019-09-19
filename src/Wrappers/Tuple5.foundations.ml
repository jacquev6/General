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
