module Basic = struct
  module type S0 = sig
    type t

    include Traits.Equatable.Basic.S0 with type t := t
    include Traits.Comparable.Basic.S0 with type t := t

    val zero: t
    val one: t

    val add: t -> t -> t
    val sub: t -> t -> t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    include Traits.Equatable.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t
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
    end

    include (Equatable: Traits.Equatable.Extensions.S0 with type t := t and module O := O)
    include (Comparable: Traits.Comparable.Extensions.S0 with type t := t and module O := O)
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end
