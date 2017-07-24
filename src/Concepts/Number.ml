module Basic = struct
  module type S0 = sig
    include Traits.Representable.S0
    include Traits.Equatable.Basic.S0 with type t := t
    include Traits.Ringoid.Basic.S0 with type t := t

    val of_int: int -> t
    val of_float: float -> t
    val of_string: string -> t
  end
end

module Operators = struct
  module type S0 = sig
    include Traits.Equatable.Operators.S0
    include Traits.Ringoid.Operators.S0 with type t := t
  end
end

module type S0 = sig
  include Basic.S0

  module O: Operators.S0 with type t := t

  include Traits.Equatable.S0 with type t := t and module O := O
  include Traits.Ringoid.S0 with type t := t and module O := O
end

module Make0(B: Basic.S0) = struct
  include B

  module Equatable_ = Traits.Equatable.Make0(B)
  module Ringoid_ = Traits.Ringoid.Make0(B)

  module O = struct
    include Equatable_.O
    include Ringoid_.O
  end

  include (Equatable_: Traits.Equatable.S0 with type t := t and module O := O)
  include (Ringoid_: Traits.Ringoid.S0 with type t := t and module O := O)
end

module Examples = struct
  module type S0 = sig
    include Traits.Representable.Examples.S0
    include Traits.Equatable.Examples.S0 with type t := t
    include Traits.Ringoid.Examples.S0 with type t := t
  end
end
