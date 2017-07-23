module Basic = struct
  module type S0 = RealNumber.Basic.S0
end

module Operators = struct
  module type S0 = RealNumber.Operators.S0
end

module Extensions = struct
  module type S0 = sig
    include RealNumber.Extensions.S0

    val succ: t -> t
    val pred: t -> t
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    open B

    include RealNumber.Extensions.Make0(B)

    let succ x =
      add x one

    let pred x =
      substract x one
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end

module Testable = struct
  module type S0 = sig
    include S0

    include RealNumber.Testable.S0 with type t := t and module O := O
  end
end

module Tests = struct
  module Make0(T: Testable.S0) = struct
    open Testing
    open T

    let test = "Integer" >:: [
      (let module M = RealNumber.Tests.Make0(T) in M.test);
      "succ zero" >: (lazy (check ~repr ~equal ~expected:one (succ zero)));
      "pred one" >: (lazy (check ~repr ~equal ~expected:zero (pred one)));
    ]
  end
end
