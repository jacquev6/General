module type S0 = sig
  type t

  (** Representation: a string representing the object for a software developer audience.
  When possible, it should a valid OCaml expression representing the value. **)
  val repr: t -> string
end

module Testable = struct
  module type S0 = sig
    include S0

    val representation_examples: (t * string) list
  end
end

module Tests = struct
  module Make0(T: Testable.S0) = struct
    open T
    open Testing
    open StdLabels

    let test = "Representable" >:: (
      representation_examples
      |> List.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (repr v)))
      )
    )
  end
end