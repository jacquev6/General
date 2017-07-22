module Basic = struct
  module type S0 = sig
    type t

    val equal: t -> t -> bool
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (=): t -> t -> bool
    val (<>): t -> t -> bool
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    val different: t -> t -> bool

    module O: Operators.S0 with type t := t
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    open B

    let different a b =
      not (equal a b)

    module O = struct
      let (=) = equal
      let (<>) = different
    end
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end
