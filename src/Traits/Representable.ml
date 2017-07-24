include (Traits_.Representable_: module type of Representable_)

module Tests = struct
  module Make0(M: S0)(E: Representable_.Examples.S0 with type t := M.t) = struct
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
