module Basic = StandardInt.MakeBasic(struct
  include OCamlStandard.Nativeint

  let name = "NativeInt"
  let repr_suffix = "n"

#if OCAML_VERSION < (4, 3, 0)
  let equal = Equate.Poly.equal
#endif
end)

module Extended(Facets: Facets) = struct
  module Self = struct
    include Basic
    include StandardInt.MakeExtensions(Facets)(struct
      include Basic

      let name = "NativeInt"
    end)
  end

  include Self

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/NativeInt.ml"

    include Tests_.Make(Self)(struct
      let module_name = "NativeInt"

      let values = [21n; -32n]

      let conversions_from_string = [
        ("43", 43n);
        ("-12", -12n);
        ("1_000", 1000n);
        ("0x10", 16n);
        ("0o10", 8n);
        ("0b10", 2n);
      ]

      let unconvertible_strings = ["a"]

      let representations = [
        (-3n, "-3n");
        (-0n, "0n");
        (0n, "0n");
        (1n, "1n");
        (15n, "15n");
      ]

      let conversions_to_string = [
        (-3n, "-3");
        (-0n, "0");
        (0n, "0");
        (1n, "1");
        (15n, "15");
      ]

      let equalities = []

      let differences = [
        (0n, 1n);
        (1n, -1n);
      ]

      let strict_orders = [
        [-10n; -5n; -1n; 0n; 1n; 2n; 5n];
      ]

      let order_classes = []

      let additions = [
        (4n, 3n, 7n);
        (4n, -2n, 2n);
        (5n, -7n, -2n);
      ]

      let negations = [
        (4n, -4n);
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

      let conversions_to_int = [
        (12n, 12)
      ]

      let conversions_from_int = [
        (12, 12n)
      ]

      let conversions_to_float = [
        (12n, 12.)
      ]

      let conversions_from_float = [
        (12., 12n);
        (12.99, 12n);
        (-12.99, -12n);
      ]
    end)(struct
      open Testing

      let tests = [
        "NativeInt: exponentiate 2n (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "NativeInt.exponentiate: Negative exponent: -4") (lazy (exponentiate 2n (-4)))));
      ]
    end)
  end
end
