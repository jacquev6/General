module Basic = struct
  type t = int

  let zero = 0
  let one = 1
  let smallest = OCSP.min_int
  let greatest = OCSP.max_int

  let width = OCSP.(OCamlStandard.Sys.word_size - 1)  (* @todo If we drop OCaml 4.02: use Sys.int_size. Until then, Int.width is wrong on Javascript *)

  let of_int = Function1.identity
  let to_int = Function1.identity
  let of_float = OCSP.int_of_float
  let to_float = OCSP.float_of_int

  let of_string s =
    try
      OCSP.int_of_string s
    with Failure "int_of_string" -> Exception.invalid_argument "Int.of_string"

  let try_of_string s =
    Exception.or_none (lazy (OCSP.int_of_string s))

  let to_string = OCSP.string_of_int

  let repr = OCSP.string_of_int

  let add = OCSP.(+)
  let subtract = OCSP.(-)
  let negate = OCSP.(~-)
  let multiply = OCSP.( * )
  let divide = OCSP.(/)
  let square x = multiply x x
  let abs = OCSP.abs
  let modulo = OCSP.(mod)
  let pred = OCSP.pred
  let succ = OCSP.succ

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O

    let (~-) = OCSP.(~-)
    let (~+) = OCSP.(~+)
    let (+) = OCSP.(+)
    let (-) = OCSP.(-)
    let ( * ) = OCSP.( * )
    let (/) = OCSP.(/)
    let (mod) = OCSP.(mod)
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)

  module Bitwise = struct
    let logical_and = OCSP.(land)
    let logical_or = OCSP.(lor)
    let logical_xor = OCSP.(lxor)
    let logical_not = OCSP.(lnot)
    let logical_shift_left n ~shift = OCSP.(n lsl shift)
    let logical_shift_right n ~shift = OCSP.(n lsr shift)
    let arithmetic_shift_right n ~shift = OCSP.(n asr shift)
  end
end

module Extended(Facets: Facets) = struct
  module Self_alpha = struct
    include Basic

    include Facets.Ringoid.Exponentiate.Make0(struct
      include Basic

      let exponentiate_negative_exponent ~exponentiate:_ _ n =
        Exception.invalid_argument "Int.exponentiate: Negative exponent: %i" n
    end)
  end

  module Self_beta = struct
    module O = struct
      include Self_alpha.O

      let ( ** ) = Self_alpha.exponentiate
    end

    include (Self_alpha: module type of Self_alpha[@remove_aliases] with module O := O)
  end

  include Self_beta

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/Int.ml"

    include Tests_.Make(Self_beta)(struct
      let module_name = "Int"

      let values = [1; 2; 3]

      let conversions_to_string = [
        (-3, "-3");
        (-0, "0");
        (0, "0");
        (1, "1");
        (15, "15");
      ]

      let representations = conversions_to_string

      let conversions_from_string = [
        ("0", 0);
        ("1", 1);
        ("-1", -1);
        ("1_000", 1000);
        ("0x10", 16);
        ("0o10", 8);
        ("0b10", 2);
      ]

      let unconvertible_strings = ["a"]

      let equalities = []

      let differences = [
        (0, 1);
        (1, -1);
      ]

      let strict_orders = [
        [-10; -5; -1; 0; 1; 2; 5];
      ]

      let order_classes = []

      let additions = [
        (4, 3, 7);
        (4, -2, 2);
        (5, -7, -2);
      ]

      let negations = [
        (4, -4);
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

      let conversions_to_int = [
        (12, 12)
      ]

      let conversions_from_int = [
        (12, 12)
      ]

      let conversions_to_float = [
        (12, 12.)
      ]

      let conversions_from_float = [
        (12., 12);
        (12.99, 12);
        (-12.99, -12);
      ]
    end)(struct
      open Testing

      let tests = [
        "Int: exponentiate 2 (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int.exponentiate: Negative exponent: -4") (lazy (exponentiate 2 (-4)))));
      ]
    end)
  end
end
