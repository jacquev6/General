module type S0 = sig
  include RealNumber.S0

  val succ: t -> t
  val pred: t -> t
end

module PredSucc = struct
  module Make0(M: sig
    type t

    val one: t

    val add: t -> t -> t
    val substract: t -> t -> t
  end) = struct
    open M

    let pred x =
      substract x one

    let succ x =
      add x one
  end
end

module Tests = struct
  open Testing

  module Make0(M: S0)(E: RealNumber.Tests.Examples.S0 with type t := M.t) = struct
    open M

    let test = "Integer" >:: [
      (let module T = RealNumber.Tests.Make0(M)(E) in T.test);
      "succ zero" >: (lazy (check ~repr ~equal ~expected:one (succ zero)));
      "pred one" >: (lazy (check ~repr ~equal ~expected:zero (pred one)));
    ]
  end
end
