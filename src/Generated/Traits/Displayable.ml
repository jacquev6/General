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
  module Testable = struct
    module type S0 = sig
      include S0
    end
  end
end
