module Basic = struct
  module type S0 = sig
    include Traits_.Representable_.Basic.S0
    include Traits_.Displayable_.Basic.S0 with type t := t
    include Traits_.Equatable_.Basic.S0 with type t := t
    include Traits_.Ringoid_.Basic.S0 with type t := t

    val of_int: int -> t
    val of_float: float -> t
    val of_string: string -> t
  end
end

module Operators = struct
  module type S0 = sig
    include Traits_.Equatable_.Operators.S0
    include Traits_.Ringoid_.Operators.S0 with type t := t
  end
end

module type S0 = sig
  include Basic.S0

  module O: Operators.S0 with type t := t

  include Traits_.Representable_.S0 with type t := t
  include Traits_.Displayable_.S0 with type t := t
  include Traits_.Equatable_.S0 with type t := t and module O := O
  include Traits_.Ringoid_.S0 with type t := t and module O := O
end

module Makeable = struct
  module type S0 = sig
    include Basic.S0

    include Traits_.Ringoid_.Makeable.S0 with type t := t
  end
end

module Make0(B: Makeable.S0) = struct
  include B

  module Equatable' = Traits_.Equatable_.Make0(B)
  module Ringoid' = Traits_.Ringoid_.Make0(B)

  module O = struct
    include Equatable'.O
    include Ringoid'.O
  end

  include (Equatable': Traits_.Equatable_.S0 with type t := t and module O := O)
  include (Ringoid': Traits_.Ringoid_.S0 with type t := t and module O := O)
end
