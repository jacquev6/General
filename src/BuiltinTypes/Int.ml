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

  let equality_classes = [
    [zero; 0];
    [one; 1];
    [2];
  ]
end

let test = "Int" >::: [
  (let module T = Traits.Equatable.Tests.Make0(Testable) in T.test);
]
