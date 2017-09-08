(* The position of these symbols is tested below. Moving them requires fixing the tests *)
let rec stack = function
  | 0 -> [Some (Foundations.CallStack.current ())]
  | n -> None::(stack (n - 1))

let stack =
  stack 2
  |> List_.filter_map ~f:identity
  |> List_.head
(* End of symbols to not move *)

include Foundations.CallStack

module Tests = struct
  open Testing

  module Examples = struct
    let to_string = [
      (
        stack,
        if javascript then
          "" (*BISECT-IGNORE*)
        else
          "Raised by primitive operation at file \"src/Implementation/CallStack.ml\", line 3, characters 19-53\n\
          Called from file \"src/Implementation/CallStack.ml\", line 4, characters 19-34\n\
          Called from file \"src/Implementation/CallStack.ml\", line 4, characters 19-34\n\
          Called from file \"src/Implementation/CallStack.ml\", line 7, characters 6-13\n"
      );
    ]

    let repr = to_string
  end

  module LocationExamples = struct
    let repr = [
      (
        {Location.filename="src/Implementation/CallStack.ml"; line_number=3; start_char=15; end_char=49},
        "{filename=\"src/Implementation/CallStack.ml\"; line_number=3; start_char=15; end_char=49}"
      );
    ]
  end

  let test = "CallStack" >:: [
    (let module T = Traits.Displayable.Tests.Make0(Foundations.CallStack)(Examples) in T.test);
    (let module T = Traits.Representable.Tests.Make0(Foundations.CallStack)(Examples) in T.test);
    "frames" >: (lazy (check_int ~expected:(if javascript then 0 else 4) (stack |> frames |> List_.size))); (*BISECT-IGNORE*)
    "Location" >:: [
      (* (let module T = Traits.Comparable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
      (* (let module T = Traits.Equatable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
      (let module T = Traits.Representable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test);
    ];
    "Frame" >:: (
      match frames stack with
        | [] -> [] (*BISECT-IGNORE*)
        | frame::_ -> Frame.[
            "format 0" >: (lazy (check_some_string ~expected:"Raised by primitive operation at file \"src/Implementation/CallStack.ml\", line 3, characters 19-53" (format 0 frame)));
            "format 1" >: (lazy (check_some_string ~expected:"Called from file \"src/Implementation/CallStack.ml\", line 3, characters 19-53" (format 1 frame)));
            "location" >: (lazy (check_some ~repr:Location.repr ~equal:Location.equal ~expected:{Location.filename="src/Implementation/CallStack.ml"; line_number=3; start_char=19; end_char=53} (location frame)))
          ]
    );
  ]
end
