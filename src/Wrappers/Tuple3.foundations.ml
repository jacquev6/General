type ('a, 'b, 'c) t = 'a * 'b * 'c

let make x y z =
  (x, y, z)

let get_0 (x, _, _) =
  x

let get_1 (_, y, _) =
  y

let get_2 (_, _, z) =
  z

let flip (x, y, z) =
  (z, y, x)

let compare (x, y, z) (x', y', z') ~compare_a ~compare_b ~compare_c =
  Compare.(match compare_a x x' with
    | LT -> LT
    | GT -> GT
    | EQ -> (match compare_b y y' with
      | LT -> LT
      | GT -> GT
      | EQ -> compare_c z z'
    )
  )

let equal (x, y, z) (x', y', z') ~equal_a ~equal_b ~equal_c =
  Bool.O.(equal_a x x' && equal_b y y' && equal_c z z')

let repr (x, y, z) ~repr_a ~repr_b ~repr_c =
  Format.apply "(%s, %s, %s)" (repr_a x) (repr_b y) (repr_c z)
