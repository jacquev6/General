#include "../Generated/Atoms/Bytes.ml"

module OCSB = OCamlStandard.Bytes

module Self = struct
  type t = bytes

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)

  let of_string = OCSB.of_string
  let to_string = OCSB.to_string

  let repr x =
    Format.apply "%S" x

  let get = OCSB.get
  let set = OCSB.set

  let size = OCSB.length

  let empty = OCSB.empty

  let make ~len =
    OCSB.create len
end

include Self

module Tests = Tests_.Make(Self)(struct
  let representations = [
    ("foo", "\"foo\"");
    ("bar\"baz", "\"bar\\\"baz\"");
  ]

  let displays = [
    ("foo", "foo");
    ("bar\"baz", "bar\"baz");
  ]

  let equalities = [
    ["foo"];
  ]

  let differences = [
    ("foo", "bar");
  ]

  let orders = [
    ["aaaa"; "aaaaa"; "aaaab"; "ab"; "b"];
  ]
end)(struct
  let tests = []
end)
