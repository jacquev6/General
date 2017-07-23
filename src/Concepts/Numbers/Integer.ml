module Basic = struct
  module type S0 = sig
    type t

    include Traits.Representable.S0 with type t := t
    include Traits.Equatable.Basic.S0 with type t := t
    include Traits.Comparable.Basic.S0 with type t := t

    val zero: t
    val one: t
    val of_int: int -> t
    val to_int: t -> int

    val add: t -> t -> t
    val sub: t -> t -> t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    include Traits.Equatable.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t

    val (+): t -> t -> t
    val (-): t -> t -> t
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    module O: Operators.S0 with type t := t

    include Traits.Equatable.Extensions.S0 with type t := t and module O := O
    include Traits.Comparable.Extensions.S0 with type t := t and module O := O
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    module Equatable = Traits.Equatable.Extensions.Make0(B)
    module Comparable = Traits.Comparable.Extensions.Make0(B)

    type t = B.t

    module O = struct
      include Equatable.O
      include Comparable.O

      open B

      let (+) x y =
        add x y

      let (-) x y =
        sub x y
    end

    include (Equatable: Traits.Equatable.Extensions.S0 with type t := t and module O := O)
    include (Comparable: Traits.Comparable.Extensions.S0 with type t := t and module O := O)
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end

module Testable = struct
  module type S0 = sig
    include S0

    include Traits.Representable.Testable.S0 with type t := t
    include Traits.Equatable.Testable.S0 with type t := t and module O := O
    include Traits.Comparable.Testable.S0 with type t := t and module O := O

    val addition_examples: (t * t * t) list
  end
end

module Tests = struct
  module Make0(T: Testable.S0) = struct
    module T = struct
      include T

      let representation_examples = representation_examples @ [
        (zero, "0");
        (one, "1");
        (of_int 0, "0");
        (of_int 1, "1");
      ]

      let equal_lists = equal_lists @ [
        [zero; of_int 0];
        [one; of_int 1];
      ]

      let different_pairs = different_pairs @ [
        (zero, one);
      ]

      let ordered_lists = ordered_lists @ [
        [zero; one];
      ]

      let addition_examples = addition_examples @ [
        (zero, zero, zero);
        (one, zero, one);
      ]
    end

    open T
    open T.O
    open Testing
    open StdLabels

    let test = "Integer" >:: [
      (let module M = Traits.Representable.Tests.Make0(T) in M.test);
      (let module M = Traits.Equatable.Tests.Make0(T) in M.test);
      (let module M = Traits.Comparable.Tests.Make0(T) in M.test);
    ] @ (
      addition_examples
      |> List.map ~f:(fun (x, y, z) ->
        let rx = repr x and ry = repr y and rz = repr z in
        [
          (* x + y = y + x = z *)
          ~: "add %s %s" rx ry (lazy (check ~repr ~equal ~expected:z (add x y)));
          ~: "add %s %s" ry rx (lazy (check ~repr ~equal ~expected:z (add y x)));
          ~: "%s + %s" rx ry (lazy (check ~repr ~equal ~expected:z (x + y)));
          ~: "%s + %s" ry rx (lazy (check ~repr ~equal ~expected:z (y + x)));
          (* z - y = x *)
          ~: "sub %s %s" rz ry (lazy (check ~repr ~equal ~expected:x (sub z y)));
          ~: "%s - %s" rz ry (lazy (check ~repr ~equal ~expected:x (z - y)));
          (* z - x = y *)
          ~: "sub %s %s" rz rx (lazy (check ~repr ~equal ~expected:y (sub z x)));
          ~: "%s - %s" rz rx (lazy (check ~repr ~equal ~expected:y (z - x)));
        ]
      )
      |> List.concat
    )
  end
end
