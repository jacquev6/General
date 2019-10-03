#include "../Generated/Facets/Parsable.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTesters(M: Testable.S0)(E: sig val module_name: string end): sig
    val test_conversion: string * M.t -> Test.t list
    val test_unconvertible: string -> Test.t list
  end = struct
    open Testing

    let check_m = M.(check ~equal ~repr)
    let check_some_m = M.(check_some ~repr ~equal)
    let check_none_m = M.(check_none ~repr ~equal)

    let test_conversion (x, y) = [
      ~: "Parsable: of_string %S" x (lazy (M.of_string x |> check_m ~expected:y));
      ~: "Parsable: try_of_string %S" x (lazy (M.try_of_string x |> check_some_m ~expected:y));
    ]

    let test_unconvertible x = [
      ~: "Parsable: of_string %S" x (lazy (expect_exception ~expected:(Exception.InvalidArgument(Format.apply "%s.of_string" E.module_name)) (lazy (M.of_string x))));
      ~: "Parsable: try_of_string %S" x (lazy (M.try_of_string x |> check_none_m));
    ]
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    module Testers = MakeTesters(M)(E)

    let tests = []
      @ (List.flat_map E.conversions_from_string ~f:Testers.test_conversion)
      @ (List.flat_map E.unconvertible_strings ~f:Testers.test_unconvertible)
  end)
end
