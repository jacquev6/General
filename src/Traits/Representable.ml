module type S0 = sig
  type t

  (** Representation: a string representing the object for a software developer audience.
  When possible, it should a valid OCaml expression representing the value. **)
  val repr: t -> string
end

module Examples = struct
  module type S0 = sig
    type t

    val repr: (t * string) list
  end
end

module Tests = struct
  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open StdLabels

    open M

    let test = "Representable" >:: (
      E.repr
      |> List.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (repr v)))
      )
    )
  end
end
