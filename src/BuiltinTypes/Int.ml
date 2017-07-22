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

    let repr x =
      string_of_int x

    let add x y =
      x + y

    let sub x y =
      x - y
  end

  include Basic
  include Concepts.Numbers.Integer.Extensions.Make0(Basic)
end

include Self

open Testing

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
end

let test = "Int" >::: [
  (let module M = Concepts.Numbers.Integer.Tests.Make0(Testable) in M.test);
  "to_int 2" >:: (fun () -> check_int ~expected:2 (to_int 2));
]
