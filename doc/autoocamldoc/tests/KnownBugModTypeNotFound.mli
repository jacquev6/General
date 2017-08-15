module type C = sig
  type t
end

module type A = sig
  module type B = sig
    module type D = sig
      type t
    end

    module type AliasC = C

    module type AliasD = D
  end
end

include A
