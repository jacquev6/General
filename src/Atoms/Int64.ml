#include "../Generated/Atoms/Int64.ml"

module OCSI = OCamlStandard.Int64

module Self = StandardInt.Make(struct
  include OCSI

  let name = "Int64"
  let repr_suffix = "L"
  let size = 64

#if OCAML_VERSION < (4, 3, 0)
  let equal = Equate.Poly.equal
#endif
end)

include Self

(*
module Tests = Tests_.Make(Self)(struct
  let literals = [
    ("43", 43L);
    ("-12", -12L);
  ]

  let representations = [
    (-3L, "-3L");
    (-0L, "0L");
    (0L, "0L");
    (1L, "1L");
    (15L, "15L");
  ]

  let displays = [
    (-3L, "-3");
    (-0L, "0");
    (0L, "0");
    (1L, "1");
    (15L, "15");
  ]

  let equalities = [
    [0L];
    [1L];
    [2L];
  ]

  let differences = [
    (0L, 1L);
    (1L, -1L);
  ]

  let orders = [
    [-10L; -5L; -1L; 0L; 1L; 2L; 5L];
  ]

  let additions = [
    (4L, 3L, 7L);
    (4L, -2L, 2L);
    (5L, -7L, -2L);
  ]

  let negations = [
    (4L, -4L);
    (-7L, 7L);
  ]

  let multiplications = [
    (4L, 3L, 12L);
    (4L, -3L, -12L);
    (-4L, -3L, 12L);
  ]

  let divisions = [
    (5L, 2L, 2L);
    (4L, 2L, 2L);
    (4L, 3L, 1L);
    (4L, 4L, 1L);
    (4L, 5L, 0L);
  ]

  let exponentiations = [
    (3L, 3, 27L);
    (2L, 7, 128L);
  ]

  let successions = [
    (1L, 2L);
    (42L, 43L);
    (-121L, -120L);
  ]
end)(struct
  open Testing

  let tests = [
    "exponentiate 2L (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int64.exponentiate: Negative exponent: -4") (lazy (exponentiate 2L (-4)))));
  ]
end)
*)
