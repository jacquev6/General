module Make0(M: Traits.Representable.S0)(E: Traits.Representable.Examples.S0 with type t := M.t) = struct
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
