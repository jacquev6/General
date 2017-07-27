type t = float

include Concepts_.RealNumber_.S0 with type t := t

val greatest: t
val smallest: t
val epsilon: t
val infinity: t
val negative_infinity: t
val not_a_number: t

module Class: sig
  type t =
    | Normal
    | SubNormal
    | Zero
    | Infinite
    | NotANumber

  include Traits_.Equatable_.S0 with type t := t
  include Traits_.Representable_.S0 with type t := t

  val of_float: float -> t
end
