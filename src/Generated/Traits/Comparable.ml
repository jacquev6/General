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
  module O: Operators.S0 with type t := t
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
module Tests_ = struct
  module Examples = struct
    module type Element = sig
      type t
      include Basic.S0 with type t := t
      include Equatable.Basic.S0 with type t := t
      include Representable.S0 with type t := t
    end
    module type S0 = sig
      type t
      val ordered: t list list
      val equal: t list list
    end
    module type S1 = sig
      type 'a t
      module A: Element
      val ordered: A.t t list list
      val equal: A.t t list list
    end
    module type S2 = sig
      type ('a, 'b) t
      module A: Element
      module B: Element
      val ordered: (A.t, B.t) t list list
      val equal: (A.t, B.t) t list list
    end
    module type S3 = sig
      type ('a, 'b, 'c) t
      module A: Element
      module B: Element
      module C: Element
      val ordered: (A.t, B.t, C.t) t list list
      val equal: (A.t, B.t, C.t) t list list
    end
    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      val ordered: (A.t, B.t, C.t, D.t) t list list
      val equal: (A.t, B.t, C.t, D.t) t list list
    end
    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element
      val ordered: (A.t, B.t, C.t, D.t, E.t) t list list
      val equal: (A.t, B.t, C.t, D.t, E.t) t list list
    end
  end
  module Testable = struct
    module type S0 = sig
      include S0
      include Equatable.Basic.S0 with type t := t
      include Representable.S0 with type t := t
    end
    module type S1 = sig
      include S1
      include Equatable.Basic.S1 with type 'a t := 'a t
      include Representable.S1 with type 'a t := 'a t
    end
    module type S2 = sig
      include S2
      include Equatable.Basic.S2 with type ('a, 'b) t := ('a, 'b) t
      include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
    end
    module type S3 = sig
      include S3
      include Equatable.Basic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
      include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    end
    module type S4 = sig
      include S4
      include Equatable.Basic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
      include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    end
    module type S5 = sig
      include S5
      include Equatable.Basic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
      include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    end
  end
end
