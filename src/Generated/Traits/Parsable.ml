module type S0 = sig
  type t
  val try_of_string: string -> t option
  val of_string: string -> t
end
module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      val of_string: (string * t) list
    end
  end
  module Testable = struct
    module type S0 = sig
      include S0
      include Equatable.Basic.S0 with type t := t
      include Representable.S0 with type t := t
    end
  end
end
