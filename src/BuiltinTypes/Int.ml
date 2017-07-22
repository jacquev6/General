module Self = struct
  module Basic = struct
    type t = int

    let equal = (=)

    let compare = Compare.Poly.compare

    let zero = 0
    let one = 1
    let of_int a = a
    let to_int a = a
    let repr = string_of_int

    let add = (+)
    let sub = (-)
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
    [0; zero; of_int 0; -0];
    [1; one; of_int 1];
    [2];
  ]

  let ordered_lists = [
    [-10; -5; -1; 0; 1; 2; 5];
  ]
end

let test = "Int" >::: [
  (let module T = Traits.Representable.Tests.Make0(Testable) in T.test);
  (let module T = Traits.Equatable.Tests.Make0(Testable) in T.test);
  (let module T = Traits.Comparable.Tests.Make0(Testable) in T.test);
  "to_int 2" >:: (fun () -> check_int ~expected:2 (to_int 2));
]
