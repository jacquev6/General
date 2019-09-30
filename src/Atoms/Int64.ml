module Basic = StandardInt.MakeBasic(struct
  include OCamlStandard.Int64

  let name = "Int64"
  let repr_suffix = "L"
  let size = 64

#if OCAML_VERSION < (4, 3, 0)
  let equal = Equate.Poly.equal
#endif
end)

module Extended(Facets: Facets) = struct
  module Self = struct
    include Basic
    include StandardInt.MakeExtensions(Facets)(struct
      include Basic

      let name = "Int64"
    end)
  end

  include Self

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Int64.ml"

    include Tests_.Make(Self)(struct
      let module_name = "Int64"

      let values = [21L; -32L]

      let conversions_from_string = [
        ("43", 43L);
        ("-12", -12L);
        ("1_000", 1000L);
        ("0x10", 16L);
        ("0o10", 8L);
        ("0b10", 2L);
      ]

      let unconvertible_strings = ["a"]

      let representations = [
        (-3L, "-3L");
        (-0L, "0L");
        (0L, "0L");
        (1L, "1L");
        (15L, "15L");
      ]

      let conversions_to_string = [
        (-3L, "-3");
        (-0L, "0");
        (0L, "0");
        (1L, "1");
        (15L, "15");
      ]

      let equalities = []

      let differences = [
        (0L, 1L);
        (1L, -1L);
      ]

      let strict_orders = [
        [-10L; -5L; -1L; 0L; 1L; 2L; 5L];
      ]

      let order_classes = []

      let additions = [
        (4L, 3L, 7L);
        (4L, -2L, 2L);
        (5L, -7L, -2L);
      ]

      let negations = [
        (4L, -4L);
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

      let conversions_to_int = [
        (12L, 12)
      ]

      let conversions_from_int = [
        (12, 12L)
      ]

      let conversions_to_float = [
        (12L, 12.)
      ]

      let conversions_from_float = [
        (12., 12L);
        (12.99, 12L);
        (-12.99, -12L);
      ]
    end)(struct
      open Testing

      let tests = [
        "Int64: exponentiate 2L (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int64.exponentiate: Negative exponent: -4") (lazy (exponentiate 2L (-4)))));
      ]
    end)
  end
end
