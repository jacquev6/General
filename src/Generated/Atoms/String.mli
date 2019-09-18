type t = string
module O: sig
  include Concepts.Able.Operators.S0 with type t := t
  val (^): t -> t -> t
end

include Concepts.Able.S0 with type t := t and module O := O
include Concepts.Stringable.S0 with type t := t
val of_char: char -> t
val of_list: char list -> t
val to_list: t -> char list
val size: t -> int
val get: t -> int -> char
val set: bytes -> int -> char -> unit
val of_bytes: bytes -> t
val to_bytes: t -> bytes
val concat: t -> t -> t
val substring: t -> pos:(int) -> len:(int) -> t
val prefix: t -> len:(int) -> t
val suffix: t -> len:(int) -> t
val has_prefix: t -> pre:(t) -> bool
val try_drop_prefix: t -> pre:(t) -> t option
val drop_prefix: t -> pre:(t) -> t
val drop_prefix': t -> len:(int) -> t
val has_suffix: t -> suf:(t) -> bool
val try_drop_suffix: t -> suf:(t) -> t option
val drop_suffix: t -> suf:(t) -> t
val drop_suffix': t -> len:(int) -> t
val split: t -> sep:(t) -> t list
val split': t -> seps:(char list) -> t list
val fold: init:('a) -> t -> f:('a -> char -> 'a) -> 'a
val filter: t -> f:(char -> bool) -> t
