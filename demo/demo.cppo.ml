module DemoInteger(N: sig val name: string end)(I: General.Concepts.Numbers.Integer.S0) = struct
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
    print s (string_of_bool v)

  #define TEST(type, value) let () = CONCAT(print_, type) STRINGIFY(value) value

  TEST(int, zero)
  TEST(int, one)
  TEST(int, O.(one + one))
  TEST(int, O.(one - one))
  TEST(bool, O.(one = one))
  TEST(bool, O.(zero = one))
end

module DemoGeneralInt = DemoInteger(struct let name = "General.Int" end)(General.Int)

module IntMod3 = struct
  module Basic = struct
    type t = int
    let zero = 0
    let one = 1
    let of_int x = x mod 3
    let to_int x = x
    let repr = string_of_int
    let of_float x = (int_of_float x) mod 3
    let to_float = float_of_int
    let of_string x = (int_of_string x) mod 3
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

  include Basic
  include General.Concepts.Numbers.Integer.Extensions.Make0(Basic)
end

module DemoIntMod3 = DemoInteger(struct let name = "IntMod3" end)(IntMod3)

module IntMod3Testable = struct
  include IntMod3

  let equal_lists = [
    [of_int 0; of_int 3];
  ]

  let ordered_lists = []

  let different_pairs = []

  let representation_examples = []

  let add_substract_examples = [
    (1, 2, 0);
    (2, 2, 1);
  ]

  let negate_examples = [
    (0, 0);
    (1, 2);
  ]

  let multiply_examples = [
    (2, 2, 1);
  ]

  let divide_examples = [
    (2, 1, 2);
    (2, 2, 1);
    (1, 2, 0);
  ]
end

let () =
  (let module M = General.Concepts.Numbers.Integer.Tests.Make0(IntMod3Testable) in M.test)
  |> General.Testing.run
  |> General.Testing.report_to_console
