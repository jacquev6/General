#include "../Generated/Atoms/Bool.ml"

module Self = struct
  type t = bool

  let of_string = OCSP.bool_of_string
  let try_of_string s =
    Exception.or_none (lazy (of_string s))
  let to_string = OCSP.string_of_bool

  let repr = OCSP.string_of_bool

  let xor x y =
    match (x, y) with
      | (true, false) | (false, true) -> true
      | (true, true) | (false, false) -> false

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O

    let not = OCSP.not
    external (&&): bool -> bool -> bool = "%sequand"
    external (||): bool -> bool -> bool = "%sequor"
    let xor = xor
  end

  include (Compare.Poly: module type of Compare.Poly with module O:= O)
  include (Equate.Poly: module type of Equate.Poly with module O:= O)

  let not = OCSP.not
  let and_ = OCSP.(&&)
  let or_ = OCSP.(||)
end

include Self

(*
module Tests = Tests_.Make(Foundations.Bool)(struct
  let representations = [
    (false, "false");
    (true, "true");
  ]

  let displays = representations

  let literals = [
    ("false", false);
    ("true", true);
  ]

  let equalities = [
    [true];
    [false];
  ]

  let differences = [
    (true, false);
  ]

  let orders = [
    [false; true];
  ]
end)(struct
  open Testing

  let tests = [
    "not true" >: (lazy (check_false (not true)));
    "not false" >: (lazy (check_true (not false)));

    "and_ true true" >: (lazy (check_true (and_ true true)));
    "and_ false true" >: (lazy (check_false (and_ false true)));
    "and_ true false" >: (lazy (check_false (and_ true false)));
    "and_ false false" >: (lazy (check_false (and_ false false))); (* @todo Test that "and_" is not lazy *)
    "true && true" >: (lazy (check_true (true && true)));
    "true && false" >: (lazy (check_false (true && false)));
    "false && whatever" >:(lazy (check_false (false && (Exception.failure "Don't call me")))); (*BISECT-IGNORE*)

    "or_ true true" >: (lazy (check_true (or_ true true)));
    "or_ false true" >: (lazy (check_true (or_ false true)));
    "or_ true false" >: (lazy (check_true (or_ true false))); (* @todo Test that "or_" is not lazy *)
    "or_ false false" >: (lazy (check_false (or_ false false)));
    "true || whatever" >:(lazy (check_true (true || (Exception.failure "Don't call me")))); (*BISECT-IGNORE*)
    "false || true" >: (lazy (check_true (false || true)));
    "false || false" >: (lazy (check_false (false || false)));

    "xor true true" >: (lazy (check_false (xor true true)));
    "xor false true" >: (lazy (check_true (xor false true)));
    "xor true false" >: (lazy (check_true (xor true false)));
    "xor false false" >: (lazy (check_false (xor false false)));
  ]
end)
*)
