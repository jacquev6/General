type t = float

include Concepts_.RealNumber_.S0 with type t := t

module Class: sig
  type t =
    | Normal
    | SubNormal
    | Zero
    | Infinite
    | Nan

  include Traits_.Equatable_.S0 with type t := t
  include Traits_.Representable_.S0 with type t := t

  val of_float: float -> t
end
