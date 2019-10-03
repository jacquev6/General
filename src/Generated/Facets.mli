module Representable: sig
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

  module Specialize1(M: S1)(A: S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: S0)(B: S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
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

    module Testable: sig
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

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module EquatableBasic: sig
  module type S0 = sig
    type t
    val equal: t -> t -> bool
  end

  module type S1 = sig
    type 'a t
    val equal: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
  end

  module type S2 = sig
    type ('a, 'b) t
    val equal: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
  end

  module Specialize1(M: S1)(A: S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: S0)(B: S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S0 = sig
        type t
        val values: t list
        val equalities: t list list
        val differences: (t * t) list
      end

      module type S1 = sig
        type 'a t
        module A: Element
        val values: A.t t list
        val equalities: A.t t list list
        val differences: (A.t t * A.t t) list
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        val values: (A.t, B.t) t list
        val equalities: (A.t, B.t) t list list
        val differences: ((A.t, B.t) t * (A.t, B.t) t) list
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        val values: (A.t, B.t, C.t) t list
        val equalities: (A.t, B.t, C.t) t list list
        val differences: ((A.t, B.t, C.t) t * (A.t, B.t, C.t) t) list
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        val values: (A.t, B.t, C.t, D.t) t list
        val equalities: (A.t, B.t, C.t, D.t) t list list
        val differences: ((A.t, B.t, C.t, D.t) t * (A.t, B.t, C.t, D.t) t) list
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        val values: (A.t, B.t, C.t, D.t, E.t) t list
        val equalities: (A.t, B.t, C.t, D.t, E.t) t list list
        val differences: ((A.t, B.t, C.t, D.t, E.t) t * (A.t, B.t, C.t, D.t, E.t) t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end

      module type S1 = sig
        include S1
        include Representable.S1 with type 'a t := 'a t
      end

      module type S2 = sig
        include S2
        include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
      end

      module type S3 = sig
        include S3
        include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
      end

      module type S4 = sig
        include S4
        include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
      end

      module type S5 = sig
        include S5
        include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Equatable: sig
  module Operators: sig
    module type S0 = sig
      type t
      val ( = ): t -> t -> bool
      val ( <> ): t -> t -> bool
    end

    module Make0(M: sig
      type t
      val equal: t -> t -> bool
      val different: t -> t -> bool
    end): sig
      val ( = ): M.t -> M.t -> bool
      val ( <> ): M.t -> M.t -> bool
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include EquatableBasic.S0 with type t := t
    val different: t -> t -> bool
  end

  module type S1 = sig
    type 'a t
    include EquatableBasic.S1 with type 'a t := 'a t
    val different: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
  end

  module type S2 = sig
    type ('a, 'b) t
    include EquatableBasic.S2 with type ('a, 'b) t := ('a, 'b) t
    val different: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    include EquatableBasic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    val different: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    include EquatableBasic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    val different: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    include EquatableBasic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    val different: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
  end

  module Specialize1(M: S1)(A: EquatableBasic.S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: EquatableBasic.S0)(B: EquatableBasic.S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: EquatableBasic.S0)(B: EquatableBasic.S0)(C: EquatableBasic.S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: EquatableBasic.S0)(B: EquatableBasic.S0)(C: EquatableBasic.S0)(D: EquatableBasic.S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: EquatableBasic.S0)(B: EquatableBasic.S0)(C: EquatableBasic.S0)(D: EquatableBasic.S0)(E: EquatableBasic.S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Different: sig
    module Make0(M: sig
      type t
      val equal: t -> t -> bool
    end): sig
      val different: M.t -> M.t -> bool
    end

    module Make1(M: sig
      type 'a t
      val equal: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
    end): sig
      val different: 'a M.t -> 'a M.t -> equal_a:('a -> 'a -> bool) -> bool
    end

    module Make2(M: sig
      type ('a, 'b) t
      val equal: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
    end): sig
      val different: ('a, 'b) M.t -> ('a, 'b) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
    end): sig
      val different: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
    end): sig
      val different: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
    end): sig
      val different: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
    end
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S0 = sig
        type t
        include EquatableBasic.Tests.Examples.S0 with type t := t
      end

      module type S1 = sig
        type 'a t
        module A: Element
        include EquatableBasic.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        include EquatableBasic.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        include EquatableBasic.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        include EquatableBasic.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        include EquatableBasic.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end

      module type S1 = sig
        include S1
        include Representable.S1 with type 'a t := 'a t
      end

      module type S2 = sig
        include S2
        include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
      end

      module type S3 = sig
        include S3
        include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
      end

      module type S4 = sig
        include S4
        include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
      end

      module type S5 = sig
        include S5
        include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Displayable: sig
  module type S0 = sig
    type t
    val to_string: t -> string
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val conversions_to_string: (t * string) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Parsable: sig
  module type S0 = sig
    type t
    val try_of_string: string -> t option
    val of_string: string -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val module_name: string
        val conversions_from_string: (string * t) list
        val unconvertible_strings: string list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module ComparableBasic: sig
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

  module Specialize1(M: S1)(A: S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: S0)(B: S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include S0 with type t := t
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S0 = sig
        type t
        val values: t list
        val order_classes: t list list
        val strict_orders: t list list
      end

      module type S1 = sig
        type 'a t
        module A: Element
        val values: A.t t list
        val order_classes: A.t t list list
        val strict_orders: A.t t list list
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        val values: (A.t, B.t) t list
        val order_classes: (A.t, B.t) t list list
        val strict_orders: (A.t, B.t) t list list
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        val values: (A.t, B.t, C.t) t list
        val order_classes: (A.t, B.t, C.t) t list list
        val strict_orders: (A.t, B.t, C.t) t list list
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        val values: (A.t, B.t, C.t, D.t) t list
        val order_classes: (A.t, B.t, C.t, D.t) t list list
        val strict_orders: (A.t, B.t, C.t, D.t) t list list
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        val values: (A.t, B.t, C.t, D.t, E.t) t list
        val order_classes: (A.t, B.t, C.t, D.t, E.t) t list list
        val strict_orders: (A.t, B.t, C.t, D.t, E.t) t list list
      end
    end

    module Testable: sig
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

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Comparable: sig
  module Operators: sig
    module type S0 = sig
      type t
      val ( < ): t -> t -> bool
      val ( <= ): t -> t -> bool
      val ( > ): t -> t -> bool
      val ( >= ): t -> t -> bool
    end

    module Make0(M: sig
      type t
      val less_than: t -> t -> bool
      val less_or_equal: t -> t -> bool
      val greater_than: t -> t -> bool
      val greater_or_equal: t -> t -> bool
    end): sig
      val ( < ): M.t -> M.t -> bool
      val ( <= ): M.t -> M.t -> bool
      val ( > ): M.t -> M.t -> bool
      val ( >= ): M.t -> M.t -> bool
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include ComparableBasic.S0 with type t := t
    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool
    val between: t -> low:(t) -> high:(t) -> bool
    val between_or_equal: t -> low:(t) -> high:(t) -> bool
    val min: t -> t -> t
    val max: t -> t -> t
    val min_max: t -> t -> t * t
  end

  module type S1 = sig
    type 'a t
    include ComparableBasic.S1 with type 'a t := 'a t
    val less_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val less_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val greater_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val greater_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val between: 'a t -> low:('a t) -> high:('a t) -> compare_a:('a -> 'a -> Compare.t) -> bool
    val between_or_equal: 'a t -> low:('a t) -> high:('a t) -> compare_a:('a -> 'a -> Compare.t) -> bool
    val min: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t
    val max: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t
    val min_max: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t * 'a t
  end

  module type S2 = sig
    type ('a, 'b) t
    include ComparableBasic.S2 with type ('a, 'b) t := ('a, 'b) t
    val less_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val less_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val greater_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val between: ('a, 'b) t -> low:(('a, 'b) t) -> high:(('a, 'b) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val between_or_equal: ('a, 'b) t -> low:(('a, 'b) t) -> high:(('a, 'b) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val min: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t
    val max: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t
    val min_max: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t * ('a, 'b) t
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    include ComparableBasic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val between: ('a, 'b, 'c) t -> low:(('a, 'b, 'c) t) -> high:(('a, 'b, 'c) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val between_or_equal: ('a, 'b, 'c) t -> low:(('a, 'b, 'c) t) -> high:(('a, 'b, 'c) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val min: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t
    val max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t
    val min_max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t * ('a, 'b, 'c) t
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    include ComparableBasic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val between: ('a, 'b, 'c, 'd) t -> low:(('a, 'b, 'c, 'd) t) -> high:(('a, 'b, 'c, 'd) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val between_or_equal: ('a, 'b, 'c, 'd) t -> low:(('a, 'b, 'c, 'd) t) -> high:(('a, 'b, 'c, 'd) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val min: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t
    val max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t
    val min_max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t * ('a, 'b, 'c, 'd) t
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    include ComparableBasic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val between: ('a, 'b, 'c, 'd, 'e) t -> low:(('a, 'b, 'c, 'd, 'e) t) -> high:(('a, 'b, 'c, 'd, 'e) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val between_or_equal: ('a, 'b, 'c, 'd, 'e) t -> low:(('a, 'b, 'c, 'd, 'e) t) -> high:(('a, 'b, 'c, 'd, 'e) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val min: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t
    val max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t
    val min_max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t * ('a, 'b, 'c, 'd, 'e) t
  end

  module Specialize1(M: S1)(A: ComparableBasic.S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: ComparableBasic.S0)(B: ComparableBasic.S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: ComparableBasic.S0)(B: ComparableBasic.S0)(C: ComparableBasic.S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: ComparableBasic.S0)(B: ComparableBasic.S0)(C: ComparableBasic.S0)(D: ComparableBasic.S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: ComparableBasic.S0)(B: ComparableBasic.S0)(C: ComparableBasic.S0)(D: ComparableBasic.S0)(E: ComparableBasic.S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module GreaterLessThan: sig
    module Make0(M: sig
      type t
      val compare: t -> t -> Compare.t
    end): sig
      val less_than: M.t -> M.t -> bool
      val less_or_equal: M.t -> M.t -> bool
      val greater_than: M.t -> M.t -> bool
      val greater_or_equal: M.t -> M.t -> bool
    end

    module Make1(M: sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end): sig
      val less_than: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val less_or_equal: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_than: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_or_equal: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
    end

    module Make2(M: sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val less_or_equal: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_than: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end
  end

  module Between: sig
    module Make0(M: sig
      type t
      val less_than: t -> t -> bool
      val less_or_equal: t -> t -> bool
      val greater_than: t -> t -> bool
      val greater_or_equal: t -> t -> bool
    end): sig
      val between: M.t -> low:(M.t) -> high:(M.t) -> bool
      val between_or_equal: M.t -> low:(M.t) -> high:(M.t) -> bool
    end

    module Make1(M: sig
      type 'a t
      val less_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val less_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    end): sig
      val between: 'a M.t -> low:('a M.t) -> high:('a M.t) -> compare_a:('a -> 'a -> Compare.t) -> bool
      val between_or_equal: 'a M.t -> low:('a M.t) -> high:('a M.t) -> compare_a:('a -> 'a -> Compare.t) -> bool
    end

    module Make2(M: sig
      type ('a, 'b) t
      val less_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val less_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b) M.t -> low:(('a, 'b) M.t) -> high:(('a, 'b) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val between_or_equal: ('a, 'b) M.t -> low:(('a, 'b) M.t) -> high:(('a, 'b) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b, 'c) M.t -> low:(('a, 'b, 'c) M.t) -> high:(('a, 'b, 'c) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val between_or_equal: ('a, 'b, 'c) M.t -> low:(('a, 'b, 'c) M.t) -> high:(('a, 'b, 'c) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b, 'c, 'd) M.t -> low:(('a, 'b, 'c, 'd) M.t) -> high:(('a, 'b, 'c, 'd) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val between_or_equal: ('a, 'b, 'c, 'd) M.t -> low:(('a, 'b, 'c, 'd) M.t) -> high:(('a, 'b, 'c, 'd) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b, 'c, 'd, 'e) M.t -> low:(('a, 'b, 'c, 'd, 'e) M.t) -> high:(('a, 'b, 'c, 'd, 'e) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val between_or_equal: ('a, 'b, 'c, 'd, 'e) M.t -> low:(('a, 'b, 'c, 'd, 'e) M.t) -> high:(('a, 'b, 'c, 'd, 'e) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end
  end

  module MinMax: sig
    module Make0(M: sig
      type t
      val compare: t -> t -> Compare.t
    end): sig
      val min: M.t -> M.t -> M.t
      val max: M.t -> M.t -> M.t
      val min_max: M.t -> M.t -> M.t * M.t
    end

    module Make1(M: sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end): sig
      val min: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> 'a M.t
      val max: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> 'a M.t
      val min_max: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> 'a M.t * 'a M.t
    end

    module Make2(M: sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) M.t
      val max: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) M.t
      val min_max: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) M.t * ('a, 'b) M.t
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) M.t
      val max: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) M.t
      val min_max: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) M.t * ('a, 'b, 'c) M.t
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) M.t
      val max: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) M.t
      val min_max: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) M.t * ('a, 'b, 'c, 'd) M.t
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) M.t
      val max: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) M.t
      val min_max: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) M.t * ('a, 'b, 'c, 'd, 'e) M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include ComparableBasic.S0 with type t := t
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S0 = sig
        type t
        include ComparableBasic.Tests.Examples.S0 with type t := t
      end

      module type S1 = sig
        type 'a t
        module A: Element
        include ComparableBasic.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        include ComparableBasic.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        include ComparableBasic.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        include ComparableBasic.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        include ComparableBasic.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      end
    end

    module Testable: sig
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

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module RingoidBasic: sig
  module type S0 = sig
    type t
    val zero: t
    val one: t
    val negate: t -> t
    val add: t -> t -> t
    val subtract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t
  end

  module Subtract: sig
    module Make0(M: sig
      type t
      val negate: t -> t
      val add: t -> t -> t
    end): sig
      val subtract: M.t -> M.t -> M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val values: t list
        val additions: (t * t * t) list
        val negations: (t * t) list
        val multiplications: (t * t * t) list
        val divisions: (t * t * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Ringoid: sig
  module Operators: sig
    module type S0 = sig
      type t
      val ( ~- ): t -> t
      val ( + ): t -> t -> t
      val ( - ): t -> t -> t
      val ( * ): t -> t -> t
      val ( / ): t -> t -> t
      val ( ** ): t -> int -> t
    end

    module Make0(M: sig
      type t
      val negate: t -> t
      val add: t -> t -> t
      val subtract: t -> t -> t
      val multiply: t -> t -> t
      val divide: t -> t -> t
      val exponentiate: t -> int -> t
    end): sig
      val ( ~- ): M.t -> M.t
      val ( + ): M.t -> M.t -> M.t
      val ( - ): M.t -> M.t -> M.t
      val ( * ): M.t -> M.t -> M.t
      val ( / ): M.t -> M.t -> M.t
      val ( ** ): M.t -> int -> M.t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include RingoidBasic.S0 with type t := t
    val square: t -> t
    val exponentiate: t -> int -> t
  end

  module Square: sig
    module Make0(M: sig
      type t
      val multiply: t -> t -> t
    end): sig
      val square: M.t -> M.t
    end
  end

  module Exponentiate: sig
    module Make0(M: sig
      type t
      val one: t
      val square: t -> t
      val multiply: t -> t -> t
      val exponentiate_negative_exponent: exponentiate:(t -> int -> t) -> t -> int -> t
    end): sig
      val exponentiate: M.t -> int -> M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include RingoidBasic.Tests.Examples.S0 with type t := t
        val exponentiations: (t * int * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module OfInt: sig
  module type S0 = sig
    type t
    val of_int: int -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val conversions_from_int: (int * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module ToInt: sig
  module type S0 = sig
    type t
    val to_int: t -> int
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val conversions_to_int: (t * int) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module OfFloat: sig
  module type S0 = sig
    type t
    val of_float: float -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val conversions_from_float: (float * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module ToFloat: sig
  module type S0 = sig
    type t
    val to_float: t -> float
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val conversions_to_float: (t * float) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module PredSucc: sig
  module type S0 = sig
    type t
    val pred: t -> t
    val succ: t -> t
  end

  module PredSucc: sig
    module Make0(M: sig
      type t
      val one: t
      val add: t -> t -> t
      val subtract: t -> t -> t
    end): sig
      val pred: M.t -> M.t
      val succ: M.t -> M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val successions: (t * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Bounded: sig
  module type S0 = sig
    type t
    val smallest: t
    val greatest: t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Bitwise: sig
  module type S0 = sig
    type t
    module Bitwise: sig
      val logical_and: t -> t -> t
      val logical_or: t -> t -> t
      val logical_xor: t -> t -> t
      val logical_not: t -> t
      val logical_shift_left: t -> shift:(int) -> t
      val logical_shift_right: t -> shift:(int) -> t
      val arithmetic_shift_right: t -> shift:(int) -> t
    end
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Identifiable: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Equatable.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Equatable.S0 with type t := t and module O := O
    include Representable.S0 with type t := t
  end

  module type S1 = sig
    type 'a t
    include Equatable.S1 with type 'a t := 'a t
    include Representable.S1 with type 'a t := 'a t
  end

  module type S2 = sig
    type ('a, 'b) t
    include Equatable.S2 with type ('a, 'b) t := ('a, 'b) t
    include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    include Equatable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    include Equatable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    include Equatable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end

  module Specialize1(M: S1)(A: S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: S0)(B: S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include S0 with type t := t
      end

      module type S0 = sig
        type t
        include Equatable.Tests.Examples.S0 with type t := t
        include Representable.Tests.Examples.S0 with type t := t
      end

      module type S1 = sig
        type 'a t
        module A: Element
        include Equatable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
        include Representable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        include Equatable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
        include Representable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        include Equatable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
        include Representable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        include Equatable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
        include Representable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        include Equatable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
        include Representable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      end
    end

    module Testable: sig
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

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Able: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Identifiable.Operators.S0 with type t := t
      include Comparable.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Identifiable.S0 with type t := t and module O := O
    include Comparable.S0 with type t := t and module O := O
  end

  module type S1 = sig
    type 'a t
    include Identifiable.S1 with type 'a t := 'a t
    include Comparable.S1 with type 'a t := 'a t
  end

  module type S2 = sig
    type ('a, 'b) t
    include Identifiable.S2 with type ('a, 'b) t := ('a, 'b) t
    include Comparable.S2 with type ('a, 'b) t := ('a, 'b) t
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    include Identifiable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Comparable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    include Identifiable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Comparable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    include Identifiable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Comparable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end

  module Specialize1(M: S1)(A: S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: S0)(B: S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include S0 with type t := t
      end

      module type S0 = sig
        type t
        include Identifiable.Tests.Examples.S0 with type t := t
        include Comparable.Tests.Examples.S0 with type t := t
      end

      module type S1 = sig
        type 'a t
        module A: Element
        include Identifiable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
        include Comparable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        include Identifiable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
        include Comparable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        include Identifiable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
        include Comparable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        include Identifiable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
        include Comparable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        include Identifiable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
        include Comparable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      end
    end

    module Testable: sig
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

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Stringable: sig
  module type S0 = sig
    type t
    include Displayable.S0 with type t := t
    include Parsable.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Displayable.Tests.Examples.S0 with type t := t
        include Parsable.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
        include EquatableBasic.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module OfStandardNumber: sig
  module type S0 = sig
    type t
    include OfInt.S0 with type t := t
    include OfFloat.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include OfInt.Tests.Examples.S0 with type t := t
        include OfFloat.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include EquatableBasic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Number: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Identifiable.Operators.S0 with type t := t
      include Ringoid.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Identifiable.S0 with type t := t and module O := O
    include Stringable.S0 with type t := t
    include Ringoid.S0 with type t := t and module O := O
    include OfStandardNumber.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Identifiable.Tests.Examples.S0 with type t := t
        include Stringable.Tests.Examples.S0 with type t := t
        include Ringoid.Tests.Examples.S0 with type t := t
        include OfStandardNumber.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module ToStandardNumber: sig
  module type S0 = sig
    type t
    include ToInt.S0 with type t := t
    include ToFloat.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include ToInt.Tests.Examples.S0 with type t := t
        include ToFloat.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module RealNumber: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Number.Operators.S0 with type t := t
      include Comparable.Operators.S0 with type t := t
      val ( mod ): t -> t -> t
    end

    module Make0(M: sig
      type t
      val modulo: t -> t -> t
    end): sig
      val ( mod ): M.t -> M.t -> M.t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Number.S0 with type t := t and module O := O
    include Comparable.S0 with type t := t and module O := O
    include ToStandardNumber.S0 with type t := t
    val abs: t -> t
    val modulo: t -> t -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Number.Tests.Examples.S0 with type t := t
        include Comparable.Tests.Examples.S0 with type t := t
        include ToStandardNumber.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Integer: sig
  module Operators: sig
    module type S0 = sig
      type t
      include RealNumber.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include RealNumber.S0 with type t := t and module O := O
    include PredSucc.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include RealNumber.Tests.Examples.S0 with type t := t
        include PredSucc.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module FixedWidthInteger: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Integer.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Integer.S0 with type t := t and module O := O
    include Bounded.S0 with type t := t
    include Bitwise.S0 with type t := t
    val width: int
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Integer.Tests.Examples.S0 with type t := t
        include Bounded.Tests.Examples.S0 with type t := t
        include Bitwise.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end
