module Self = struct
  module Basic = struct
    type t = int

    let equal x y =
      x = y

    let compare x y =
      Compare.Poly.compare x y

    let zero = 0

    let one = 1

    let of_int x =
      x

    let to_int x =
      x

    let of_float x =
      int_of_float x

    let to_float x =
      float_of_int x

    let of_string x =
      int_of_string x

    let repr x =
      string_of_int x

    let add x y =
      x + y

    let substract x y =
      x - y

    let negate x =
      -x

    let multiply x y =
      x * y

    let divide x y =
      x / y

    let abs x =
      abs x
  end

  include Concepts.Numbers.Integer.Extensions.Make0(Basic)
  include Basic
end

include Self

module Testable = struct
  include Self

  let representation_examples = [
    (-3, "-3");
    (-0, "0");
    (0, "0");
    (1, "1");
    (15, "15");
  ]

  let equal_lists = [
    [0];
    [1];
    [2];
  ]

  let different_pairs = [
    (0, 1);
    (1, -1);
  ]

  let ordered_lists = [
    [-10; -5; -1; 0; 1; 2; 5];
  ]

  let add_substract_examples = [
    (4, 3, 7);
    (4, -2, 2);
    (5, -7, -2);
  ]

  let negate_examples = [
    (4, -4);
    (-7, 7);
  ]

  let multiply_examples = [
    (4, 3, 12);
    (4, -3, -12);
    (-4, -3, 12);
  ]

  let divide_examples = [
    (5, 2, 2);
    (4, 2, 2);
    (4, 3, 1);
    (4, 4, 1);
    (4, 5, 0);
  ]
end

let test = Testing.("Int" >:: [
  (let module M = Concepts.Numbers.Integer.Tests.Make0(Testable) in M.test);
])
