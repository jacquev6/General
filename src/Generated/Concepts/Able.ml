module Operators = struct
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
module Specialize1(M: S1)(A: S0) = struct
  type t = A.t M.t
  module Identifiable_ = Identifiable.Specialize1(M)(A)
  module Comparable_ = Traits.Comparable.Specialize1(M)(A)
  module O = struct
    include Identifiable_.O
    include Comparable_.O
  end
  include (Identifiable_: Identifiable.S0 with type t := t and module O := O)
  include (Comparable_: Traits.Comparable.S0 with type t := t and module O := O)
end
module Specialize2(M: S2)(A: S0)(B: S0) = struct
  type t = (A.t, B.t) M.t
  module Identifiable_ = Identifiable.Specialize2(M)(A)(B)
  module Comparable_ = Traits.Comparable.Specialize2(M)(A)(B)
  module O = struct
    include Identifiable_.O
    include Comparable_.O
  end
  include (Identifiable_: Identifiable.S0 with type t := t and module O := O)
  include (Comparable_: Traits.Comparable.S0 with type t := t and module O := O)
end
module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
  type t = (A.t, B.t, C.t) M.t
  module Identifiable_ = Identifiable.Specialize3(M)(A)(B)(C)
  module Comparable_ = Traits.Comparable.Specialize3(M)(A)(B)(C)
  module O = struct
    include Identifiable_.O
    include Comparable_.O
  end
  include (Identifiable_: Identifiable.S0 with type t := t and module O := O)
  include (Comparable_: Traits.Comparable.S0 with type t := t and module O := O)
end
module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
  type t = (A.t, B.t, C.t, D.t) M.t
  module Identifiable_ = Identifiable.Specialize4(M)(A)(B)(C)(D)
  module Comparable_ = Traits.Comparable.Specialize4(M)(A)(B)(C)(D)
  module O = struct
    include Identifiable_.O
    include Comparable_.O
  end
  include (Identifiable_: Identifiable.S0 with type t := t and module O := O)
  include (Comparable_: Traits.Comparable.S0 with type t := t and module O := O)
end
module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
  type t = (A.t, B.t, C.t, D.t, E.t) M.t
  module Identifiable_ = Identifiable.Specialize5(M)(A)(B)(C)(D)(E)
  module Comparable_ = Traits.Comparable.Specialize5(M)(A)(B)(C)(D)(E)
  module O = struct
    include Identifiable_.O
    include Comparable_.O
  end
  include (Identifiable_: Identifiable.S0 with type t := t and module O := O)
  include (Comparable_: Traits.Comparable.S0 with type t := t and module O := O)
end
module Tests = struct
  module Examples = struct
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
  module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    let test = "Able" >:: [
      (let module T = Identifiable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
    ]
  end
  module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
    open Testing
    let test = "Able" >:: [
      (let module T = Identifiable.Tests.Make1(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make1(M)(E) in T.test);
    ]
  end
  module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
    open Testing
    let test = "Able" >:: [
      (let module T = Identifiable.Tests.Make2(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make2(M)(E) in T.test);
    ]
  end
  module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
    open Testing
    let test = "Able" >:: [
      (let module T = Identifiable.Tests.Make3(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make3(M)(E) in T.test);
    ]
  end
  module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
    open Testing
    let test = "Able" >:: [
      (let module T = Identifiable.Tests.Make4(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make4(M)(E) in T.test);
    ]
  end
  module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
    open Testing
    let test = "Able" >:: [
      (let module T = Identifiable.Tests.Make5(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make5(M)(E) in T.test);
    ]
  end
end
