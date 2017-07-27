module Poly: sig
  module O: sig
    include Traits.Equatable.Operators.SP
  end

  include Traits.Equatable.SP with module O := O
end

module Physical: sig
  val equal: 'a -> 'a -> bool
  val different: 'a -> 'a -> bool
end
