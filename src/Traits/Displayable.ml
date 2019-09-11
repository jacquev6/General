module Generated = struct
  #include "../Generated/Traits/Displayable.ml"
end

include Generated

module Tests = struct
  open Testing

  include Tests_

  module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Displayable" >:: (
      E.to_string
      |> List.map ~f:(fun (v, expected) ->
        ~: "to_string %s" expected (lazy (check_string ~expected (to_string v)))
      )
    )
  end
end
