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
end
