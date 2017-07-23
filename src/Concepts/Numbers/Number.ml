module Basic = struct
  module type S0 = sig
    type t

    include Traits.Representable.S0 with type t := t
    include Traits.Equatable.Basic.S0 with type t := t
    include Traits.Ringoid.Basic.S0 with type t := t

    val of_int: int -> t
    val of_float: float -> t
    val of_string: string -> t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    include Traits.Equatable.Operators.S0 with type t := t
    include Traits.Ringoid.Operators.S0 with type t := t
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    module O: Operators.S0 with type t := t

    include Traits.Equatable.Extensions.S0 with type t := t and module O := O
    include Traits.Ringoid.Extensions.S0 with type t := t and module O := O
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    module Equatable_ = Traits.Equatable.Extensions.Make0(B)
    module Ringoid_ = Traits.Ringoid.Extensions.Make0(B)

    type t = B.t

    module O = struct
      include Equatable_.O
      include Ringoid_.O
    end

    include (Equatable_: Traits.Equatable.Extensions.S0 with type t := t and module O := O)
    include (Ringoid_: Traits.Ringoid.Extensions.S0 with type t := t and module O := O)
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
    include Traits.Ringoid.Testable.S0 with type t := t and module O := O
  end
end

module Tests = struct
  module Make0(T: Testable.S0) = struct
    open Testing

    module T = struct
      include T

      let equal_lists = equal_lists @ [
        [zero; of_int 0; of_float 0.; of_string "0"];
        [one; of_int 1; of_float 1.; of_string "1"];
      ]

      let different_pairs = different_pairs @ [
        (zero, one);
      ]
    end

    let test = "Number" >:: [
      (let module M = Traits.Representable.Tests.Make0(T) in M.test);
      (let module M = Traits.Equatable.Tests.Make0(T) in M.test);
      (let module M = Traits.Ringoid.Tests.Make0(T) in M.test);
    ]
  end
end
