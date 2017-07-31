open Foundations

module Basic = struct
  module type S0 = sig
    type t

    (** Representation: a string representing the object for a software developer audience.
    When possible, it should a valid OCaml expression representing the value. **)
    val repr: t -> string
  end

  module type S1 = sig
    type 'a t

    val repr: 'a t -> repr:('a -> string) -> string
  end
end

include Basic

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val repr: (t * string) list
    end

    module type S1 = sig
      module Element: Basic.S0

      type 'a t

      val repr: (Element.t t * string) list
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Representable" >:: (
      E.repr
      |> List_.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (repr v)))
      )
    )
  end

  module Make1(M: S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
    open M

    let test = "Representable" >:: (
      E.repr
      |> List_.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (repr ~repr:E.Element.repr v)))
      )
    )
  end
end
