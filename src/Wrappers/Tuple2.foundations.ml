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
