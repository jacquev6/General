#include "../Generated/Facets/Displayable.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let tests =
      List.map E.displays ~f:(fun (v, expected) ->
        ~: "to_string %s" expected (lazy (M.to_string v |> check_string ~expected))
      )
  end)
end
