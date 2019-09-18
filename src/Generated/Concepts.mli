module Identifiable: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Traits.Equatable.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Traits.Equatable.S0 with type t := t and module O := O
    include Traits.Representable.S0 with type t := t
  end

  module type S1 = sig
    type 'a t
    include Traits.Equatable.S1 with type 'a t := 'a t
    include Traits.Representable.S1 with type 'a t := 'a t
  end

  module type S2 = sig
    type ('a, 'b) t
    include Traits.Equatable.S2 with type ('a, 'b) t := ('a, 'b) t
    include Traits.Representable.S2 with type ('a, 'b) t := ('a, 'b) t
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    include Traits.Equatable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Traits.Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    include Traits.Equatable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Traits.Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    include Traits.Equatable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Traits.Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
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
        include Traits.Equatable.Tests.Examples.S0 with type t := t
        include Traits.Representable.Tests.Examples.S0 with type t := t
      end

      module type S1 = sig
        type 'a t
        module A: Element
        include Traits.Equatable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
        include Traits.Representable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        include Traits.Equatable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
        include Traits.Representable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        include Traits.Equatable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
        include Traits.Representable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        include Traits.Equatable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
        include Traits.Representable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        include Traits.Equatable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
        include Traits.Representable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
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
      include Traits.Comparable.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Identifiable.S0 with type t := t and module O := O
    include Traits.Comparable.S0 with type t := t and module O := O
  end

  module type S1 = sig
    type 'a t
    include Identifiable.S1 with type 'a t := 'a t
    include Traits.Comparable.S1 with type 'a t := 'a t
  end

  module type S2 = sig
    type ('a, 'b) t
    include Identifiable.S2 with type ('a, 'b) t := ('a, 'b) t
    include Traits.Comparable.S2 with type ('a, 'b) t := ('a, 'b) t
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    include Identifiable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Traits.Comparable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    include Identifiable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Traits.Comparable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    include Identifiable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Traits.Comparable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
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
        include Traits.Comparable.Tests.Examples.S0 with type t := t
      end

      module type S1 = sig
        type 'a t
        module A: Element
        include Identifiable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
        include Traits.Comparable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        include Identifiable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
        include Traits.Comparable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        include Identifiable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
        include Traits.Comparable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        include Identifiable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
        include Traits.Comparable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        include Identifiable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
        include Traits.Comparable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
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
    include Traits.Displayable.S0 with type t := t
    include Traits.Parsable.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Traits.Displayable.Tests.Examples.S0 with type t := t
        include Traits.Parsable.Tests.Examples.S0 with type t := t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Traits.Representable.S0 with type t := t
        include Traits.Equatable.Basic.S0 with type t := t
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
    include Traits.OfInt.S0 with type t := t
    include Traits.OfFloat.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Traits.OfInt.Tests.Examples.S0 with type t := t
        include Traits.OfFloat.Tests.Examples.S0 with type t := t
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

module Number: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Identifiable.Operators.S0 with type t := t
      include Traits.Ringoid.Operators.S0 with type t := t
    end
  end

  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Identifiable.S0 with type t := t and module O := O
    include Stringable.S0 with type t := t
    include Traits.Ringoid.S0 with type t := t and module O := O
    include OfStandardNumber.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Identifiable.Tests.Examples.S0 with type t := t
        include Stringable.Tests.Examples.S0 with type t := t
        include Traits.Ringoid.Tests.Examples.S0 with type t := t
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
    include Traits.ToInt.S0 with type t := t
    include Traits.ToFloat.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Traits.ToInt.Tests.Examples.S0 with type t := t
        include Traits.ToFloat.Tests.Examples.S0 with type t := t
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

module RealNumber: sig
  module Operators: sig
    module type S0 = sig
      type t
      include Number.Operators.S0 with type t := t
      include Traits.Comparable.Operators.S0 with type t := t
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
    include Traits.Comparable.S0 with type t := t and module O := O
    include ToStandardNumber.S0 with type t := t
    val abs: t -> t
    val modulo: t -> t -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Number.Tests.Examples.S0 with type t := t
        include Traits.Comparable.Tests.Examples.S0 with type t := t
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
    include Traits.PredSucc.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include RealNumber.Tests.Examples.S0 with type t := t
        include Traits.PredSucc.Tests.Examples.S0 with type t := t
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
    include Traits.Bounded.S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        include Integer.Tests.Examples.S0 with type t := t
        include Traits.Bounded.Tests.Examples.S0 with type t := t
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
