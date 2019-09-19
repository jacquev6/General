module Operators = struct
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

module Specialize1(M: S1)(A: S0) = struct
  type t = A.t M.t
  module Equatable_ = Equatable.Specialize1(M)(A)
  module Representable_ = Representable.Specialize1(M)(A)
  module O = struct
    include Equatable_.O
  end

  include (Equatable_: Equatable.S0 with type t := t and module O := O)
  include (Representable_: Representable.S0 with type t := t)
end

module Specialize2(M: S2)(A: S0)(B: S0) = struct
  type t = (A.t, B.t) M.t
  module Equatable_ = Equatable.Specialize2(M)(A)(B)
  module Representable_ = Representable.Specialize2(M)(A)(B)
  module O = struct
    include Equatable_.O
  end

  include (Equatable_: Equatable.S0 with type t := t and module O := O)
  include (Representable_: Representable.S0 with type t := t)
end

module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
  type t = (A.t, B.t, C.t) M.t
  module Equatable_ = Equatable.Specialize3(M)(A)(B)(C)
  module Representable_ = Representable.Specialize3(M)(A)(B)(C)
  module O = struct
    include Equatable_.O
  end

  include (Equatable_: Equatable.S0 with type t := t and module O := O)
  include (Representable_: Representable.S0 with type t := t)
end

module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
  type t = (A.t, B.t, C.t, D.t) M.t
  module Equatable_ = Equatable.Specialize4(M)(A)(B)(C)(D)
  module Representable_ = Representable.Specialize4(M)(A)(B)(C)(D)
  module O = struct
    include Equatable_.O
  end

  include (Equatable_: Equatable.S0 with type t := t and module O := O)
  include (Representable_: Representable.S0 with type t := t)
end

module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
  type t = (A.t, B.t, C.t, D.t, E.t) M.t
  module Equatable_ = Equatable.Specialize5(M)(A)(B)(C)(D)(E)
  module Representable_ = Representable.Specialize5(M)(A)(B)(C)(D)(E)
  module O = struct
    include Equatable_.O
  end

  include (Equatable_: Equatable.S0 with type t := t and module O := O)
  include (Representable_: Representable.S0 with type t := t)
end

module Tests_ = struct
  module Examples = struct
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
      let test = "Identifiable" >:: [
        (let module T = Equatable.Tests.Make0(M)(E) in T.test);
        (let module T = Representable.Tests.Make0(M)(E) in T.test);
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
