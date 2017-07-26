module Basic = struct
  module type S0 = sig
    include Number_.Basic.S0
    include Traits_.Comparable_.Basic.S0 with type t := t

    val abs: t -> t
    (* @todo val modulo: t -> t -> t *)

    val to_int: t -> int
    val to_float: t -> float
  end
end

module Operators = struct
  module type S0 = sig
    include Number_.Operators.S0
    include Traits_.Comparable_.Operators.S0 with type t := t
  end
end

module type S0 = sig
  include Basic.S0

  module O: Operators.S0 with type t := t

  include Number_.S0 with type t := t and module O := O
  include Traits_.Comparable_.S0 with type t := t and module O := O
end

module Make0(B: Basic.S0) = struct
  include B

  module Number' = Number_.Make0(B)
  module Comparable' = Traits_.Comparable_.Make0(B)

  module O = struct
    include Number'.O
    include Comparable'.O
  end

  include (Number': Number_.S0 with type t := t and module O := O)
  include (Comparable': Traits_.Comparable_.S0 with type t := t and module O := O)
end
