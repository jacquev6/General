module Basic = struct
  type t = OCamlStandard.Printexc.raw_backtrace

  let current ?(max_size=Int.greatest) () =
    OCamlStandard.Printexc.get_callstack max_size

  let to_string = OCamlStandard.Printexc.raw_backtrace_to_string
  
  let repr = to_string  (* @todo Provide a more consise, more structured repr *)

  module Location = struct
    type t = OCamlStandard.Printexc.location = {
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
    type t = OCamlStandard.Printexc.backtrace_slot

    let is_raise = OCamlStandard.Printexc.Slot.is_raise

    let location = OCamlStandard.Printexc.Slot.location

    let format = OCamlStandard.Printexc.Slot.format
  end

  let frames bt =
    match OCamlStandard.Printexc.backtrace_slots bt with
      | None -> [] (*BISECT-IGNORE*) (* Would require compiling without tag debug *)
      | Some frames -> List.of_array frames
end

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/CallStack.ml"

    #include "CallStack.symbols.ml"

    module LocationTests = struct
      #include "../Generated/Atoms/CallStack/Location.ml"

      include Tests_.Make(Location)(struct
        let representations = [
          (
            {Location.filename="Atoms/CallStack.symbols.ml"; line_number=3; start_char=15; end_char=49},
            "{filename=\"Atoms/CallStack.symbols.ml\"; line_number=3; start_char=15; end_char=49}"
          );
        ]
      end)(struct
        let tests = []
      end)
    end

    module FrameTests = struct
      #include "../Generated/Atoms/CallStack/Frame.ml"

      include Tests_.Make(Frame)(struct end)(struct
        open Testing

        let tests = match Testing.context with
          | NodeJs -> []
          | ByteCode ->
            let frame = List.head (frames stack) in
            Frame.[
              "format 0" >: (lazy (check_some_string ~expected:"Raised by primitive operation at file \"Atoms/CallStack.symbols.ml\", line 3, characters 15-27" (format 0 frame)));
              "format 1" >: (lazy (check_some_string ~expected:"Called from file \"Atoms/CallStack.symbols.ml\", line 3, characters 15-27" (format 1 frame)));
              "location" >: (lazy (check_some ~repr:Location.repr ~equal:Location.equal ~expected:{Location.filename="Atoms/CallStack.symbols.ml"; line_number=3; start_char=15; end_char=27} (location frame)))
            ]
          | Native ->
            let frame = List.head (frames stack) in
            Frame.[
              "format 0" >: (lazy (check_some_string ~expected:"Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49" (format 0 frame)));
              "format 1" >: (lazy (check_some_string ~expected:"Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49" (format 1 frame)));
              "location" >: (lazy (check_some ~repr:Location.repr ~equal:Location.equal ~expected:{Location.filename="Atoms/CallStack.ml"; line_number=5; start_char=4; end_char=49} (location frame)))
            ]
      end)
    end

    include Tests_.Make(Basic)(struct
      let conversions_to_string = [
        (
          stack,
          Testing.(match context with
            | NodeJs ->
              ""
            | ByteCode ->
              "Raised by primitive operation at file \"Atoms/CallStack.symbols.ml\", line 3, characters 15-27\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 7, characters 2-9\n\
              Called from unknown location\n\
              Called from unknown location\n"
            | Native ->
              "Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 4, characters 15-36\n\
              Called from file \"Atoms/CallStack.symbols.ml\", line 7, characters 2-9\n"
          )
        );
      ]

      let representations = conversions_to_string
    end)(struct
      open Testing

      let tests = [
        "CallStack: frames" >: (lazy (check_int ~expected:Testing.(match context with | NodeJs -> 0 | ByteCode -> 8 | Native -> 9) (stack |> frames |> List.size)));
        LocationTests.test;
        FrameTests.test;
      ]
    end)
  end
end
