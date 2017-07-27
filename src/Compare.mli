type t = LT | EQ | GT

val of_standard: ('a -> 'a -> int) -> ('a -> 'a -> t)

module Poly: sig
  module O: sig
    include Traits.Comparable.Operators.SP
  end

  include Traits.Comparable.SP with module O := O
end
