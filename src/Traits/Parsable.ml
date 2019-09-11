module Generated = struct
  #include "../Generated/Traits/Parsable.ml"
end

include Generated

module Tests = struct
  open Testing

  include Tests_

  module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
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
