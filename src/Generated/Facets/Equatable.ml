module Operators = struct
  module type S0 = sig
    type t
    val ( = ): t -> t -> bool
    val ( <> ): t -> t -> bool
  end

  module Make0(M: sig
    type t
    val equal: t -> t -> bool
    val different: t -> t -> bool
  end) = struct
    let ( = ) = M.equal
    let ( <> ) = M.different
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

module Specialize1(M: S1)(A: EquatableBasic.S0) = struct
  module Self = struct
    type t = A.t M.t
    module EquatableBasic_ = EquatableBasic.Specialize1(M)(A)
    include (EquatableBasic_: EquatableBasic.S0 with type t := t)
    let different x y = M.different x y ~equal_a:A.equal
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize2(M: S2)(A: EquatableBasic.S0)(B: EquatableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t) M.t
    module EquatableBasic_ = EquatableBasic.Specialize2(M)(A)(B)
    include (EquatableBasic_: EquatableBasic.S0 with type t := t)
    let different x y = M.different x y ~equal_a:A.equal ~equal_b:B.equal
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize3(M: S3)(A: EquatableBasic.S0)(B: EquatableBasic.S0)(C: EquatableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t, C.t) M.t
    module EquatableBasic_ = EquatableBasic.Specialize3(M)(A)(B)(C)
    include (EquatableBasic_: EquatableBasic.S0 with type t := t)
    let different x y = M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize4(M: S4)(A: EquatableBasic.S0)(B: EquatableBasic.S0)(C: EquatableBasic.S0)(D: EquatableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t, C.t, D.t) M.t
    module EquatableBasic_ = EquatableBasic.Specialize4(M)(A)(B)(C)(D)
    include (EquatableBasic_: EquatableBasic.S0 with type t := t)
    let different x y = M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize5(M: S5)(A: EquatableBasic.S0)(B: EquatableBasic.S0)(C: EquatableBasic.S0)(D: EquatableBasic.S0)(E: EquatableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    module EquatableBasic_ = EquatableBasic.Specialize5(M)(A)(B)(C)(D)(E)
    include (EquatableBasic_: EquatableBasic.S0 with type t := t)
    let different x y = M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal ~equal_e:E.equal
  end

  module O = Operators.Make0(Self)
  include Self
end

module Different_ = struct
  module MakeMakers(Implementation: sig
    val different: equal:('a -> 'a -> bool) -> 'a -> 'a -> bool
  end) = struct
    module Make0(M: sig
      type t
      val equal: t -> t -> bool
    end) = struct
      let different x y = Implementation.different ~equal:(M.equal) x y
    end

    module Make1(M: sig
      type 'a t
      val equal: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
    end) = struct
      let different x y ~equal_a = Implementation.different ~equal:(M.equal ~equal_a) x y
    end

    module Make2(M: sig
      type ('a, 'b) t
      val equal: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
    end) = struct
      let different x y ~equal_a ~equal_b = Implementation.different ~equal:(M.equal ~equal_a ~equal_b) x y
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
    end) = struct
      let different x y ~equal_a ~equal_b ~equal_c = Implementation.different ~equal:(M.equal ~equal_a ~equal_b ~equal_c) x y
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
    end) = struct
      let different x y ~equal_a ~equal_b ~equal_c ~equal_d = Implementation.different ~equal:(M.equal ~equal_a ~equal_b ~equal_c ~equal_d) x y
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
    end) = struct
      let different x y ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e = Implementation.different ~equal:(M.equal ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e) x y
    end
  end
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type Element = sig
      type t
      include EquatableBasic.S0 with type t := t
      include Representable.S0 with type t := t
    end

    module type S0 = sig
      type t
      include EquatableBasic.Tests_beta(Testing).Examples.S0 with type t := t
    end

    module type S1 = sig
      type 'a t
      module A: Element
      include EquatableBasic.Tests_beta(Testing).Examples.S1 with type 'a t := 'a t and module A := A
    end

    module type S2 = sig
      type ('a, 'b) t
      module A: Element
      module B: Element
      include EquatableBasic.Tests_beta(Testing).Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
    end

    module type S3 = sig
      type ('a, 'b, 'c) t
      module A: Element
      module B: Element
      module C: Element
      include EquatableBasic.Tests_beta(Testing).Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      include EquatableBasic.Tests_beta(Testing).Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element
      include EquatableBasic.Tests_beta(Testing).Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
    end
  end

  module Testable = struct
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

  module MakeMakers(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      let test = "Equatable" >:: [
        (let module T_alpha = EquatableBasic.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
      include Make0(struct
        include Specialize1(M)(E.A)
        include (Representable.Specialize1(M)(E.A): Representable.S0 with type t := t)
      end)(E)
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
      include Make0(struct
        include Specialize2(M)(E.A)(E.B)
        include (Representable.Specialize2(M)(E.A)(E.B): Representable.S0 with type t := t)
      end)(E)
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
      include Make0(struct
        include Specialize3(M)(E.A)(E.B)(E.C)
        include (Representable.Specialize3(M)(E.A)(E.B)(E.C): Representable.S0 with type t := t)
      end)(E)
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
      include Make0(struct
        include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
        include (Representable.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Representable.S0 with type t := t)
      end)(E)
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
      include Make0(struct
        include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
        include (Representable.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Representable.S0 with type t := t)
      end)(E)
    end
  end
end
