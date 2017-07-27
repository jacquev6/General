type t = int

include Concepts_.Integer_.S0 with type t := t

(* @todo Traits_.Bounded_? *)
val greatest: t
val smallest: t
