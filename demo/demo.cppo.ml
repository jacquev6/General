module DemoInteger(N: sig val name: string end)(I: General.Concepts.Numbers.Integer.S0) = struct
  (* Define unusable operators to demonstrate that O actually defines the operators we use. *)
  let (=) = ()
  let (+) = ()
  let (-) = ()

  open I

  let print s v =
    Printf.printf "%s.(%s): %s\n" N.name s v

  let print_int s v =
    print s (to_string v)

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
    let of_int a = a mod 3
    let to_int a = a
    let to_string = string_of_int

    let add a b =
      (a + b) mod 3

    let sub a b =
      (a - b + 6) mod 3

    let equal = (=)

    let compare a b =
      let c = compare a b in
      General.Compare.(if c = 0 then EQ else if c < 0 then LT else GT)
  end

  include Basic
  include General.Concepts.Numbers.Integer.Extensions.Make0(Basic)
end

module DemoIntMod3 = DemoInteger(struct let name = "IntMod3" end)(IntMod3)
