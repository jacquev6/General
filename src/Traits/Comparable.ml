open Foundations

(* @feature Descending, ascending *)

module Basic = struct
  module type SPoly = sig
    val compare: 'a -> 'a
      -> Compare.t
  end

  module type S0 = sig
    type t

    val compare: t -> t
      -> Compare.t
  end

  module type S1 = sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end

  module type S2 = sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end

  module type S3 = sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end

  module Specialize1(M: S1)(A: S0): S0 with type t = A.t M.t = struct
    type t = A.t M.t

    let compare x y =
      M.compare x y ~compare_a:A.compare
  end

  module Specialize2(M: S2)(A: S0)(B: S0): S0 with type t = (A.t, B.t) M.t = struct
    type t = (A.t, B.t) M.t

    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
    type t = (A.t, B.t, C.t) M.t

    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t) M.t

    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t

    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
  end
end

module Operators = struct
  module type SPoly = sig
    val (<): 'a -> 'a
      -> bool
    val (<=): 'a -> 'a
      -> bool
    val (>): 'a -> 'a
      -> bool
    val (>=): 'a -> 'a
      -> bool
  end

  module type S0 = sig
    type t

    val (<): t -> t
      -> bool
    val (<=): t -> t
      -> bool
    val (>): t -> t
      -> bool
    val (>=): t -> t
      -> bool
  end

  module Make0(M: sig
    type t

    val less_than: t -> t
      -> bool
    val less_or_equal: t -> t
      -> bool
    val greater_than: t -> t
      -> bool
    val greater_or_equal: t -> t
      -> bool
  end) = struct
    open M

    let (<) x y =
      less_than x y

    let (<=) x y =
      less_or_equal x y
    let (>) x y =
      greater_than x y

    let (>=) x y =
      greater_or_equal x y
  end
end

module type SPoly = sig
  include Basic.SPoly

  val less_than: 'a -> 'a
    -> bool
  val less_or_equal: 'a -> 'a
    -> bool
  val greater_than: 'a -> 'a
    -> bool
  val greater_or_equal: 'a -> 'a
    -> bool

  val between: 'a -> low:'a -> high:'a
    -> bool
  val between_or_equal: 'a -> low:'a -> high:'a
    -> bool

  val min: 'a -> 'a
    -> 'a
  val max: 'a -> 'a
    -> 'a
  val min_max: 'a -> 'a
    -> 'a * 'a

  module O: sig include Operators.SPoly end
end

module type S0 = sig
  include Basic.S0

  val less_than: t -> t
    -> bool
  val less_or_equal: t -> t
    -> bool
  val greater_than: t -> t
    -> bool
  val greater_or_equal: t -> t
    -> bool

  val between: t -> low:t -> high:t
    -> bool
  val between_or_equal: t -> low:t -> high:t
    -> bool

  val min: t -> t
    -> t
  val max: t -> t
    -> t
  val min_max: t -> t
    -> t * t

  module O: Operators.S0 with type t := t
end

module type S1 = sig
  include Basic.S1

  val less_than: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val less_or_equal: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val greater_than: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val greater_or_equal: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool

  val between: 'a t -> low:'a t -> high:'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val between_or_equal: 'a t -> low:'a t -> high:'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool

  val min: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> 'a t
  val max: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> 'a t
  val min_max: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> 'a t * 'a t
end

module type S2 = sig
  include Basic.S2

  val less_than: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val greater_than: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool

  val between: ('a, 'b) t -> low:('a, 'b) t -> high:('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b) t -> low:('a, 'b) t -> high:('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool

  val min: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> ('a, 'b) t
  val max: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> ('a, 'b) t
  val min_max: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> ('a, 'b) t * ('a, 'b) t
end

module type S3 = sig
  include Basic.S3

  val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool

  val between: ('a, 'b, 'c) t -> low:('a, 'b, 'c) t -> high:('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b, 'c) t -> low:('a, 'b, 'c) t -> high:('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool

  val min: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> ('a, 'b, 'c) t
  val max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> ('a, 'b, 'c) t
  val min_max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> ('a, 'b, 'c) t * ('a, 'b, 'c) t
end

module type S4 = sig
  include Basic.S4

  val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool

  val between: ('a, 'b, 'c, 'd) t -> low:('a, 'b, 'c, 'd) t -> high:('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b, 'c, 'd) t -> low:('a, 'b, 'c, 'd) t -> high:('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool

  val min: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> ('a, 'b, 'c, 'd) t
  val max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> ('a, 'b, 'c, 'd) t
  val min_max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> ('a, 'b, 'c, 'd) t * ('a, 'b, 'c, 'd) t
end

module type S5 = sig
  include Basic.S5

  val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool

  val between: ('a, 'b, 'c, 'd, 'e) t -> low:('a, 'b, 'c, 'd, 'e) t -> high:('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b, 'c, 'd, 'e) t -> low:('a, 'b, 'c, 'd, 'e) t -> high:('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool

  val min: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> ('a, 'b, 'c, 'd, 'e) t
  val max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> ('a, 'b, 'c, 'd, 'e) t
  val min_max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> ('a, 'b, 'c, 'd, 'e) t * ('a, 'b, 'c, 'd, 'e) t
end

module GreaterLessThan = struct
  module Make0(M: sig
    type t

    val compare: t -> t
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y =
      match compare x y with
        | LT -> true
        | _ -> false

    let less_or_equal x y =
      match compare x y with
        | GT -> false
        | _ -> true

    let greater_than x y =
      match compare x y with
        | GT -> true
        | _ -> false

    let greater_or_equal x y =
      match compare x y with
        | LT -> false
        | _ -> true
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a =
      match compare x y ~compare_a with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a =
      match compare x y ~compare_a with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a =
      match compare x y ~compare_a with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a =
      match compare x y ~compare_a with
        | LT -> false
        | _ -> true
  end

  module Make2(M: sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | LT -> false
        | _ -> true
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | LT -> false
        | _ -> true
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | LT -> false
        | _ -> true
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | LT -> false
        | _ -> true
  end
end

module Between = struct
  module Make0(M: sig
    type t

    val less_than: t -> t
      -> bool
    val less_or_equal: t -> t
      -> bool
    val greater_than: t -> t
      -> bool
    val greater_or_equal: t -> t
      -> bool
  end) = struct
    open M

    let between x ~low ~high =
      less_than low x
      && greater_than high x

    let between_or_equal x ~low ~high =
      less_or_equal low x
      && greater_or_equal high x
  end

  module Make1(M: sig
    type 'a t

    val less_than: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
    val less_or_equal: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
    val greater_than: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
    val greater_or_equal: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
  end) = struct
    open M
    open Compare

    let between x ~low ~high ~compare_a =
      less_than low x ~compare_a
      && greater_than high x ~compare_a

    let between_or_equal x ~low ~high ~compare_a =
      less_or_equal low x ~compare_a
      && greater_or_equal high x ~compare_a
  end

  module Make2(M: sig
    type ('a, 'b) t

    val less_than: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
    val greater_than: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b =
      less_than low x ~compare_a ~compare_b
      && greater_than high x ~compare_a ~compare_b

    let between_or_equal x ~low ~high ~compare_a ~compare_b =
      less_or_equal low x ~compare_a ~compare_b
      && greater_or_equal high x ~compare_a ~compare_b
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
    val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c =
      less_than low x ~compare_a ~compare_b ~compare_c
      && greater_than high x ~compare_a ~compare_b ~compare_c

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c =
      less_or_equal low x ~compare_a ~compare_b ~compare_c
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
    val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d =
      less_than low x ~compare_a ~compare_b ~compare_c ~compare_d
      && greater_than high x ~compare_a ~compare_b ~compare_c ~compare_d

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d =
      less_or_equal low x ~compare_a ~compare_b ~compare_c ~compare_d
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c ~compare_d
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
    val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      less_than low x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
      && greater_than high x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      less_or_equal low x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
  end
end

module MinMax = struct
  module Make0(M: sig
    type t

    val compare: t -> t
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y =
      match compare x y with LT -> x | GT | EQ -> y

    let max x y =
      match compare x y with GT -> x | LT | EQ -> y

    let min_max x y =
      match compare x y with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a =
      match compare x y ~compare_a with LT -> x | GT | EQ -> y

    let max x y ~compare_a =
      match compare x y ~compare_a with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a =
      match compare x y ~compare_a with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make2(M: sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with LT -> (x, y) | GT | EQ -> (y, x)
  end
end

module Specialize1(M: S1)(A: Basic.S0): S0 with type t = A.t M.t = struct
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

module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0): S0 with type t = (A.t, B.t) M.t = struct
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

module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
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

module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
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

module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
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

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val ordered: t list list
      val equal: t list list
    end

    module type Element = sig
      include Basic.S0
      include Equatable.Basic.S0 with type t := t
      include Representable.Basic.S0 with type t := t
    end

    module type S1 = sig
      module A: Element

      type 'a t

      val ordered: A.t t list list
      val equal: A.t t list list
    end

    module type S2 = sig
      module A: Element
      module B: Element

      type ('a, 'b) t

      val ordered: (A.t, B.t) t list list
      val equal: (A.t, B.t) t list list
    end

    module type S3 = sig
      module A: Element
      module B: Element
      module C: Element

      type ('a, 'b, 'c) t

      val ordered: (A.t, B.t, C.t) t list list
      val equal: (A.t, B.t, C.t) t list list
    end

    module type S4 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element

      type ('a, 'b, 'c, 'd) t

      val ordered: (A.t, B.t, C.t, D.t) t list list
      val equal: (A.t, B.t, C.t, D.t) t list list
    end

    module type S5 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      type ('a, 'b, 'c, 'd, 'e) t

      val ordered: (A.t, B.t, C.t, D.t, E.t) t list list
      val equal: (A.t, B.t, C.t, D.t, E.t) t list list
    end
  end

  module Make0(M: sig
    include S0
    include Representable.Basic.S0 with type t := t
    include Equatable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M
    open M.O

    let check_pair =
      check
        ~repr:(Tuples.Tuple2.repr ~repr_a:repr ~repr_b:repr)
        ~equal:(Tuples.Tuple2.equal ~equal_a:equal ~equal_b:equal)

    let check = check ~repr ~equal

    let test = "Comparable" >:: (
      E.ordered
      |> List_.flat_map ~f:(fun xs ->
        List_.fold ~init:(List_.head xs, []) (List_.tail xs) ~f:(fun (x, tests) y ->
          let rx = repr x and ry = repr y in
          let new_tests = [
            ~: "less_than %s %s" rx ry (lazy (check_true (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_false (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_true (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_false (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_false (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_true (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_false (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_true (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
          ] in
          (y, new_tests @ tests)
        )
        |> Tuples.Tuple2.get_1
      )
    ) @ (
      E.equal
      |> List_.flat_map ~f:(fun xs ->
        List_.cartesian_product xs xs
        |> List_.flat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "less_than %s %s" rx ry (lazy (check_false (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_true (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_false (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_true (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:y (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:x (max x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_true (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_false (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_true (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_false (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:y (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:x (max y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, y) (min_max y x)));
          ]
        )
      )
    )
  end

  module Make1(M: sig
    include S1
    include Equatable.Basic.S1 with type 'a t := 'a t
    include Representable.Basic.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t): sig val test: Test.t end = Make0(struct
    include Specialize1(M)(E.A)
    include (Representable.Basic.Specialize1(M)(E.A): Representable.Basic.S0 with type t := t)
    include (Equatable.Basic.Specialize1(M)(E.A): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make2(M: sig
    include S2
    include Equatable.Basic.S2 with type ('a, 'b) t := ('a, 'b) t
    include Representable.Basic.S2 with type ('a, 'b) t := ('a, 'b) t
  end)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig val test: Test.t end = Make0(struct
    include Specialize2(M)(E.A)(E.B)
    include (Representable.Basic.Specialize2(M)(E.A)(E.B): Representable.Basic.S0 with type t := t)
    include (Equatable.Basic.Specialize2(M)(E.A)(E.B): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make3(M: sig
    include S3
    include Equatable.Basic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Representable.Basic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig val test: Test.t end = Make0(struct
    include Specialize3(M)(E.A)(E.B)(E.C)
    include (Representable.Basic.Specialize3(M)(E.A)(E.B)(E.C): Representable.Basic.S0 with type t := t)
    include (Equatable.Basic.Specialize3(M)(E.A)(E.B)(E.C): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make4(M: sig
    include S4
    include Equatable.Basic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Representable.Basic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig val test: Test.t end = Make0(struct
    include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
    include (Representable.Basic.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Representable.Basic.S0 with type t := t)
    include (Equatable.Basic.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make5(M: sig
    include S5
    include Equatable.Basic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Representable.Basic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig val test: Test.t end = Make0(struct
    include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
    include (Representable.Basic.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Representable.Basic.S0 with type t := t)
    include (Equatable.Basic.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Equatable.Basic.S0 with type t := t)
  end)(E)
end
