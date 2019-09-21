#include "../Generated/Atoms/Char.ml"

module OCSP = OCamlStandard.Pervasives
module OCSS = OCamlStandard.String

module Self = struct
  type t = char

  let of_int = OCSP.char_of_int
  let to_int = OCSP.int_of_char

  let repeat c ~len =
    OCSS.make len c

  let to_string c =
    OCSS.make 1 c

  let repr c =
    to_string c

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
  let equalities = [
    ['a'];
  ]

  let differences = [
    ('a', 'A');
  ]

  let representations = [
    ('a', "a");
  ]

  let displays = representations

  let orders = [
    ['a'; 'b'; 'c'; 'z'];
    ['A'; 'a'];
    ['A'; 'Z'];
    ['0'; '1'; '9'];
  ]
end)(struct
  let tests = []
end)
*)
