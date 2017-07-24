include (Traits.Representable: module type of Traits.Representable)

module Tests = struct
  module Make0(M: S0)(E: Traits.Representable.Examples.S0 with type t := M.t) = struct
    open Testing
    open StdLabels

    open M

    let test = "Representable" >:: (
      E.repr
      |> List.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (repr v)))
      )
    )
  end
end
