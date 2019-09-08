module Traits = struct
  module Representable = struct
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
      let repr x =
        M.repr x ~repr_a:A.repr
    end
    module Specialize2(M: S2)(A: S0)(B: S0) = struct
      type t = (A.t, B.t) M.t
      let repr x =
        M.repr x ~repr_a:A.repr ~repr_b:B.repr
    end
    module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
      type t = (A.t, B.t, C.t) M.t
      let repr x =
        M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr
    end
    module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
      type t = (A.t, B.t, C.t, D.t) M.t
      let repr x =
        M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr
    end
    module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
      type t = (A.t, B.t, C.t, D.t, E.t) M.t
      let repr x =
        M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr ~repr_e:E.repr
    end
  end
  module Displayable = struct
    module type S0 = sig
      type t
      val to_string: t -> string
    end
  end
  module Equatable = struct
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
      val different: t -> t -> bool
      module O: Operators.S0 with type t := t
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
  end
  module Parsable = struct
    module type S0 = sig
      type t
      val try_of_string: string -> t option
      val of_string: string -> t
    end
  end
  module Comparable = struct
    module Operators = struct
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
      end) = struct
        let ( < ) = M.less_than
        let ( <= ) = M.less_or_equal
        let ( > ) = M.greater_than
        let ( >= ) = M.greater_or_equal
      end
    end
    module Basic = struct
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
        let compare x y =
          M.compare x y ~compare_a:A.compare
      end
      module Specialize2(M: S2)(A: S0)(B: S0) = struct
        type t = (A.t, B.t) M.t
        let compare x y =
          M.compare x y ~compare_a:A.compare ~compare_b:B.compare
      end
      module Specialize3(M: S3)(A: S0)(B: S0)(C: S0) = struct
        type t = (A.t, B.t, C.t) M.t
        let compare x y =
          M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
      end
      module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0) = struct
        type t = (A.t, B.t, C.t, D.t) M.t
        let compare x y =
          M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
      end
      module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0) = struct
        type t = (A.t, B.t, C.t, D.t, E.t) M.t
        let compare x y =
          M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
      end
    end
    module type S0 = sig
      include Basic.S0
      val less_than: t -> t -> bool
      val less_or_equal: t -> t -> bool
      val greater_than: t -> t -> bool
      val greater_or_equal: t -> t -> bool
      val between: t -> low:(t) -> high:(t) -> bool
      val between_or_equal: t -> low:(t) -> high:(t) -> bool
      val min: t -> t -> t
      val max: t -> t -> t
      val min_max: t -> t -> t * t
      module O: Operators.S0 with type t := t
    end
    module type S1 = sig
      include Basic.S1
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
      include Basic.S2
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
      include Basic.S3
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
      include Basic.S4
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
      include Basic.S5
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
    module Specialize1(M: S1)(A: Basic.S0) = struct
      module Self = struct
        include Basic.Specialize1(M)(A)
        let less_than x y =
          M.less_than x y ~compare_a:A.compare
        let less_or_equal x y =
          M.less_or_equal x y ~compare_a:A.compare
        let greater_than x y =
          M.greater_than x y ~compare_a:A.compare
        let greater_or_equal x y =
          M.greater_or_equal x y ~compare_a:A.compare
        let between x ~low ~high =
          M.between x ~low ~high ~compare_a:A.compare
        let between_or_equal x ~low ~high =
          M.between_or_equal x ~low ~high ~compare_a:A.compare
        let min x y =
          M.min x y ~compare_a:A.compare
        let max x y =
          M.max x y ~compare_a:A.compare
        let min_max x y =
          M.min_max x y ~compare_a:A.compare
      end
      module O = Operators.Make0(Self)
      include Self
    end
    module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0) = struct
      module Self = struct
        include Basic.Specialize2(M)(A)(B)
        let less_than x y =
          M.less_than x y ~compare_a:A.compare ~compare_b:B.compare
        let less_or_equal x y =
          M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare
        let greater_than x y =
          M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare
        let greater_or_equal x y =
          M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare
        let between x ~low ~high =
          M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare
        let between_or_equal x ~low ~high =
          M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare
        let min x y =
          M.min x y ~compare_a:A.compare ~compare_b:B.compare
        let max x y =
          M.max x y ~compare_a:A.compare ~compare_b:B.compare
        let min_max x y =
          M.min_max x y ~compare_a:A.compare ~compare_b:B.compare
      end
      module O = Operators.Make0(Self)
      include Self
    end
    module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0) = struct
      module Self = struct
        include Basic.Specialize3(M)(A)(B)(C)
        let less_than x y =
          M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let less_or_equal x y =
          M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let greater_than x y =
          M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let greater_or_equal x y =
          M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let between x ~low ~high =
          M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let between_or_equal x ~low ~high =
          M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let min x y =
          M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let max x y =
          M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
        let min_max x y =
          M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
      end
      module O = Operators.Make0(Self)
      include Self
    end
    module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0) = struct
      module Self = struct
        include Basic.Specialize4(M)(A)(B)(C)(D)
        let less_than x y =
          M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let less_or_equal x y =
          M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let greater_than x y =
          M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let greater_or_equal x y =
          M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let between x ~low ~high =
          M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let between_or_equal x ~low ~high =
          M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let min x y =
          M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let max x y =
          M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
        let min_max x y =
          M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
      end
      module O = Operators.Make0(Self)
      include Self
    end
    module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0) = struct
      module Self = struct
        include Basic.Specialize5(M)(A)(B)(C)(D)(E)
        let less_than x y =
          M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let less_or_equal x y =
          M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let greater_than x y =
          M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let greater_or_equal x y =
          M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let between x ~low ~high =
          M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let between_or_equal x ~low ~high =
          M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let min x y =
          M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let max x y =
          M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
        let min_max x y =
          M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
      end
      module O = Operators.Make0(Self)
      include Self
    end
  end
  module Ringoid = struct
    module Operators = struct
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
        val substract: t -> t -> t
        val multiply: t -> t -> t
        val divide: t -> t -> t
        val exponentiate: t -> int -> t
      end) = struct
        let ( ~- ) = M.negate
        let ( + ) = M.add
        let ( - ) = M.substract
        let ( * ) = M.multiply
        let ( / ) = M.divide
        let ( ** ) = M.exponentiate
      end
    end
    module Basic = struct
      module type S0 = sig
        type t
        val zero: t
        val one: t
        val negate: t -> t
        val add: t -> t -> t
        val substract: t -> t -> t
        val multiply: t -> t -> t
        val divide: t -> t -> t
      end
    end
    module type S0 = sig
      include Basic.S0
      val square: t -> t
      val exponentiate: t -> int -> t
      module O: Operators.S0 with type t := t
    end
  end
  module OfStandardNumbers = struct
    module type S0 = sig
      type t
      val of_int: int -> t
      val of_float: float -> t
    end
  end
  module ToStandardNumbers = struct
    module type S0 = sig
      type t
      val to_int: t -> int
      val to_float: t -> float
    end
  end
  module PredSucc = struct
    module type S0 = sig
      type t
      val pred: t -> t
      val succ: t -> t
    end
  end
end
module Concepts = struct
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
          include Traits.Equatable.Tests.Examples.Element with type t := t
          include Traits.Representable.Tests.Examples.Element with type t := t
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
      module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
        let test = "Identifiable" >:: [
          (let module T = Traits.Equatable.Tests.Make0(M)(E) in T.test);
          (let module T = Traits.Representable.Tests.Make0(M)(E) in T.test);
        ]
      end
      module Make1(M: S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
        let test = "Identifiable" >:: [
          (let module T = Traits.Equatable.Tests.Make1(M)(E) in T.test);
          (let module T = Traits.Representable.Tests.Make1(M)(E) in T.test);
        ]
      end
      module Make2(M: S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
        let test = "Identifiable" >:: [
          (let module T = Traits.Equatable.Tests.Make2(M)(E) in T.test);
          (let module T = Traits.Representable.Tests.Make2(M)(E) in T.test);
        ]
      end
      module Make3(M: S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
        let test = "Identifiable" >:: [
          (let module T = Traits.Equatable.Tests.Make3(M)(E) in T.test);
          (let module T = Traits.Representable.Tests.Make3(M)(E) in T.test);
        ]
      end
      module Make4(M: S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
        let test = "Identifiable" >:: [
          (let module T = Traits.Equatable.Tests.Make4(M)(E) in T.test);
          (let module T = Traits.Representable.Tests.Make4(M)(E) in T.test);
        ]
      end
      module Make5(M: S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
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
          include Identifiable.Tests.Examples.Element with type t := t
          include Traits.Comparable.Tests.Examples.Element with type t := t
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
      module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
        let test = "Able" >:: [
          (let module T = Identifiable.Tests.Make0(M)(E) in T.test);
          (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
        ]
      end
      module Make1(M: S1)(E: Examples.S1 with type 'a t := 'a M.t) = struct
        let test = "Able" >:: [
          (let module T = Identifiable.Tests.Make1(M)(E) in T.test);
          (let module T = Traits.Comparable.Tests.Make1(M)(E) in T.test);
        ]
      end
      module Make2(M: S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = struct
        let test = "Able" >:: [
          (let module T = Identifiable.Tests.Make2(M)(E) in T.test);
          (let module T = Traits.Comparable.Tests.Make2(M)(E) in T.test);
        ]
      end
      module Make3(M: S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = struct
        let test = "Able" >:: [
          (let module T = Identifiable.Tests.Make3(M)(E) in T.test);
          (let module T = Traits.Comparable.Tests.Make3(M)(E) in T.test);
        ]
      end
      module Make4(M: S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = struct
        let test = "Able" >:: [
          (let module T = Identifiable.Tests.Make4(M)(E) in T.test);
          (let module T = Traits.Comparable.Tests.Make4(M)(E) in T.test);
        ]
      end
      module Make5(M: S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = struct
        let test = "Able" >:: [
          (let module T = Identifiable.Tests.Make5(M)(E) in T.test);
          (let module T = Traits.Comparable.Tests.Make5(M)(E) in T.test);
        ]
      end
    end
  end
  module Number = struct
    module Operators = struct
      module type S0 = sig
        type t
        include Traits.Equatable.Operators.S0 with type t := t
        include Traits.Ringoid.Operators.S0 with type t := t
      end
    end
    module type S0 = sig
      type t
      module O: Operators.S0 with type t := t
      include Traits.Displayable.S0 with type t := t
      include Traits.Equatable.S0 with type t := t and module O := O
      include Traits.Parsable.S0 with type t := t
      include Traits.Representable.S0 with type t := t
      include Traits.Ringoid.S0 with type t := t and module O := O
      include Traits.OfStandardNumbers.S0 with type t := t
    end
    module Tests = struct
      open Testing
      module Examples = struct
        module type S0 = sig
          type t
          include Traits.Displayable.Tests.Examples.S0 with type t := t
          include Traits.Equatable.Tests.Examples.S0 with type t := t
          include Traits.Parsable.Tests.Examples.S0 with type t := t
          include Traits.Representable.Tests.Examples.S0 with type t := t
          include Traits.Ringoid.Tests.Examples.S0 with type t := t
        end
      end
      module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
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
          (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
          (let module T = Traits.Equatable.Tests.Make0(M)(E) in T.test);
          (let module T = Traits.Parsable.Tests.Make0(M)(E) in T.test);
          (let module T = Traits.Representable.Tests.Make0(M)(E) in T.test);
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
      module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
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
      module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
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
end
