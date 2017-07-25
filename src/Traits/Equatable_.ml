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

module type S0 = sig
  include Basic.S0

  val different: t -> t -> bool

  module O: Operators.S0 with type t := t
end

module Make0(B: Basic.S0) = struct
  include B

  let different x y =
    OCamlStandard.Pervasives.not (equal x y)

  module O = struct
    let (=) x y =
      equal x y

    let (<>) x y =
      different x y
  end
end

module Examples = struct
  module type S0 = sig
    type t

    val equal: t list list
    val different: (t * t) list
  end
end
