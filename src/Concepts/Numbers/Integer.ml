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

module Tests = struct
  module Make0(M: S0)(E: RealNumber.Examples.S0 with type t := M.t) = struct
    open Testing

    open M

    let test = "Integer" >:: [
      (let module T = RealNumber.Tests.Make0(M)(E) in T.test);
      "succ zero" >: (lazy (check ~repr ~equal ~expected:one (succ zero)));
      "pred one" >: (lazy (check ~repr ~equal ~expected:zero (pred one)));
    ]
  end
end
