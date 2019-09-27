#include "../Generated/Atoms/BigInt.ml"

module OCSB = OCamlStandard.Big_int

module SelfA = struct
  type t = OCSB.big_int

  let zero = OCSB.zero_big_int
  let one = OCSB.unit_big_int

  let of_int = OCSB.big_int_of_int
  let to_int = OCSB.int_of_big_int

  let of_float x =
    let of_small_float x =
      x
      |> Int64.of_float
      |> OCSB.big_int_of_int64
    and breakpoint =
      58 (* Any integer between 53 and 63 (included) works, because floats have 53 significant bits and int64s have 63 significant bits *)
    in
    let (significand, exponent) = Float.to_parts x in
    if exponent <= breakpoint then
      of_small_float x
    else
      OCSB.shift_left_big_int
        (of_small_float (Float.of_parts ~significand ~exponent:breakpoint))
        (exponent - breakpoint)

  let to_float = OCSB.float_of_big_int

  let of_string s =
    try
      OCSB.big_int_of_string s
    with Exception.Failure "invalid digit" -> Exception.invalid_argument "BigInt.of_string"

  let try_of_string s =
    Exception.or_none (lazy (OCSB.big_int_of_string s))

  let to_string = OCSB.string_of_big_int

  let repr = to_string

  let abs = OCSB.abs_big_int

  let negate = OCSB.minus_big_int
  let add = OCSB.add_big_int
  let subtract = OCSB.sub_big_int
  let multiply = OCSB.mult_big_int
  let divide = OCSB.div_big_int
  let modulo = OCSB.mod_big_int
  let square = OCSB.square_big_int
  let exponentiate x n =
    if n < 0 then
      Exception.invalid_argument "BigInt.exponentiate: Negative exponent: %i" n
    else
      OCSB.power_big_int_positive_int x n

  let pred = OCSB.pred_big_int
  let succ = OCSB.succ_big_int

  let equal = OCSB.eq_big_int

  let compare = Compare.of_standard OCSB.compare_big_int
  let less_than = OCSB.lt_big_int
  let less_or_equal = OCSB.le_big_int
  let greater_than = OCSB.gt_big_int
  let greater_or_equal = OCSB.ge_big_int
end

module SelfB = struct
  include SelfA

  include Facets.Comparable.Between.Make0(SelfA)
  include Facets.Comparable.MinMax.Make0(SelfA)
  include Facets.Equatable.Different.Make0(SelfA)
end

module Self = struct
  include SelfB

  module O = struct
    include Facets.Comparable.Operators.Make0(SelfB)
    include Facets.Equatable.Operators.Make0(SelfB)
    include Facets.Ringoid.Operators.Make0(SelfB)

    let (mod) = modulo
  end
end

include Self

module MakeTests(Testing: Testing) = struct
  include Tests_.Make(Self)(struct
    let i = OCSB.big_int_of_int
    let s = OCSB.big_int_of_string

    let module_name = "BigInt"

    let values = [
      i 4;
      i (-10);
    ]

    let successions = [
      (i 41, i 42);
      (i (-6), i (-5));
    ]

    let equalities = []

    let differences = [
      (i 4, i (-10));
    ]

    let strict_orders = [
      [i (-3); i (-1); zero; one; i 5];
    ]

    let order_classes = []

    let exponentiations = [
      (i 10, 10, s "10000000000");
      (i 10, 40, s "10000000000000000000000000000000000000000");
    ]

    let divisions = [
      (i 45, i 9, i 5);
    ]

    let multiplications = [
      (i 7, i 3, i 21);
    ]

    let negations = [
      (i 12, i (-12));
    ]

    let additions = [
      (i 100, i 27, i 127);
    ]

    let representations = [
      (i 10, "10");
      (s "10000000000000000000000000000000000000000", "10000000000000000000000000000000000000000");
    ]

    let conversions_to_string = representations

    let conversions_from_string = [
      ("100000", i 100000);
    ]

    let unconvertible_strings = ["abcd"; "1000a"]

    let conversions_from_int = [
      (100, s "100");
    ]

    let conversions_to_int = [
      (s "100", 100);
    ]

    let conversions_from_float = [
      (100., s "100");
    ]

    let conversions_to_float = [
      (s "100", 100.);
    ]
  end)(struct
    open Testing

    let tests = [
      "BigInt: exponentiate (of_int 2) (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "BigInt.exponentiate: Negative exponent: -4") (lazy (exponentiate (of_int 2) (-4)))));
      "of_float" >:: (
        let check ~expected x =
          check ~repr ~equal ~expected:(of_string expected) (of_float x)
        in
        let make_2p p expected =
          (* This tests only the most significant bit *)
          ~: "BigInt: 2 ^ %i" p (lazy (check ~expected (2. ** (Float.of_int p))))
        and make_2pm2q p q expected =
          (* This can test all bits if q = max 0 (p - 53) *)
          ~: "BigInt: 2 ^ %i - 2 ^ %i" p q (lazy (check ~expected (2. ** (Float.of_int p) -. 2. ** (Float.of_int q))))
        in
        [
          (* http://www.wolframalpha.com/input/?i=2^95+-+2^42 *)
          make_2pm2q 0 0 "0";
          make_2pm2q 1 0 "1";
          make_2pm2q 2 0 "3";
          make_2pm2q 3 0 "7";
          make_2pm2q 50 0 "1125899906842623";
          make_2pm2q 51 0 "2251799813685247";
          make_2pm2q 52 0 "4503599627370495";
          make_2pm2q 53 0 "9007199254740991";
          make_2pm2q 54 1 "18014398509481982";
          make_2pm2q 55 2 "36028797018963964";
          make_2pm2q 56 3 "72057594037927928";
          make_2pm2q 57 4 "144115188075855856";
          make_2pm2q 95 42 "39614081257132164398725464064";
          (* http://www.tsm-resources.com/alists/pow2.html *)
          make_2p 1 "2";
          make_2p 2 "4";
          make_2p 15 "32768";
          make_2p 16 "65536";
          make_2p 17 "131072";
          make_2p 31 "2147483648";
          make_2p 32 "4294967296";
          make_2p 33 "8589934592";
          make_2p 63 "9223372036854775808";
          make_2p 64 "18446744073709551616";
          make_2p 65 "36893488147419103232";
          make_2p 127 "170141183460469231731687303715884105728";
          make_2p 128 "340282366920938463463374607431768211456";
          make_2p 129 "680564733841876926926749214863536422912";
          (* http://www.wolframalpha.com/input/?i=2^1023 *)
          make_2p 1023 "89884656743115795386465259539451236680898848947115328636715040578866337902750481566354238661203768010560056939935696678829394884407208311246423715319737062188883946712432742638151109800623047059726541476042502884419075341171231440736956555270413618581675255342293149119973622969239858152417678164812112068608";
        ]
      );
    ]
  end)
end
