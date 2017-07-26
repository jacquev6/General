module Basic = struct
  module type S0 = sig
    type t

    val equal: t -> t -> bool
  end

  module type S1 = sig
    type 'a t

    val equal: 'a t -> 'a t -> equal:('a -> 'a -> bool) -> bool
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

module type S1 = sig
  include Basic.S1

  val different: 'a t -> 'a t -> equal:('a -> 'a -> bool) -> bool
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

module Make1(B: Basic.S1) = struct
  include B

  let different x y ~equal:eq =
    OCamlStandard.Pervasives.not (equal x y ~equal:eq)
end
