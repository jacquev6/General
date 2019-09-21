#include "../Generated/Atoms/Function1.ml"

module Self = Foundations.Function1

include Self

(*
module Tests = Tests_.Make(Self)(struct
end)(struct
  open Testing

  let tests = [
    "identity 42" >: (lazy (check_42 (identity 42)));
    "apply" >: (lazy (check_42 (apply (( * ) 2) 21)));
    "rev_apply" >: (lazy (check_42 (rev_apply 21 (( * ) 2))));
    "compose" >: (lazy (check_string ~expected:"42" ((compose (Format.apply "%d") (( * ) 2)) 21)));
  ]
end)
*)
