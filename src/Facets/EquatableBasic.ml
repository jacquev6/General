#include "../Generated/Facets/EquatableBasic.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeExpectations(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let equal_pairs =
      E.equalities
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = M.repr x and ry = M.repr y in
          let pairs = [(y, ry, x, rx)] in
          if Equate.Phys.equal x y then pairs else (x, rx, y, ry)::pairs
        )
      )

    let different_pairs =
      E.differences
      |> List.flat_map ~f:(fun (x, y) ->
        let rx = M.repr x and ry = M.repr y in
        [(x, rx, y, ry); (y, ry, x, rx)]
      )
  end

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    open Testing

    let tests =
      let module Expectations = MakeExpectations(M)(E) in
      [
        "Examples (i.e. 'values', 'equalities', and 'differences')" >:: (
          E.values
          |> List.map ~f:(fun x ->
            ~: "%s is in equalities" (M.repr x) (lazy (
              E.equalities
              |> List.there_exists ~f:(fun xs -> List.contains xs x ~equal_a:M.equal)
              |> check_true
            ))
          )
        ) @ (
          E.values
          |> List.map ~f:(fun x ->
            ~: "%s is in differences" (M.repr x) (lazy (
              E.differences
              |> List.there_exists ~f:(fun (y, z) -> M.equal x y || M.equal x z)
              |> check_true
            ))
          )
        );
      ]
      @ (List.map Expectations.equal_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "equal %s %s" rx ry (lazy (M.equal x y |> check_true))
      ))
      @ (List.map Expectations.different_pairs ~f:(fun (x, rx, y, ry) ->
        ~: "equal %s %s" rx ry (lazy (M.equal x y |> check_false))
      ))
  end)
end
