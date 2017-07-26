module Operators = struct
  module type S0 = sig
    include Traits_.Equatable_.Operators.S0
    include Traits_.Ringoid_.Operators.S0 with type t := t
  end
end

module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Traits_.Representable_.S0 with type t := t
  include Traits_.Displayable_.S0 with type t := t
  include Traits_.Equatable_.S0 with type t := t and module O := O
  include Traits_.Ringoid_.S0 with type t := t and module O := O

  val of_int: int -> t
  val of_float: float -> t
  val of_string: string -> t
end
