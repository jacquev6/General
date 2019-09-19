#include "../Generated/Atoms/CallStack.ml"

(* The position of these symbols is tested below. Moving them requires fixing the tests *)
let rec stack = function
  | 0 -> [Some (Foundations.CallStack.current ())]
  | n -> None::(stack (n - 1))

let stack =
  stack 2
  |> List.filter_map ~f:identity
  |> List.head
(* End of symbols to not move *)

module Self = struct
  include Foundations.CallStack
end

include Self

module Tests = Tests_.Make(Self)(struct
  let displays = [
    (
      stack,
      if Testing.javascript then
        "" (*BISECT-IGNORE*)
      else
        "Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 15-49\n\
        Called from file \"Atoms/CallStack.ml\", line 6, characters 15-30\n\
        Called from file \"Atoms/CallStack.ml\", line 6, characters 15-30\n\
        Called from file \"Atoms/CallStack.ml\", line 9, characters 2-9\n"
    );
  ]

  let representations = displays
end)(struct
  open Testing

  (* @todo Restore those tests *)
  (* module LocationExamples = struct
    let representations = [
      (
        {Location.filename="Atoms/CallStack.ml"; line_number=3; start_char=15; end_char=49},
        "{filename=\"Atoms/CallStack.ml\"; line_number=3; start_char=15; end_char=49}"
      );
    ]
  end *)

  let tests = [
    "frames" >: (lazy (check_int ~expected:(if javascript then 0 else 4) (stack |> frames |> List.size))); (*BISECT-IGNORE*)
    (* "Location" >:: [ *)
      (* (let module T = Facets.Comparable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
      (* (let module T = Facets.Equatable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
      (* (let module T = Facets.Representable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
    (* ]; *)
    (* "Frame" >:: (
      match frames stack with
        | [] -> [] (*BISECT-IGNORE*)
        | frame::_ -> Frame.[
            "format 0" >: (lazy (check_some_string ~expected:"Raised by primitive operation at file \"Atoms/CallStack.ml\", line 3, characters 15-49" (format 0 frame)));
            "format 1" >: (lazy (check_some_string ~expected:"Called from file \"Atoms/CallStack.ml\", line 3, characters 15-49" (format 1 frame)));
            "location" >: (lazy (check_some ~repr:Location.repr ~equal:Location.equal ~expected:{Location.filename="Atoms/CallStack.ml"; line_number=3; start_char=15; end_char=49} (location frame)))
          ]
    ); *)
  ]
end)
