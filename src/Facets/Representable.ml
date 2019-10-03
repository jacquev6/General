#include "../Generated/Facets/Representable.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let tests =
      List.map E.representations ~f:(fun (v, expected) ->
        ~: "Representable: repr %s" expected (lazy (M.repr v |> check_string ~expected))
      )
  end)
end
