module type S0 = sig
  type t

  (** Representation: a string representing the object for a software developer audience.
  When possible, it should a valid OCaml expression representing the value. **)
  val repr: t -> string
end

module Tests = struct
  module Make0(M: sig
    include S0

    val representation_examples: (t * string) list
  end) = struct
    open M
    open Testing
    open StdLabels

    let test = "Representable" >::: (
      representation_examples
      |> List.map ~f:(fun (v, expected) ->
        (Printf.sprintf "repr %s" expected) >:: (fun () -> check_string ~expected (repr v))
      )
    )
  end
end
