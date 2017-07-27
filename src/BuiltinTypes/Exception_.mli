type t = exn

include Traits_.Equatable_.S0 with type t := t

exception Exit

val raise: t -> 'a

val raise_without_backtrace: t -> 'a

val invalid_argument: ('a, unit, string, 'b) format4 -> 'a

val failure: ('a, unit, string, 'b) format4 -> 'a
