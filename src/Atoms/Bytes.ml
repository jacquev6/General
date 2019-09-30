module Basic = struct
  module OCSB = OCamlStandard.Bytes

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

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/Bytes.ml"

    include Tests_.Make(Basic)(struct
      let values = [of_string "foo"]

      let representations = [
        (of_string "foo", "\"foo\"");
        (of_string "bar\"baz", "\"bar\\\"baz\"");
      ]

      let conversions_to_string = [
        (of_string "foo", "foo");
        (of_string "bar\"baz", "bar\"baz");
      ]

      let equalities = []

      let differences = [
        (of_string "foo", of_string "bar");
      ]

      let strict_orders = [
        [of_string "aaaa"; of_string "aaaaa"; of_string "aaaab"; of_string "ab"; of_string "b"];
      ]

      let order_classes = []
    end)(struct
      let tests = []
    end)
  end
end
