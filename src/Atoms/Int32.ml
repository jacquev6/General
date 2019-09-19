#include "../Generated/Atoms/Int32.ml"

module OCSI = OCamlStandard.Int32

module Self = StandardInt.Make(struct
  include OCSI

  let name = "Int32"
  let repr_suffix = "l"
  let size = 32

#if OCAML_VERSION < (4, 3, 0)
  let equal = Equate.Poly.equal
#endif
end)

include Self

module Tests = Tests_.Make(Self)(struct
  let literals = [
    ("43", 43l);
    ("-12", -12l);
  ]

  let representations = [
    (-3l, "-3l");
    (-0l, "0l");
    (0l, "0l");
    (1l, "1l");
    (15l, "15l");
  ]

  let displays = [
    (-3l, "-3");
    (-0l, "0");
    (0l, "0");
    (1l, "1");
    (15l, "15");
  ]

  let equalities = [
    [0l];
    [1l];
    [2l];
  ]

  let differences = [
    (0l, 1l);
    (1l, -1l);
  ]

  let orders = [
    [-10l; -5l; -1l; 0l; 1l; 2l; 5l];
  ]

  let additions = [
    (4l, 3l, 7l);
    (4l, -2l, 2l);
    (5l, -7l, -2l);
  ]

  let negations = [
    (4l, -4l);
    (-7l, 7l);
  ]

  let multiplications = [
    (4l, 3l, 12l);
    (4l, -3l, -12l);
    (-4l, -3l, 12l);
  ]

  let divisions = [
    (5l, 2l, 2l);
    (4l, 2l, 2l);
    (4l, 3l, 1l);
    (4l, 4l, 1l);
    (4l, 5l, 0l);
  ]

  let exponentiations = [
    (3l, 3, 27l);
    (2l, 7, 128l);
  ]

  let successions = [
    (1l, 2l);
    (42l, 43l);
    (-121l, -120l);
  ]
end)(struct
  open Testing

  let tests = [
    "exponentiate 2l (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int32.exponentiate: Negative exponent: -4") (lazy (exponentiate 2l (-4)))));
  ]
end)
