module Basic = StandardInt.Make(struct
  include OCamlStandard.Int32

  let name = "Int32"
  let repr_suffix = "l"
  let size = 32

#if OCAML_VERSION < (4, 3, 0)
  let equal = Equate.Poly.equal
#endif
end)

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/Int32.ml"

    include Tests_.Make(Basic)(struct
      let module_name = "Int32"

      let values = [21l; -32l]

      let conversions_from_string = [
        ("43", 43l);
        ("-12", -12l);
        ("1_000", 1000l);
        ("0x10", 16l);
        ("0o10", 8l);
        ("0b10", 2l);
      ]

      let unconvertible_strings = ["a"]

      let representations = [
        (-3l, "-3l");
        (-0l, "0l");
        (0l, "0l");
        (1l, "1l");
        (15l, "15l");
      ]

      let conversions_to_string = [
        (-3l, "-3");
        (-0l, "0");
        (0l, "0");
        (1l, "1");
        (15l, "15");
      ]

      let equalities = []

      let differences = [
        (0l, 1l);
        (1l, -1l);
      ]

      let strict_orders = [
        [-10l; -5l; -1l; 0l; 1l; 2l; 5l];
      ]

      let order_classes = []

      let additions = [
        (4l, 3l, 7l);
        (4l, -2l, 2l);
        (5l, -7l, -2l);
      ]

      let negations = [
        (4l, -4l);
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

      let conversions_to_int = [
        (12l, 12)
      ]

      let conversions_from_int = [
        (12, 12l)
      ]

      let conversions_to_float = [
        (12l, 12.)
      ]

      let conversions_from_float = [
        (12., 12l);
        (12.99, 12l);
        (-12.99, -12l);
      ]
    end)(struct
      open Testing

      let tests = [
        "Int32: exponentiate 2l (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int32.exponentiate: Negative exponent: -4") (lazy (exponentiate 2l (-4)))));
      ]
    end)
  end
end
