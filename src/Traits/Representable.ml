module type S0 = sig
  type t

  (** Representation: a string representing the object for a software developer audience.
  When possible, it should a valid OCaml expression representing the value. **)
  val repr: t -> string
end

module Examples = struct
  module type S0 = sig
    type t

    val repr: (t * string) list
  end
end
