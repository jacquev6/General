module Basic = struct
  module type S0 = sig
    include Number.Basic.S0
    include Traits.Comparable.Basic.S0 with type t := t

    val abs: t -> t
    (* @todo val modulo: t -> t -> t *)

    val to_int: t -> int
    val to_float: t -> float
  end
end

module Operators = struct
  module type S0 = sig
    include Number.Operators.S0
    include Traits.Comparable.Operators.S0 with type t := t
  end
end

module type S0 = sig
  include Basic.S0

  module O: Operators.S0 with type t := t

  include Number.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O
end

module Make0(B: Basic.S0) = struct
  include B

  module Number_ = Number.Make0(B)
  module Comparable_ = Traits.Comparable.Make0(B)

  module O = struct
    include Number_.O
    include Comparable_.O
  end

  include (Number_: Number.S0 with type t := t and module O := O)
  include (Comparable_: Traits.Comparable.S0 with type t := t and module O := O)
end

module Examples = struct
  module type S0 = sig
    include Number.Examples.S0
    include Traits.Comparable.Examples.S0 with type t := t
  end
end
