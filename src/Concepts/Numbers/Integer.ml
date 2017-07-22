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

      let (+) = add
      let (-) = sub
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
  end
end

module Tests = struct
  module Make0(T: Testable.S0) = struct
    module Testable = struct
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
    end

    open Testing

    let test = "Integer" >::: [
      (let module M = Traits.Representable.Tests.Make0(Testable) in M.test);
      (let module M = Traits.Equatable.Tests.Make0(Testable) in M.test);
      (let module M = Traits.Comparable.Tests.Make0(Testable) in M.test);
    ]
  end
end
