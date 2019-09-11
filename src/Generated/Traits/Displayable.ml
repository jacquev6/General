module type S0 = sig
  type t
  val to_string: t -> string
end
module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      val to_string: (t * string) list
    end
  end
end
