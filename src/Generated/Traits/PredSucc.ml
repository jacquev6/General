module type S0 = sig
  type t
  val pred: t -> t
  val succ: t -> t
end
module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      val succ: (t * t) list
    end
  end
end
