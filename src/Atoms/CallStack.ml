#include "../Generated/Atoms/CallStack.ml"

(*
(* The position of these symbols is tested below. Moving them requires fixing the tests *)
let rec stack = function
  | 0 -> [Some (Foundations.CallStack.current ())]
  | n -> None::(stack (n - 1))

let stack =
  stack 2
  |> List.filter_map ~f:identity
  |> List.head
(* End of symbols to not move *)
*)

module Self = struct
  module OCSPE = OCamlStandard.Printexc

  type t = OCSPE.raw_backtrace

  let current ?(max_size=Int.greatest) () =
    OCSPE.get_callstack max_size

  let to_string = OCSPE.raw_backtrace_to_string
  let repr = to_string

  module Location = struct
    type t = OCSPE.location = {
      filename: string;
      line_number: int;
      start_char: int;
      end_char: int;
    }

    let repr {filename; line_number; start_char; end_char} =
      Format.apply "{filename=%S; line_number=%n; start_char=%n; end_char=%n}" filename line_number start_char end_char

    module O = struct
      include Equate.Poly.O
      include Compare.Poly.O
    end

    include (Equate.Poly: module type of Equate.Poly with module O := O)
    include (Compare.Poly: module type of Compare.Poly with module O := O)
  end

  module Frame = struct
    type t = OCSPE.backtrace_slot

    let is_raise = OCSPE.Slot.is_raise

    let location = OCSPE.Slot.location

    let format = OCSPE.Slot.format
  end

  let frames bt =
    match OCSPE.backtrace_slots bt with
      | None -> [] (*BISECT-IGNORE*) (* Would require compiling without tag debug *)
      | Some frames -> List.of_array frames
end

include Self

(*
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
*)
