#ext python3
from geni import *
generate(parsable.implementation_items)
#endext

module Tests = struct
  open Testing

#ext python3
from geni import *
generate(parsable.tests_examples_implementation, indent=1)
#endext

  module Make0(M: sig
    include S0
    include Equatable.Basic.S0 with type t := t
    include Representable.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Parsable" >:: (
      E.of_string
      |> List.flat_map ~f:(fun (s, expected) ->
        [
          ~: "of_string %S" s (lazy (check ~repr ~equal ~expected (of_string s)));
          ~: "try_of_string %S" s (lazy (check_some ~repr ~equal ~expected (try_of_string s)));
        ]
      )
    )
  end
end
