open Foundations

(* Representation: a string representing the object for a software developer audience.
When possible, it should a valid OCaml expression representing the value. *)

module Basic = struct
  module type S0 = sig
    type t

    val repr: t
      -> string
  end

  module type S1 = sig
    type 'a t

    val repr: 'a t
      -> repr_a:('a -> string)
      -> string
  end

  module type S2 = sig
    type ('a, 'b) t

    val repr: ('a, 'b) t
      -> repr_a:('a -> string)
      -> repr_b:('b -> string)
      -> string
  end

  module type S3 = sig
    type ('a, 'b, 'c) t

    val repr: ('a, 'b, 'c) t
      -> repr_a:('a -> string)
      -> repr_b:('b -> string)
      -> repr_c:('c -> string)
      -> string
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t

    val repr: ('a, 'b, 'c, 'd) t
      -> repr_a:('a -> string)
      -> repr_b:('b -> string)
      -> repr_c:('c -> string)
      -> repr_d:('d -> string)
      -> string
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t

    val repr: ('a, 'b, 'c, 'd, 'e) t
      -> repr_a:('a -> string)
      -> repr_b:('b -> string)
      -> repr_c:('c -> string)
      -> repr_d:('d -> string)
      -> repr_e:('e -> string)
      -> string
  end

  module Specialize1(M: S1)(A: S0): S0 with type t = A.t M.t = struct
    type t = A.t M.t

    let repr x =
      M.repr x ~repr_a:A.repr
  end

  module Specialize2(M: S2)(A: S0)(B: S0): S0 with type t = (A.t, B.t) M.t = struct
    type t = (A.t, B.t) M.t

    let repr x =
      M.repr x ~repr_a:A.repr ~repr_b:B.repr
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
    type t = (A.t, B.t, C.t) M.t

    let repr x =
      M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t) M.t

    let repr x =
      M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t

    let repr x =
      M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr ~repr_e:E.repr
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
      module A: Basic.S0

      type 'a t

      val repr: (A.t t * string) list
    end

    module type S2 = sig
      module A: Basic.S0
      module B: Basic.S0

      type ('a, 'b) t

      val repr: ((A.t, B.t) t * string) list
    end

    module type S3 = sig
      module A: Basic.S0
      module B: Basic.S0
      module C: Basic.S0

      type ('a, 'b, 'c) t

      val repr: ((A.t, B.t, C.t) t * string) list
    end

    module type S4 = sig
      module A: Basic.S0
      module B: Basic.S0
      module C: Basic.S0
      module D: Basic.S0

      type ('a, 'b, 'c, 'd) t

      val repr: ((A.t, B.t, C.t, D.t) t * string) list
    end

    module type S5 = sig
      module A: Basic.S0
      module B: Basic.S0
      module C: Basic.S0
      module D: Basic.S0
      module E: Basic.S0

      type ('a, 'b, 'c, 'd, 'e) t

      val repr: ((A.t, B.t, C.t, D.t, E.t) t * string) list
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

  module Make1(M: S1)(E: Examples.S1 with type 'a t := 'a M.t) =
    Make0(Specialize1(M)(E.A))(E)

  module Make2(M: S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) =
    Make0(Specialize2(M)(E.A)(E.B))(E)

  module Make3(M: S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) =
    Make0(Specialize3(M)(E.A)(E.B)(E.C))(E)

  module Make4(M: S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) =
    Make0(Specialize4(M)(E.A)(E.B)(E.C)(E.D))(E)

  module Make5(M: S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) =
    Make0(Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E))(E)
end
