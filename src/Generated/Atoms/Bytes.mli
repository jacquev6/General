type t = bytes
include Concepts.Able.S0 with type t := t
include Traits.Displayable.S0 with type t := t
val size: t -> int
val of_string: string -> t
val get: t -> int -> char
val set: t -> int -> char -> unit
val empty: t
val make: len:(int) -> t
