#include "../Generated/Atoms/Int.ml"

module SelfA = struct
  include Foundations.Int

  include Facets.Ringoid.Exponentiate.Make0(struct
    include Foundations.Int

    let exponentiate_negative_exponent ~exponentiate:_ _ n =
      Exception.invalid_argument "Int.exponentiate: Negative exponent: %i" n
  end)
end

module SelfB = struct
  module O = struct
    include SelfA.O

    let ( ** ) = SelfA.exponentiate
  end

  include (SelfA: module type of SelfA[@remove_aliases] with module O := O)
end

include SelfB

module Tests = Tests_.Make(SelfB)(struct
  let representations = [
    (-3, "-3");
    (-0, "0");
    (0, "0");
    (1, "1");
    (15, "15");
  ]

  let displays = representations

  let literals = [
    ("0", 0);
    ("1", 1);
    ("-1", -1);
    ("1_000", 1000);
  ]

  let equalities = [
    [0];
    [1];
    [2];
  ]

  let differences = [
    (0, 1);
    (1, -1);
  ]

  let orders = [
    [-10; -5; -1; 0; 1; 2; 5];
  ]

  let additions = [
    (4, 3, 7);
    (4, -2, 2);
    (5, -7, -2);
  ]

  let negations = [
    (4, -4);
    (-7, 7);
  ]

  let multiplications = [
    (4, 3, 12);
    (4, -3, -12);
    (-4, -3, 12);
  ]

  let divisions = [
    (5, 2, 2);
    (4, 2, 2);
    (4, 3, 1);
    (4, 4, 1);
    (4, 5, 0);
  ]

  let exponentiations = [
    (3, 3, 27);
    (2, 7, 128);
  ]

  let successions = [
    (1, 2);
    (42, 43);
    (-121, -120);
  ]
end)(struct
  open Testing

  let tests = [
    "exponentiate 2 (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int.exponentiate: Negative exponent: -4") (lazy (exponentiate 2 (-4)))));
  ]
end)
