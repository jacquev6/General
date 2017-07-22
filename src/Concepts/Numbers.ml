module Integer = struct
  module type S0 = sig
    type t

    include Traits.Equatable.S0 with type t := t

    val zero: t
    val one: t

    val add: t -> t -> t
    val sub: t -> t -> t
  end
end
