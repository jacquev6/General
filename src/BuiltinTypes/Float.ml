module Basic = struct
  type t = float

  let equal x y =
    x = y

  let compare x y =
    Compare.Poly.compare x y

  let zero = 0.

  let one = 1.

  let of_int x =
    float_of_int x

  let to_int x =
    int_of_float x

  let of_float x =
    x

  let to_float x =
    x

  let of_string x =
    float_of_string x

  let repr x =
    string_of_float x

  let add x y =
    x +. y

  let substract x y =
    x -. y

  let negate x =
    -.x

  let multiply x y =
    x *. y

  let divide x y =
    x /. y

  let abs x =
    abs_float x
end

module Self = Concepts.Numbers.RealNumber.Make0(Basic)

module Examples = struct
  let repr = [
    (-3., "-3.");
    (-0., "-0.");
    (0., "0.");
    (1., "1.");
    (15., "15.");
  ]

  let equal = [
    [0.];
    [1.];
    [2.];
  ]

  let different = [
    (0., 1.);
    (1., -1.);
  ]

  let ordered = [
    [-10.; -5.; -1.; -0.2; 0.; 0.7; 1.; 2.; 5.];
  ]

  let add_substract = [
    (4., 3., 7.);
    (4., -2., 2.);
    (5., -7., -2.);
  ]

  let negate = [
    (4., -4.);
    (-7., 7.);
  ]

  let multiply = [
    (4., 3., 12.);
    (4., -3., -12.);
    (-4., -3., 12.);
  ]

  let divide = [
    (5., 2., 2.5);
    (4., 2., 2.);
    (1., 4., 0.25);
    (4., 4., 1.);
    (4., 5., 0.8);
  ]
end

let test = Testing.("Float" >:: [
  (let module T = Concepts.Numbers.RealNumber.Tests.Make0(Self)(Examples) in T.test);
])

include Self
