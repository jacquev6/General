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
module Basic = struct
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
  module Specialize1(M: S1)(A: S0) = struct
    type t = A.t M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal
  end
  module Specialize2(M: S2)(A: S0)(B: S0) = struct
    type t = (A.t, B.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal
  end
  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
    type t = (A.t, B.t, C.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal
  end
  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
    type t = (A.t, B.t, C.t, D.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal
  end
  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal ~equal_e:E.equal
  end
end
module type S0 = sig
  include Basic.S0
  module O: Operators.S0 with type t := t
  val different: t -> t -> bool
end
module type S1 = sig
  include Basic.S1
  val different: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
end
module type S2 = sig
  include Basic.S2
  val different: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
end
module type S3 = sig
  include Basic.S3
  val different: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
end
module type S4 = sig
  include Basic.S4
  val different: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
end
module type S5 = sig
  include Basic.S5
  val different: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
end
module Specialize1(M: S1)(A: Basic.S0) = struct
  module Self = struct
    include Basic.Specialize1(M)(A)
    let different x y =
      M.different x y ~equal_a:A.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0) = struct
  module Self = struct
    include Basic.Specialize2(M)(A)(B)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0) = struct
  module Self = struct
    include Basic.Specialize3(M)(A)(B)(C)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0) = struct
  module Self = struct
    include Basic.Specialize4(M)(A)(B)(C)(D)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0) = struct
  module Self = struct
    include Basic.Specialize5(M)(A)(B)(C)(D)(E)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal ~equal_e:E.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Tests_ = struct
  module Examples = struct
    module type Element = sig
      type t
      include Basic.S0 with type t := t
      include Representable.S0 with type t := t
    end
    module type S0 = sig
      type t
      val equal: t list list
      val different: (t * t) list
    end
    module type S1 = sig
      type 'a t
      module A: Element
      val equal: A.t t list list
      val different: (A.t t * A.t t) list
    end
    module type S2 = sig
      type ('a, 'b) t
      module A: Element
      module B: Element
      val equal: (A.t, B.t) t list list
      val different: ((A.t, B.t) t * (A.t, B.t) t) list
    end
    module type S3 = sig
      type ('a, 'b, 'c) t
      module A: Element
      module B: Element
      module C: Element
      val equal: (A.t, B.t, C.t) t list list
      val different: ((A.t, B.t, C.t) t * (A.t, B.t, C.t) t) list
    end
    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      val equal: (A.t, B.t, C.t, D.t) t list list
      val different: ((A.t, B.t, C.t, D.t) t * (A.t, B.t, C.t, D.t) t) list
    end
    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element
      val equal: (A.t, B.t, C.t, D.t, E.t) t list list
      val different: ((A.t, B.t, C.t, D.t, E.t) t * (A.t, B.t, C.t, D.t, E.t) t) list
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
  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "Equatable" >:: [
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
