type t = char
include Concepts.Able.S0 with type t := t
include Traits.Displayable.S0 with type t := t
include Traits.OfInt.S0 with type t := t
include Traits.ToInt.S0 with type t := t
val repeat: t -> len:(int) -> string
