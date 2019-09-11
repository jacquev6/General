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
module Tests_ = struct
  module Examples = struct
    module type Element = sig
      type t
      include S0 with type t := t
    end
    module type S0 = sig
      type t
      val repr: (t * string) list
    end
    module type S1 = sig
      type 'a t
      module A: Element
      val repr: (A.t t * string) list
    end
    module type S2 = sig
      type ('a, 'b) t
      module A: Element
      module B: Element
      val repr: ((A.t, B.t) t * string) list
    end
    module type S3 = sig
      type ('a, 'b, 'c) t
      module A: Element
      module B: Element
      module C: Element
      val repr: ((A.t, B.t, C.t) t * string) list
    end
    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      val repr: ((A.t, B.t, C.t, D.t) t * string) list
    end
    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element
      val repr: ((A.t, B.t, C.t, D.t, E.t) t * string) list
    end
  end
end
