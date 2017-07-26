module Basic = struct
  module type S0 = sig
    type t

    (** Representation: a string representing the object for a software developer audience.
    When possible, it should a valid OCaml expression representing the value. **)
    val repr: t -> string
  end

  module type S1 = sig
    type 'a t

    val repr: 'a t -> repr:('a -> string) -> string
  end
end

include Basic
