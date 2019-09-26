module Basic = struct
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

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/Bool.ml"

    include Tests_.Make(Basic)(struct
      let values = [true; false]

      let equalities = [[true]; [false]]

      let differences = [
        (true, false);
      ]

      let strict_orders = [
        [false; true];
      ]

      let order_classes = equalities

      let representations = [
        (false, "false");
        (true, "true");
      ]

      let displays = representations

      let literals = [
        ("false", false);
        ("true", true);
      ]

      let unparsable = ["0"; "1"; "False"; "True"; "no"; "yes"; "No"; "Yes"; "N"; "Y"]
    end)(struct
      open Testing

      let tests = [
        "not true" >: (lazy (not true |> check_false));
        "not false" >: (lazy (not false |> check_true));

        "O.not true" >: (lazy (O.not true |> check_false));
        "O.not false" >: (lazy (O.not false |> check_true));

        "and_ true true" >: (lazy (and_ true true |> check_true));
        "and_ true false" >: (lazy (and_ true false |> check_false));
        "and_ false true" >: (lazy (and_ false true |> check_false));
        "and_ false false" >: (lazy (and_ false false |> check_false));
        "and_ false raise" >: (lazy (expect_exception_named ~expected:"Failure" (lazy (and_ false (Exception.failure "")))));

        "true && true" >: (lazy (O.(true && true) |> check_true));
        "true && false" >: (lazy (O.(true && false) |> check_false));
        "false && whatever" >: (lazy (O.(false && (Exception.failure "Don't call me")) |> check_false));

        "or_ true true" >: (lazy (or_ true true |> check_true));
        "or_ true false" >: (lazy (or_ true false |> check_true));
        "or_ true raise" >: (lazy (expect_exception_named ~expected:"Failure" (lazy (or_ true (Exception.failure "")))));
        "or_ false true" >: (lazy (or_ false true |> check_true));
        "or_ false false" >: (lazy (or_ false false |> check_false));

        "true || whatever" >: (lazy (O.(true || (Exception.failure "Don't call me")) |> check_true));
        "false || true" >: (lazy (O.(false || true) |> check_true));
        "false || false" >: (lazy (O.(false || false) |> check_false));

        "xor true true" >: (lazy (xor true true |> check_false));
        "xor true false" >: (lazy (xor true false |> check_true));
        "xor false true" >: (lazy (xor false true |> check_true));
        "xor false false" >: (lazy (xor false false |> check_false));

        "O.xor true true" >: (lazy (O.xor true true |> check_false));
        "O.xor true false" >: (lazy (O.xor true false |> check_true));
        "O.xor false true" >: (lazy (O.xor false true |> check_true));
        "O.xor false false" >: (lazy (O.xor false false |> check_false));
      ]
    end)
  end
end
