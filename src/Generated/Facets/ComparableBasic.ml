module type S0 = sig
  type t
  val compare: t -> t -> Compare.t
end

module type S1 = sig
  type 'a t
  val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
end

module type S2 = sig
  type ('a, 'b) t
  val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
end

module type S3 = sig
  type ('a, 'b, 'c) t
  val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t
  val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t
  val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
end

module Specialize1(M: S1)(A: S0) = struct
  type t = A.t M.t
  let compare x y = M.compare x y ~compare_a:A.compare
end

module Specialize2(M: S2)(A: S0)(B: S0) = struct
  type t = (A.t, B.t) M.t
  let compare x y = M.compare x y ~compare_a:A.compare ~compare_b:B.compare
end

module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
  type t = (A.t, B.t, C.t) M.t
  let compare x y = M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
end

module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
  type t = (A.t, B.t, C.t, D.t) M.t
  let compare x y = M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
end

module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
  type t = (A.t, B.t, C.t, D.t, E.t) M.t
  let compare x y = M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type Element = sig
      type t
      include S0 with type t := t
      include EquatableBasic.S0 with type t := t
      include Representable.S0 with type t := t
    end

    module type S0 = sig
      type t
      val orders: t list list
      val equalities: t list list
    end

    module type S1 = sig
      type 'a t
      module A: Element
      val orders: A.t t list list
      val equalities: A.t t list list
    end

    module type S2 = sig
      type ('a, 'b) t
      module A: Element
      module B: Element
      val orders: (A.t, B.t) t list list
      val equalities: (A.t, B.t) t list list
    end

    module type S3 = sig
      type ('a, 'b, 'c) t
      module A: Element
      module B: Element
      module C: Element
      val orders: (A.t, B.t, C.t) t list list
      val equalities: (A.t, B.t, C.t) t list list
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      val orders: (A.t, B.t, C.t, D.t) t list list
      val equalities: (A.t, B.t, C.t, D.t) t list list
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element
      val orders: (A.t, B.t, C.t, D.t, E.t) t list list
      val equalities: (A.t, B.t, C.t, D.t, E.t) t list list
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
      include EquatableBasic.S0 with type t := t
      include Representable.S0 with type t := t
    end

    module type S1 = sig
      include S1
      include EquatableBasic.S1 with type 'a t := 'a t
      include Representable.S1 with type 'a t := 'a t
    end

    module type S2 = sig
      include S2
      include EquatableBasic.S2 with type ('a, 'b) t := ('a, 'b) t
      include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
    end

    module type S3 = sig
      include S3
      include EquatableBasic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
      include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    end

    module type S4 = sig
      include S4
      include EquatableBasic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
      include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    end

    module type S5 = sig
      include S5
      include EquatableBasic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
      include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    end
  end

  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "ComparableBasic" >:: [
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
      include Make0(struct
        include Specialize1(M)(E.A)
        include (EquatableBasic.Specialize1(M)(E.A): EquatableBasic.S0 with type t := t)
        include (Representable.Specialize1(M)(E.A): Representable.S0 with type t := t)
      end)(E)
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
      include Make0(struct
        include Specialize2(M)(E.A)(E.B)
        include (EquatableBasic.Specialize2(M)(E.A)(E.B): EquatableBasic.S0 with type t := t)
        include (Representable.Specialize2(M)(E.A)(E.B): Representable.S0 with type t := t)
      end)(E)
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
      include Make0(struct
        include Specialize3(M)(E.A)(E.B)(E.C)
        include (EquatableBasic.Specialize3(M)(E.A)(E.B)(E.C): EquatableBasic.S0 with type t := t)
        include (Representable.Specialize3(M)(E.A)(E.B)(E.C): Representable.S0 with type t := t)
      end)(E)
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
      include Make0(struct
        include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
        include (EquatableBasic.Specialize4(M)(E.A)(E.B)(E.C)(E.D): EquatableBasic.S0 with type t := t)
        include (Representable.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Representable.S0 with type t := t)
      end)(E)
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
      include Make0(struct
        include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
        include (EquatableBasic.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): EquatableBasic.S0 with type t := t)
        include (Representable.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Representable.S0 with type t := t)
      end)(E)
    end
  end
end
