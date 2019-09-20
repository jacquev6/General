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

module Specialize1(M: S1)(A: ComparableBasic.S0) = struct
  module Self = struct
    type t = A.t M.t
    module ComparableBasic_ = ComparableBasic.Specialize1(M)(A)
    include (ComparableBasic_: ComparableBasic.S0 with type t := t)
    let less_than x y = M.less_than x y ~compare_a:A.compare
    let less_or_equal x y = M.less_or_equal x y ~compare_a:A.compare
    let greater_than x y = M.greater_than x y ~compare_a:A.compare
    let greater_or_equal x y = M.greater_or_equal x y ~compare_a:A.compare
    let between x ~low ~high = M.between x ~low ~high ~compare_a:A.compare
    let between_or_equal x ~low ~high = M.between_or_equal x ~low ~high ~compare_a:A.compare
    let min x y = M.min x y ~compare_a:A.compare
    let max x y = M.max x y ~compare_a:A.compare
    let min_max x y = M.min_max x y ~compare_a:A.compare
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize2(M: S2)(A: ComparableBasic.S0)(B: ComparableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t) M.t
    module ComparableBasic_ = ComparableBasic.Specialize2(M)(A)(B)
    include (ComparableBasic_: ComparableBasic.S0 with type t := t)
    let less_than x y = M.less_than x y ~compare_a:A.compare ~compare_b:B.compare
    let less_or_equal x y = M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare
    let greater_than x y = M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare
    let greater_or_equal x y = M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare
    let between x ~low ~high = M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare
    let between_or_equal x ~low ~high = M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare
    let min x y = M.min x y ~compare_a:A.compare ~compare_b:B.compare
    let max x y = M.max x y ~compare_a:A.compare ~compare_b:B.compare
    let min_max x y = M.min_max x y ~compare_a:A.compare ~compare_b:B.compare
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize3(M: S3)(A: ComparableBasic.S0)(B: ComparableBasic.S0)(C: ComparableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t, C.t) M.t
    module ComparableBasic_ = ComparableBasic.Specialize3(M)(A)(B)(C)
    include (ComparableBasic_: ComparableBasic.S0 with type t := t)
    let less_than x y = M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let less_or_equal x y = M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let greater_than x y = M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let greater_or_equal x y = M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let between x ~low ~high = M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let between_or_equal x ~low ~high = M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let min x y = M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let max x y = M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let min_max x y = M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize4(M: S4)(A: ComparableBasic.S0)(B: ComparableBasic.S0)(C: ComparableBasic.S0)(D: ComparableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t, C.t, D.t) M.t
    module ComparableBasic_ = ComparableBasic.Specialize4(M)(A)(B)(C)(D)
    include (ComparableBasic_: ComparableBasic.S0 with type t := t)
    let less_than x y = M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let less_or_equal x y = M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let greater_than x y = M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let greater_or_equal x y = M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let between x ~low ~high = M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let between_or_equal x ~low ~high = M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let min x y = M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let max x y = M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let min_max x y = M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
  end

  module O = Operators.Make0(Self)
  include Self
end

module Specialize5(M: S5)(A: ComparableBasic.S0)(B: ComparableBasic.S0)(C: ComparableBasic.S0)(D: ComparableBasic.S0)(E: ComparableBasic.S0) = struct
  module Self = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    module ComparableBasic_ = ComparableBasic.Specialize5(M)(A)(B)(C)(D)(E)
    include (ComparableBasic_: ComparableBasic.S0 with type t := t)
    let less_than x y = M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let less_or_equal x y = M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let greater_than x y = M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let greater_or_equal x y = M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let between x ~low ~high = M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let between_or_equal x ~low ~high = M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let min x y = M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let max x y = M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let min_max x y = M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
  end

  module O = Operators.Make0(Self)
  include Self
end

module GreaterLessThan_ = struct
  module MakeMakers(Implementation: sig
    val less_than: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> bool
    val less_or_equal: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> bool
    val greater_than: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> bool
    val greater_or_equal: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> bool
  end) = struct
    module Make0(M: sig
      type t
      val compare: t -> t -> Compare.t
    end) = struct
      let less_than x y = Implementation.less_than ~compare:(M.compare) x y
      let less_or_equal x y = Implementation.less_or_equal ~compare:(M.compare) x y
      let greater_than x y = Implementation.greater_than ~compare:(M.compare) x y
      let greater_or_equal x y = Implementation.greater_or_equal ~compare:(M.compare) x y
    end

    module Make1(M: sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end) = struct
      let less_than x y ~compare_a = Implementation.less_than ~compare:(M.compare ~compare_a) x y
      let less_or_equal x y ~compare_a = Implementation.less_or_equal ~compare:(M.compare ~compare_a) x y
      let greater_than x y ~compare_a = Implementation.greater_than ~compare:(M.compare ~compare_a) x y
      let greater_or_equal x y ~compare_a = Implementation.greater_or_equal ~compare:(M.compare ~compare_a) x y
    end

    module Make2(M: sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end) = struct
      let less_than x y ~compare_a ~compare_b = Implementation.less_than ~compare:(M.compare ~compare_a ~compare_b) x y
      let less_or_equal x y ~compare_a ~compare_b = Implementation.less_or_equal ~compare:(M.compare ~compare_a ~compare_b) x y
      let greater_than x y ~compare_a ~compare_b = Implementation.greater_than ~compare:(M.compare ~compare_a ~compare_b) x y
      let greater_or_equal x y ~compare_a ~compare_b = Implementation.greater_or_equal ~compare:(M.compare ~compare_a ~compare_b) x y
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end) = struct
      let less_than x y ~compare_a ~compare_b ~compare_c = Implementation.less_than ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
      let less_or_equal x y ~compare_a ~compare_b ~compare_c = Implementation.less_or_equal ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
      let greater_than x y ~compare_a ~compare_b ~compare_c = Implementation.greater_than ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
      let greater_or_equal x y ~compare_a ~compare_b ~compare_c = Implementation.greater_or_equal ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end) = struct
      let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.less_than ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
      let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.less_or_equal ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
      let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.greater_than ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
      let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.greater_or_equal ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end) = struct
      let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.less_than ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
      let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.less_or_equal ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
      let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.greater_than ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
      let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.greater_or_equal ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
    end
  end
end

module Between_ = struct
  module MakeMakers(Implementation: sig
    val between: less_than:('a -> 'a -> bool) -> less_or_equal:('a -> 'a -> bool) -> greater_than:('a -> 'a -> bool) -> greater_or_equal:('a -> 'a -> bool) -> 'a -> low:('a) -> high:('a) -> bool
    val between_or_equal: less_than:('a -> 'a -> bool) -> less_or_equal:('a -> 'a -> bool) -> greater_than:('a -> 'a -> bool) -> greater_or_equal:('a -> 'a -> bool) -> 'a -> low:('a) -> high:('a) -> bool
  end) = struct
    module Make0(M: sig
      type t
      val less_than: t -> t -> bool
      val less_or_equal: t -> t -> bool
      val greater_than: t -> t -> bool
      val greater_or_equal: t -> t -> bool
    end) = struct
      let between x ~low ~high = Implementation.between ~less_than:(M.less_than) ~less_or_equal:(M.less_or_equal) ~greater_than:(M.greater_than) ~greater_or_equal:(M.greater_or_equal) x ~low ~high
      let between_or_equal x ~low ~high = Implementation.between_or_equal ~less_than:(M.less_than) ~less_or_equal:(M.less_or_equal) ~greater_than:(M.greater_than) ~greater_or_equal:(M.greater_or_equal) x ~low ~high
    end

    module Make1(M: sig
      type 'a t
      val less_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val less_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    end) = struct
      let between x ~low ~high ~compare_a = Implementation.between ~less_than:(M.less_than ~compare_a) ~less_or_equal:(M.less_or_equal ~compare_a) ~greater_than:(M.greater_than ~compare_a) ~greater_or_equal:(M.greater_or_equal ~compare_a) x ~low ~high
      let between_or_equal x ~low ~high ~compare_a = Implementation.between_or_equal ~less_than:(M.less_than ~compare_a) ~less_or_equal:(M.less_or_equal ~compare_a) ~greater_than:(M.greater_than ~compare_a) ~greater_or_equal:(M.greater_or_equal ~compare_a) x ~low ~high
    end

    module Make2(M: sig
      type ('a, 'b) t
      val less_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val less_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end) = struct
      let between x ~low ~high ~compare_a ~compare_b = Implementation.between ~less_than:(M.less_than ~compare_a ~compare_b) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b) ~greater_than:(M.greater_than ~compare_a ~compare_b) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b) x ~low ~high
      let between_or_equal x ~low ~high ~compare_a ~compare_b = Implementation.between_or_equal ~less_than:(M.less_than ~compare_a ~compare_b) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b) ~greater_than:(M.greater_than ~compare_a ~compare_b) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b) x ~low ~high
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end) = struct
      let between x ~low ~high ~compare_a ~compare_b ~compare_c = Implementation.between ~less_than:(M.less_than ~compare_a ~compare_b ~compare_c) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b ~compare_c) ~greater_than:(M.greater_than ~compare_a ~compare_b ~compare_c) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b ~compare_c) x ~low ~high
      let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c = Implementation.between_or_equal ~less_than:(M.less_than ~compare_a ~compare_b ~compare_c) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b ~compare_c) ~greater_than:(M.greater_than ~compare_a ~compare_b ~compare_c) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b ~compare_c) x ~low ~high
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end) = struct
      let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.between ~less_than:(M.less_than ~compare_a ~compare_b ~compare_c ~compare_d) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b ~compare_c ~compare_d) ~greater_than:(M.greater_than ~compare_a ~compare_b ~compare_c ~compare_d) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b ~compare_c ~compare_d) x ~low ~high
      let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.between_or_equal ~less_than:(M.less_than ~compare_a ~compare_b ~compare_c ~compare_d) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b ~compare_c ~compare_d) ~greater_than:(M.greater_than ~compare_a ~compare_b ~compare_c ~compare_d) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b ~compare_c ~compare_d) x ~low ~high
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end) = struct
      let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.between ~less_than:(M.less_than ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) ~greater_than:(M.greater_than ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x ~low ~high
      let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.between_or_equal ~less_than:(M.less_than ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) ~less_or_equal:(M.less_or_equal ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) ~greater_than:(M.greater_than ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) ~greater_or_equal:(M.greater_or_equal ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x ~low ~high
    end
  end
end

module MinMax_ = struct
  module MakeMakers(Implementation: sig
    val min: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> 'a
    val max: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> 'a
    val min_max: compare:('a -> 'a -> Compare.t) -> 'a -> 'a -> 'a * 'a
  end) = struct
    module Make0(M: sig
      type t
      val compare: t -> t -> Compare.t
    end) = struct
      let min x y = Implementation.min ~compare:(M.compare) x y
      let max x y = Implementation.max ~compare:(M.compare) x y
      let min_max x y = Implementation.min_max ~compare:(M.compare) x y
    end

    module Make1(M: sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end) = struct
      let min x y ~compare_a = Implementation.min ~compare:(M.compare ~compare_a) x y
      let max x y ~compare_a = Implementation.max ~compare:(M.compare ~compare_a) x y
      let min_max x y ~compare_a = Implementation.min_max ~compare:(M.compare ~compare_a) x y
    end

    module Make2(M: sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end) = struct
      let min x y ~compare_a ~compare_b = Implementation.min ~compare:(M.compare ~compare_a ~compare_b) x y
      let max x y ~compare_a ~compare_b = Implementation.max ~compare:(M.compare ~compare_a ~compare_b) x y
      let min_max x y ~compare_a ~compare_b = Implementation.min_max ~compare:(M.compare ~compare_a ~compare_b) x y
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end) = struct
      let min x y ~compare_a ~compare_b ~compare_c = Implementation.min ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
      let max x y ~compare_a ~compare_b ~compare_c = Implementation.max ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
      let min_max x y ~compare_a ~compare_b ~compare_c = Implementation.min_max ~compare:(M.compare ~compare_a ~compare_b ~compare_c) x y
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end) = struct
      let min x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.min ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
      let max x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.max ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
      let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d = Implementation.min_max ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d) x y
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end) = struct
      let min x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.min ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
      let max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.max ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
      let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e = Implementation.min_max ~compare:(M.compare ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e) x y
    end
  end
end

module Tests_ = struct
  module Examples = struct
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
      let test = "Comparable" >:: [
        (let module T = ComparableBasic.Tests.Make0(M)(E) in T.test);
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
