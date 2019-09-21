#include "../Generated/Atoms/NativeInt.ml"

module OCSI = OCamlStandard.Nativeint

module Self = StandardInt.Make(struct
  include OCSI

  let name = "NativeInt"
  let repr_suffix = "n"

#if OCAML_VERSION < (4, 3, 0)
  let equal = Equate.Poly.equal
#endif
end)

include Self

(*
module Tests = Tests_.Make(Self)(struct
  let literals = [
    ("43", 43n);
    ("-12", -12n);
  ]

  let representations = [
    (-3n, "-3n");
    (-0n, "0n");
    (0n, "0n");
    (1n, "1n");
    (15n, "15n");
  ]

  let displays = [
    (-3n, "-3");
    (-0n, "0");
    (0n, "0");
    (1n, "1");
    (15n, "15");
  ]

  let equalities = [
    [0n];
    [1n];
    [2n];
  ]

  let differences = [
    (0n, 1n);
    (1n, -1n);
  ]

  let orders = [
    [-10n; -5n; -1n; 0n; 1n; 2n; 5n];
  ]

  let additions = [
    (4n, 3n, 7n);
    (4n, -2n, 2n);
    (5n, -7n, -2n);
  ]

  let negations = [
    (4n, -4n);
    (-7n, 7n);
  ]

  let multiplications = [
    (4n, 3n, 12n);
    (4n, -3n, -12n);
    (-4n, -3n, 12n);
  ]

  let divisions = [
    (5n, 2n, 2n);
    (4n, 2n, 2n);
    (4n, 3n, 1n);
    (4n, 4n, 1n);
    (4n, 5n, 0n);
  ]

  let exponentiations = [
    (3n, 3, 27n);
    (2n, 7, 128n);
  ]

  let successions = [
    (1n, 2n);
    (42n, 43n);
    (-121n, -120n);
  ]
end)(struct
  open Testing

  let tests = [
    "exponentiate 2n (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "NativeInt.exponentiate: Negative exponent: -4") (lazy (exponentiate 2n (-4)))));
  ]
end)
*)
