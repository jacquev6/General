module Basic = struct
  module type S0 = sig
    type t

    val equal: t -> t -> bool
  end
end

module type S0 = sig
  include Basic.S0

  val different: t -> t -> bool

  module O: sig
    val (=): t -> t -> bool
    val (<>): t -> t -> bool
  end
end

module Make0(B: Basic.S0) = struct
  open B

  let different a b =
    not (equal a b)

  module O = struct
    let (=) = equal
    let (<>) = different
  end
end
