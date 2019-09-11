module Identifiable = struct
  module Operators = struct
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
  module Specialize1(M: S1)(A: S0) = struct
    type t = A.t M.t
    module Equatable_ = Traits.Equatable.Specialize1(M)(A)
    module Representable_ = Traits.Representable.Specialize1(M)(A)
    module O = struct
      include Equatable_.O
    end
    include (Equatable_: Traits.Equatable.S0 with type t := t and module O := O)
    include (Representable_: Traits.Representable.S0 with type t := t)
  end
  module Specialize2(M: S2)(A: S0)(B: S0) = struct
    type t = (A.t, B.t) M.t
    module Equatable_ = Traits.Equatable.Specialize2(M)(A)(B)
    module Representable_ = Traits.Representable.Specialize2(M)(A)(B)
    module O = struct
      include Equatable_.O
    end
    include (Equatable_: Traits.Equatable.S0 with type t := t and module O := O)
    include (Representable_: Traits.Representable.S0 with type t := t)
  end
  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
    type t = (A.t, B.t, C.t) M.t
    module Equatable_ = Traits.Equatable.Specialize3(M)(A)(B)(C)
    module Representable_ = Traits.Representable.Specialize3(M)(A)(B)(C)
    module O = struct
      include Equatable_.O
    end
    include (Equatable_: Traits.Equatable.S0 with type t := t and module O := O)
    include (Representable_: Traits.Representable.S0 with type t := t)
  end
  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
    type t = (A.t, B.t, C.t, D.t) M.t
    module Equatable_ = Traits.Equatable.Specialize4(M)(A)(B)(C)(D)
    module Representable_ = Traits.Representable.Specialize4(M)(A)(B)(C)(D)
    module O = struct
      include Equatable_.O
    end
    include (Equatable_: Traits.Equatable.S0 with type t := t and module O := O)
    include (Representable_: Traits.Representable.S0 with type t := t)
  end
  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    module Equatable_ = Traits.Equatable.Specialize5(M)(A)(B)(C)(D)(E)
    module Representable_ = Traits.Representable.Specialize5(M)(A)(B)(C)(D)(E)
    module O = struct
      include Equatable_.O
    end
    include (Equatable_: Traits.Equatable.S0 with type t := t and module O := O)
    include (Representable_: Traits.Representable.S0 with type t := t)
  end
  module Tests = struct
    open Testing
    module Examples = struct
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
      let test = "Identifiable" >:: [
        (let module T = Traits.Equatable.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Representable.Tests.Make0(M)(E) in T.test);
      ]
    end
    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
      let test = "Identifiable" >:: [
        (let module T = Traits.Equatable.Tests.Make1(M)(E) in T.test);
        (let module T = Traits.Representable.Tests.Make1(M)(E) in T.test);
      ]
    end
    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
      let test = "Identifiable" >:: [
        (let module T = Traits.Equatable.Tests.Make2(M)(E) in T.test);
        (let module T = Traits.Representable.Tests.Make2(M)(E) in T.test);
      ]
    end
    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
      let test = "Identifiable" >:: [
        (let module T = Traits.Equatable.Tests.Make3(M)(E) in T.test);
        (let module T = Traits.Representable.Tests.Make3(M)(E) in T.test);
      ]
    end
    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
      let test = "Identifiable" >:: [
        (let module T = Traits.Equatable.Tests.Make4(M)(E) in T.test);
        (let module T = Traits.Representable.Tests.Make4(M)(E) in T.test);
      ]
    end
    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
      let test = "Identifiable" >:: [
        (let module T = Traits.Equatable.Tests.Make5(M)(E) in T.test);
        (let module T = Traits.Representable.Tests.Make5(M)(E) in T.test);
      ]
    end
  end
end
module Able = struct
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
    open Testing
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
      let test = "Able" >:: [
        (let module T = Identifiable.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
      ]
    end
    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
      let test = "Able" >:: [
        (let module T = Identifiable.Tests.Make1(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make1(M)(E) in T.test);
      ]
    end
    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
      let test = "Able" >:: [
        (let module T = Identifiable.Tests.Make2(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make2(M)(E) in T.test);
      ]
    end
    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
      let test = "Able" >:: [
        (let module T = Identifiable.Tests.Make3(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make3(M)(E) in T.test);
      ]
    end
    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
      let test = "Able" >:: [
        (let module T = Identifiable.Tests.Make4(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make4(M)(E) in T.test);
      ]
    end
    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
      let test = "Able" >:: [
        (let module T = Identifiable.Tests.Make5(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make5(M)(E) in T.test);
      ]
    end
  end
end
module Stringable = struct
  module type S0 = sig
    type t
    include Traits.Displayable.S0 with type t := t
    include Traits.Parsable.S0 with type t := t
  end
  module Tests = struct
    open Testing
    module Examples = struct
      module type S0 = sig
        type t
        include Traits.Displayable.Tests.Examples.S0 with type t := t
        include Traits.Parsable.Tests.Examples.S0 with type t := t
      end
    end
    module Testable = struct
      module type S0 = sig
        include S0
        include Traits.Representable.S0 with type t := t
        include Traits.Equatable.Basic.S0 with type t := t
      end
    end
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      let test = "Stringable" >:: [
        (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Parsable.Tests.Make0(M)(E) in T.test);
      ]
    end
  end
end
module Number = struct
  module Operators = struct
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
    include Traits.OfStandardNumbers.S0 with type t := t
  end
  module Tests = struct
    open Testing
    module Examples = struct
      module type S0 = sig
        type t
        include Identifiable.Tests.Examples.S0 with type t := t
        include Stringable.Tests.Examples.S0 with type t := t
        include Traits.Ringoid.Tests.Examples.S0 with type t := t
      end
    end
    module Testable = struct
      module type S0 = sig
        include S0
      end
    end
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      module E = struct
        include E
        let equal = equal @ [
            [M.zero; M.of_int 0; M.of_float 0.; M.of_string "0"];
            [M.one; M.of_int 1; M.of_float 1.; M.of_string "1"];
        ]
        let different = different @ [
            (M.zero, M.one);
        ]
      end
      let test = "Number" >:: [
        (let module T = Identifiable.Tests.Make0(M)(E) in T.test);
        (let module T = Stringable.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Ringoid.Tests.Make0(M)(E) in T.test);
      ]
    end
  end
end
module RealNumber = struct
  module Operators = struct
    module type S0 = sig
      type t
      include Number.Operators.S0 with type t := t
      include Traits.Comparable.Operators.S0 with type t := t
      val ( mod ): t -> t -> t
    end
    module Make0(M: sig
      type t
      val modulo: t -> t -> t
    end) = struct
      let ( mod ) = M.modulo
    end
  end
  module type S0 = sig
    type t
    module O: Operators.S0 with type t := t
    include Number.S0 with type t := t and module O := O
    include Traits.Comparable.S0 with type t := t and module O := O
    include Traits.ToStandardNumbers.S0 with type t := t
    val abs: t -> t
    val modulo: t -> t -> t
  end
  module Tests = struct
    open Testing
    module Examples = struct
      module type S0 = sig
        type t
        include Number.Tests.Examples.S0 with type t := t
        include Traits.Comparable.Tests.Examples.S0 with type t := t
      end
    end
    module Testable = struct
      module type S0 = sig
        include S0
      end
    end
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      module E = struct
        include E
        let ordered = ordered @ [
            [M.zero; M.one];
        ]
      end
      let test = "RealNumber" >:: [
        (let module T = Number.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
      ] @ (
        (
            E.negate
            |> List.flat_map ~f:(fun (x, y) ->
                let abs_x = M.(if greater_or_equal x zero then x else y)
                and abs_y = M.(if greater_or_equal y zero then y else x) in
                [
                    ~: "abs %s" (M.repr x) (lazy M.(check ~repr ~equal ~expected:abs_x (abs x)));
                    ~: "abs %s" (M.repr y) (lazy M.(check ~repr ~equal ~expected:abs_y (abs y)));
                ]
            )
        ) @ [
            "to_int zero" >: (lazy (check_int ~expected:0 M.(to_int zero)));
            "to_float zero" >: (lazy (check_float_exact ~expected:0. M.(to_float zero)));
            "to_int one" >: (lazy (check_int ~expected:1 M.(to_int one)));
            "to_float one" >: (lazy (check_float_exact ~expected:1. M.(to_float one)));
        ]
      )
    end
  end
end
module Integer = struct
  module Operators = struct
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
  module Tests = struct
    open Testing
    module Examples = struct
      module type S0 = sig
        type t
        include RealNumber.Tests.Examples.S0 with type t := t
        include Traits.PredSucc.Tests.Examples.S0 with type t := t
      end
    end
    module Testable = struct
      module type S0 = sig
        include S0
      end
    end
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      module E = struct
        include E
        let succ = succ @ [
            (M.zero, M.one);
        ]
      end
      let test = "Integer" >:: [
        (let module T = RealNumber.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.PredSucc.Tests.Make0(M)(E) in T.test);
      ]
    end
  end
end
