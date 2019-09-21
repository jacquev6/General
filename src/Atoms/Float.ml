#include "../Generated/Atoms/Float.ml"

module Basic = struct
  type t = float

  let zero = 0.
  let one = 1.
  let pi = OCSP.(4. *. atan 1.)
  let e = OCSP.exp 1.
  let smallest = OCSP.min_float
  let greatest = OCSP.max_float
  let epsilon = OCSP.epsilon_float
  let infinity = OCSP.infinity
  let negative_infinity = OCSP.neg_infinity
  let not_a_number = OCSP.nan

  let of_int = OCSP.float_of_int
  let to_int = OCSP.int_of_float
  let of_float = Function1.identity
  let to_float = Function1.identity
  let of_string = OCSP.float_of_string
  let try_of_string s =
    Exception.or_none (lazy (of_string s))
  let to_string = OCSP.string_of_float

  let of_parts ~significand ~exponent = OCSP.ldexp significand exponent
  let to_parts = OCSP.frexp

  let to_fractional_and_integral = OCSP.modf

  let repr = OCSP.string_of_float

  let add = OCSP.(+.)
  let subtract = OCSP.(-.)
  let negate = OCSP.(~-.)
  let multiply = OCSP.( *. )
  let divide = OCSP.(/.)
  let square x = multiply x x
  let abs = OCSP.abs_float
  let modulo = OCSP.mod_float

  let sqrt = OCSP.sqrt

  let exp = OCSP.exp
  let log = OCSP.log
  let log10 = OCSP.log10
  let expm1 = OCSP.expm1
  let log1p = OCSP.log1p

  let cos = OCSP.cos
  let sin = OCSP.sin
  let tan = OCSP.tan
  let acos = OCSP.acos
  let asin = OCSP.asin
  let atan = OCSP.atan
  let atan2 ~y ~x = OCSP.atan2 y x
  let hypot = OCSP.hypot
  let cosh = OCSP.cosh
  let sinh = OCSP.sinh
  let tanh = OCSP.tanh

  let ceil = OCSP.ceil
  let floor = OCSP.floor
  let copy_sign x ~sign = OCSP.copysign x sign

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O

    let (~-) = OCSP.(~-.)
    let (~+) = OCSP.(~+.)
    let (+) = OCSP.(+.)
    let (-) = OCSP.(-.)
    let ( * ) = OCSP.( *. )
    let (/) = OCSP.(/.)
    let (mod) = OCSP.mod_float
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)

  let approx_equal ?(precision=1e-10) a b =
    less_than (abs (subtract a b)) precision

  module O_dot = struct
    let (~-.) = OCSP.(~-.)
    let (~+.) = OCSP.(~+.)
    let (+.) = OCSP.(+.)
    let (-.) = OCSP.(-.)
    let ( *. ) = OCSP.( *. )
    let (/.) = OCSP.(/.)
    let ( ** ) = OCSP.( ** )
  end
end

module Extended(Facets: Facets) = struct
  module SelfA = struct
    include Basic

    include Facets.Ringoid.Exponentiate.Make0(struct
      include Basic

      let exponentiate_negative_exponent ~exponentiate x n =
        exponentiate (divide 1. x) (Int.negate n)
    end)

    include Facets.Comparable.Between.Make0(Basic)
  end

  module SelfB = struct
    module O = struct
      include SelfA.O

      let ( ** ) = SelfA.exponentiate
    end

    include (SelfA: module type of SelfA[@remove_aliases] with module O := O)
  end

  include SelfB

  module Class = struct
    module SelfA = struct
      type t = Normal | SubNormal | Zero | Infinite | NotANumber
    end

    #include "../Generated/Atoms/Float/Class.ml"

    module SelfB = struct
      include SelfA

      let of_float x =
        match OCSP.classify_float x with
          | OCSP.FP_normal -> Normal
          | OCSP.FP_subnormal -> SubNormal
          | OCSP.FP_zero -> Zero
          | OCSP.FP_infinite -> Infinite
          | OCSP.FP_nan -> NotANumber

      let repr = function
        | Normal -> "Normal"
        | SubNormal -> "SubNormal"
        | Zero -> "Zero"
        | Infinite -> "Infinite"
        | NotANumber -> "NotANumber"

      module O = struct
        include Compare.Poly.O
        include Equate.Poly.O
      end

      include (Compare.Poly: module type of Compare.Poly with module O := O)
      include (Equate.Poly: module type of Equate.Poly with module O := O)
    end

    include SelfB

    (*
    module Tests = Tests_.Make(SelfB)(struct
      let representations = [
        (Normal, "Normal");
        (SubNormal, "SubNormal");
        (Zero, "Zero");
        (Infinite, "Infinite");
        (NotANumber, "NotANumber");
      ]

      let equalities = [
        [Normal];
        [SubNormal];
        [Zero];
        [Infinite];
        [NotANumber];
      ]

      let differences = [
        (Normal, SubNormal);
      ]

      let orders = [
        [Normal; SubNormal; Zero; Infinite; NotANumber];
      ]
    end)(struct
      open Testing

      let tests = [
        "of_float" >:: (
          let check = check ~repr ~equal in
          [
            "Normal" >: (lazy (check ~expected:Normal (of_float 1.)));
            "SubNormal" >: (lazy (check ~expected:SubNormal (of_float (1. /. greatest))));
            "Zero" >: (lazy (check ~expected:Zero (of_float 0.)));
            "Zero-" >: (lazy (check ~expected:Zero (of_float (-0.))));
            "Infinite+" >: (lazy (check ~expected:Infinite (of_float (1. /. 0.))));
            "Infinite+" >: (lazy (check ~expected:Infinite (of_float infinity)));
            "Infinite-" >: (lazy (check ~expected:Infinite (of_float (-1. /. 0.))));
            "Infinite-" >: (lazy (check ~expected:Infinite (of_float negative_infinity)));
            "NotANumber" >: (lazy (check ~expected:NotANumber (of_float (0. /. 0.))));
            "NotANumber" >: (lazy (check ~expected:NotANumber (of_float not_a_number)));
            "NotANumber-" >: (lazy (check ~expected:NotANumber (of_float (-0. /. 0.))));
          ]
        );
      ]
    end)
    *)
  end
end

(*
module Tests = Tests_.Make(SelfB)(struct
  let representations = [
    (-3., "-3.");
    (-0., "-0.");
    (0., "0.");
    (1., "1.");
    (15., "15.");
  ]

  let displays = representations

  let literals = [
    ("0", 0.);
    ("1", 1.);
    ("1.0", 1.);
    ("-1", -1.);
    ("1_000", 1000.);
  ]

  let equalities = [
    [0.];
    [1.];
    [2.];
    [infinity];
    [negative_infinity];
  ]

  let differences = [
    (0., 1.);
    (1., -1.);
    (not_a_number, infinity);
    (not_a_number, negative_infinity);
    (not_a_number, 1.);
    (not_a_number, 0.);
    (not_a_number, not_a_number);
  ]

  let orders = [
    [-10.; -5.; -1.; -0.2; 0.; 0.7; 1.; 2.; 5.];
  ]

  let additions = [
    (4., 3., 7.);
    (4., -2., 2.);
    (5., -7., -2.);
  ]

  let negations = [
    (4., -4.);
    (-7., 7.);
  ]

  let multiplications = [
    (4., 3., 12.);
    (4., -3., -12.);
    (-4., -3., 12.);
  ]

  let divisions = [
    (5., 2., 2.5);
    (4., 2., 2.);
    (1., 4., 0.25);
    (4., 4., 1.);
    (4., 5., 0.8);
  ]

  let exponentiations = [
    (3., 3, 27.);
    (2., 7, 128.);
    (0.5, 4, 0.0625);
    (2., -4, 0.0625);
  ]
end)(struct
  open Testing

  let tests = [
    "ceil" >:: (
      let make x expected =
        ~: "%f" x (lazy (check_float_exact ~expected (ceil x)))
      in
      [
        make (-1.) (-1.);
        make (-0.99) 0.;
        make (-0.1) 0.;
        make 0. 0.;
        make 0.01 1.;
        make 0.99 1.;
        make 1. 1.;
      ]
    );
    Class.Tests.test;
  ]
end)
*)
