module type S0 = sig
  type t
  val to_int: t -> int
  val to_float: t -> float
end
