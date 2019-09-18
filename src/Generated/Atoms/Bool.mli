type t = bool
module O: sig
  include Concepts.Able.Operators.S0 with type t := t
  val not: t -> t
  val (&&): t -> t -> t
  val (||): t -> t -> t
  val xor: t -> t -> t
end

include Concepts.Able.S0 with type t := t and module O := O
include Concepts.Stringable.S0 with type t := t
val not: t -> t
val and_: t -> t -> t
val or_: t -> t -> t
val xor: t -> t -> t
