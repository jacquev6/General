module type S0 = sig
  type t
  val repr: t -> string
end

module type S1 = sig
  type 'a t
  val repr: 'a t -> repr_a:('a -> string) -> string
end

module type S2 = sig
  type ('a, 'b) t
  val repr: ('a, 'b) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> string
end

module type S3 = sig
  type ('a, 'b, 'c) t
  val repr: ('a, 'b, 'c) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> string
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t
  val repr: ('a, 'b, 'c, 'd) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> repr_d:('d -> string) -> string
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t
  val repr: ('a, 'b, 'c, 'd, 'e) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> repr_d:('d -> string) -> repr_e:('e -> string) -> string
end

module Specialize1(M: S1)(A: S0) = struct
  type t = A.t M.t
  let repr x = M.repr x ~repr_a:A.repr
end

module Specialize2(M: S2)(A: S0)(B: S0) = struct
  type t = (A.t, B.t) M.t
  let repr x = M.repr x ~repr_a:A.repr ~repr_b:B.repr
end

module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
  type t = (A.t, B.t, C.t) M.t
  let repr x = M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr
end

module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
  type t = (A.t, B.t, C.t, D.t) M.t
  let repr x = M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr
end

module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
  type t = (A.t, B.t, C.t, D.t, E.t) M.t
  let repr x = M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr ~repr_e:E.repr
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type Element = sig
      type t
      include S0 with type t := t
    end

    module type S0 = sig
      type t
      val representations: (t * string) list
    end

    module type S1 = sig
      type 'a t
      module A: Element
      val representations: (A.t t * string) list
    end

    module type S2 = sig
      type ('a, 'b) t
      module A: Element
      module B: Element
      val representations: ((A.t, B.t) t * string) list
    end

    module type S3 = sig
      type ('a, 'b, 'c) t
      module A: Element
      module B: Element
      module C: Element
      val representations: ((A.t, B.t, C.t) t * string) list
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      val representations: ((A.t, B.t, C.t, D.t) t * string) list
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element
      val representations: ((A.t, B.t, C.t, D.t, E.t) t * string) list
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
    end

    module type S1 = sig
      include S1
    end

    module type S2 = sig
      include S2
    end

    module type S3 = sig
      include S3
    end

    module type S4 = sig
      include S4
    end

    module type S5 = sig
      include S5
    end
  end

  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "Representable" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
      include Make0(struct
        include Specialize1(M)(E.A)
      end)(E)
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
      include Make0(struct
        include Specialize2(M)(E.A)(E.B)
      end)(E)
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
      include Make0(struct
        include Specialize3(M)(E.A)(E.B)(E.C)
      end)(E)
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
      include Make0(struct
        include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
      end)(E)
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
      include Make0(struct
        include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
      end)(E)
    end
  end
end
