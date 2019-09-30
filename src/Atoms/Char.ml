module Basic = struct
  module OCSP = OCamlStandard.Pervasives
  module OCSS = OCamlStandard.String

  type t = char

  let of_int = OCSP.char_of_int
  let to_int = OCSP.int_of_char

  let repeat c ~len =
    OCSS.make len c

  let to_string c =
    OCSS.make 1 c

  let repr c =
    Format.apply "%C" c

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)
end

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/Char.ml"

    include Tests_.Make(Basic)(struct
      let values = ['a'; 'z']

      let equalities = []

      let differences = [
        ('a', 'A');
      ]

      let representations = [
        ('a', "'a'");
      ]

      let conversions_to_string = [
        ('a', "a");
      ]

      let strict_orders = [
        ['a'; 'b'; 'c'; 'z'];
        ['A'; 'a'];
        ['A'; 'Z'];
        ['0'; '1'; '9'];
      ]

      let order_classes = []

      let conversions_from_int = [
        (65, 'A');
      ]

      let conversions_to_int = [
        ('A', 65);
      ]
    end)(struct
      let tests = []
    end)
  end
end
