module type S0 = sig
  type t
  val of_int: int -> t
  val of_float: float -> t
end
