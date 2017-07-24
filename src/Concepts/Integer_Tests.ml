(* @todo This `sig include ... end` is error-prone: we need to do it everywhere.
Find a way to ensure we actually do it everywhere or, even better, a way to avoid the need for this trick.
*)
module Make0(M: sig include Concepts.Integer.S0 end)(E: Concepts.RealNumber.Examples.S0 with type t := M.t) = struct
  open Testing

  open M

  let test = "Integer" >:: [
    (let module T = RealNumber_Tests.Make0(M)(E) in T.test);
    "succ zero" >: (lazy (check ~repr ~equal ~expected:one (succ zero)));
    "pred one" >: (lazy (check ~repr ~equal ~expected:zero (pred one)));
  ]
end
