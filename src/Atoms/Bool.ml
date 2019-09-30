module Basic = struct
  type t = bool

  let of_string s =
    try
      OCamlStandard.Pervasives.bool_of_string s
    with Exception.InvalidArgument "bool_of_string" -> Exception.invalid_argument "Bool.of_string"

  let try_of_string s =
    Exception.or_none (lazy (OCamlStandard.Pervasives.bool_of_string s))

  let to_string = OCamlStandard.Pervasives.string_of_bool

  let repr = to_string

  let xor x y =
    match (x, y) with
      | (true, false) | (false, true) -> true
      | (true, true) | (false, false) -> false

  let not = OCamlStandard.Pervasives.not

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O

    let not = not (* @todo Remove: it's not infix, so it's not an operator *)
    external (&&): bool -> bool -> bool = "%sequand"
    external (||): bool -> bool -> bool = "%sequor"
    let xor = xor (* @todo Remove: it's not infix, so it's not an operator *)
  end

  include (Compare.Poly: module type of Compare.Poly with module O:= O)
  include (Equate.Poly: module type of Equate.Poly with module O:= O)

  let and_ = O.(&&)
  let or_ = O.(||)
end

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Bool.ml"

    include Tests_.Make(Basic)(struct
      let module_name = "Bool"

      let values = [true; false]

      let equalities = []

      let differences = [
        (true, false);
      ]

      let strict_orders = [
        [false; true];
      ]

      let order_classes = []

      let representations = [
        (false, "false");
        (true, "true");
      ]

      let conversions_to_string = representations

      let conversions_from_string = [
        ("false", false);
        ("true", true);
      ]

      let unconvertible_strings = ["0"; "1"; "False"; "True"; "no"; "yes"; "No"; "Yes"; "N"; "Y"]
    end)(struct
      open Testing

      let tests = [
        "Bool: not true" >: (lazy (not true |> check_false));
        "Bool: not false" >: (lazy (not false |> check_true));

        "Bool: O.not true" >: (lazy (O.not true |> check_false));
        "Bool: O.not false" >: (lazy (O.not false |> check_true));

        "Bool: and_ true true" >: (lazy (and_ true true |> check_true));
        "Bool: and_ true false" >: (lazy (and_ true false |> check_false));
        "Bool: and_ false true" >: (lazy (and_ false true |> check_false));
        "Bool: and_ false false" >: (lazy (and_ false false |> check_false));
        "Bool: and_ false raise" >: (lazy (expect_exception_named ~expected:"Failure" (lazy (and_ false (Exception.failure "")))));

        "Bool: true && true" >: (lazy (O.(true && true) |> check_true));
        "Bool: true && false" >: (lazy (O.(true && false) |> check_false));
        "Bool: false && whatever" >: (lazy (O.(false && (Exception.failure "Don't call me")) |> check_false));

        "Bool: or_ true true" >: (lazy (or_ true true |> check_true));
        "Bool: or_ true false" >: (lazy (or_ true false |> check_true));
        "Bool: or_ true raise" >: (lazy (expect_exception_named ~expected:"Failure" (lazy (or_ true (Exception.failure "")))));
        "Bool: or_ false true" >: (lazy (or_ false true |> check_true));
        "Bool: or_ false false" >: (lazy (or_ false false |> check_false));

        "Bool: true || whatever" >: (lazy (O.(true || (Exception.failure "Don't call me")) |> check_true));
        "Bool: false || true" >: (lazy (O.(false || true) |> check_true));
        "Bool: false || false" >: (lazy (O.(false || false) |> check_false));

        "Bool: xor true true" >: (lazy (xor true true |> check_false));
        "Bool: xor true false" >: (lazy (xor true false |> check_true));
        "Bool: xor false true" >: (lazy (xor false true |> check_true));
        "Bool: xor false false" >: (lazy (xor false false |> check_false));

        "Bool: O.xor true true" >: (lazy (O.xor true true |> check_false));
        "Bool: O.xor true false" >: (lazy (O.xor true false |> check_true));
        "Bool: O.xor false true" >: (lazy (O.xor false true |> check_true));
        "Bool: O.xor false false" >: (lazy (O.xor false false |> check_false));
      ]
    end)
  end
end
