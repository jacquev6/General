#ext python3
from geni import *
generate(displayable.implementation_items)
#endext

module Tests = struct
  open Testing

#ext python3
from geni import *
generate(displayable.tests_examples_implementation, indent=1)
#endext

  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Displayable" >:: (
      E.to_string
      |> List.map ~f:(fun (v, expected) ->
        ~: "to_string %s" expected (lazy (check_string ~expected (to_string v)))
      )
    )
  end
end
