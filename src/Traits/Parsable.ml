open Foundations

module Basic = struct
  module type S0 = sig
    type t

    val try_of_string: string -> t option
    val of_string: string -> t
  end
end

include Basic

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val of_string: (string * t) list
    end
  end

  module Make0(M: sig
    include S0
    include Equatable.Basic.S0 with type t := t
    include Representable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Parsable" >:: (
      E.of_string
      |> List_.concat_map ~f:(fun (s, expected) ->
        [
          ~: "of_string %S" s (lazy (check ~repr ~equal ~expected (of_string s)));
          ~: "try_of_string %S" s (lazy (check_some ~repr ~equal ~expected (try_of_string s)));
        ]
      )
    )
  end
end
