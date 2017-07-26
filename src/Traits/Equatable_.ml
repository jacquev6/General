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

  module Make0(M: sig
    type t

    val equal: t -> t -> bool
    val different: t -> t -> bool
  end) = struct
    open M

    let (=) x y =
      equal x y

    let (<>) x y =
      different x y
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

module Different = struct
  module Make0(M: sig
    type t

    val equal: t -> t -> bool
  end) = struct
    open M

    let different x y =
      OCamlStandard.Pervasives.not (equal x y)
  end

  module type M1 = sig
    type 'a t

    val equal: 'a t -> 'a t -> equal:('a -> 'a -> bool) -> bool
  end

  module Make1(M: M1) = struct
    open M

    let different x y ~equal:eq =
      OCamlStandard.Pervasives.not (equal x y ~equal:eq)
  end
end
