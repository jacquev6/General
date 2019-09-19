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
    x
    |> to_string
    |> Format.apply "%S"

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
    (of_string "foo", "\"foo\"");
    (of_string "bar\"baz", "\"bar\\\"baz\"");
  ]

  let displays = [
    (of_string "foo", "foo");
    (of_string "bar\"baz", "bar\"baz");
  ]

  let equalities = [
    [of_string "foo"];
  ]

  let differences = [
    (of_string "foo", of_string "bar");
  ]

  let orders = [
    [of_string "aaaa"; of_string "aaaaa"; of_string "aaaab"; of_string "ab"; of_string "b"];
  ]
end)(struct
  let tests = []
end)
