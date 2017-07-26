module Basic = struct
  module type S0 = sig
    type t

    val to_string: t -> string
  end
end

include Basic
