open General.Abbr
module Printf = OCamlStandard.Printf

module DemoInteger(N: sig val name: string end)(I: General.Concepts.Integer.S0) = struct
  (* Define unusable operators to demonstrate that O actually defines the operators we use. *)
  let (=) = ()
  let (+) = ()
  let (-) = ()

  open I

  let print s v =
    Printf.printf "%s.(%s): %s\n" N.name s v

  let print_int s v =
    print s (repr v)

  let print_bool s v =
    print s (OCamlStandard.Pervasives.string_of_bool v)

  #define TEST(type, value) let () = CONCAT(print_, type) STRINGIFY(value) value

  TEST(int, zero)
  TEST(int, one)
  TEST(int, O.(one + one))
  TEST(int, O.(one - one))
  TEST(bool, O.(one = one))
  TEST(bool, O.(zero = one))
end

let () = Printf.printf "General.Int.succ 4: %n\n" (General.Int.succ 4)

module DemoGeneralInt = DemoInteger(struct let name = "General.Int" end)(General.Int)

module BasicIntMod3 = struct
  open OCamlStandard.Pervasives

  type t = int
  let zero = 0
  let one = 1
  let of_int x = x mod 3
  let to_int x = x
  let repr = string_of_int
  let of_float x = (int_of_float x) mod 3
  let to_float = float_of_int
  let of_string x = (int_of_string x) mod 3
  let to_string = string_of_int
  let abs x = x

  let add x y =
    (x + y) mod 3

  let substract x y =
    (x - y + 6) mod 3

  let negate x =
    (6 - x) mod 3

  let multiply x y =
    (x * y) mod 3

  let divide x y =
    (x / y + 6) mod 3

  let equal = (=)

  let compare x y =
    let c = compare x y in
    General.Compare.(if c = 0 then EQ else if c < 0 then LT else GT)
end

(* Just to check that these functors are exported correctly *)
module IntMod3_AsComparable = General.Traits.Comparable.Make0(BasicIntMod3)
module IntMod3_AsEquatable = General.Traits.Equatable.Make0(BasicIntMod3)
(* No General.Traits.Representable.Make0 *)
module IntMod3_AsRingoid = General.Traits.Ringoid.Make0(BasicIntMod3)
module IntMod3_AsNumber = General.Concepts.Number.Make0(BasicIntMod3)
module IntMod3_AsRealNumber = General.Concepts.RealNumber.Make0(BasicIntMod3)

module IntMod3 = General.Concepts.Integer.Make0(BasicIntMod3)

module DemoIntMod3 = DemoInteger(struct let name = "IntMod3" end)(IntMod3)

module IntMod3Examples = struct
  open IntMod3

  let equal = [
    [of_int 0; of_int 3];
  ]

  let ordered = []

  let different = []

  let repr = []

  let to_string = []

  let add_substract = [
    (1, 2, 0);
    (2, 2, 1);
  ]

  let negate = [
    (0, 0);
    (1, 2);
  ]

  let multiply = [
    (2, 2, 1);
  ]

  let divide = [
    (2, 1, 2);
    (2, 2, 1);
    (1, 2, 0);
  ]
end


let () =
  let test = General.Testing.(
    "demo" >:: [
      (let module T = General.Traits.Comparable.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Traits.Equatable.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Traits.Representable.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Traits.Ringoid.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Concepts.Number.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Concepts.RealNumber.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (* Integer.Tests includes all tests above. The previous lines are only here to prove that we export the functors. *)
      (let module T = General.Concepts.Integer.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
    ]
  ) in
  exit (General.Testing.command_line_main ~argv:OCamlStandard.(Array.to_list Sys.argv) test)
