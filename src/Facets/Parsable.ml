#include "../Generated/Facets/Parsable.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let check_m = M.(check ~repr ~equal)

    let check_some_m = M.(check_some ~repr ~equal)
    let check_none_m = M.(check_none ~repr ~equal)

    let tests = []
      @ (List.map E.literals ~f:(fun (s, expected) ->
        ~: "of_string %S" s (lazy (M.of_string s |> check_m ~expected))
      ))
      @ (List.map E.unparsable ~f:(fun s ->
        ~: "of_string %S" s (lazy (expect_exception_named ~expected:"Invalid_argument" (lazy (M.of_string s))))
      ))
      @ (List.map E.literals ~f:(fun (s, expected) ->
        ~: "try_of_string %S" s (lazy (M.try_of_string s |> check_some_m ~expected))
      ))
      @ (List.map E.unparsable ~f:(fun s ->
        ~: "try_of_string %S" s (lazy (M.try_of_string s |> check_none_m))
      ))
  end)
end
