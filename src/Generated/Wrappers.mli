module Option: sig
  type 'a t = 'a option
  include Facets.Able.S1 with type 'a t := 'a t
  val none: 'a t
  val some: 'a -> 'a t
  val some_if: bool -> 'a lazy_t -> 'a t
  val some_if': bool -> 'a -> 'a t
  val is_some: 'a t -> bool
  val is_none: 'a t -> bool
  val value_def: 'a t -> def:('a) -> 'a
  val value: ?exc:(exn) -> 'a t -> 'a
  val or_failure: ('a, unit, string, string, string, 'b t -> 'b) CamlinternalFormatBasics.format6 -> 'a
  val map: 'a t -> f:('a -> 'b) -> 'b t
  val iter: 'a t -> f:('a -> unit) -> unit
  val filter: 'a t -> f:('a -> bool) -> 'a t
  val filter_map: 'a t -> f:('a -> 'b option) -> 'b t
  val value_map: 'a t -> def:('b) -> f:('a -> 'b) -> 'b
  module Specialize(A: sig type t end): sig
    type t = A.t option
    val some_if: bool -> A.t lazy_t -> t
    val some_if': bool -> A.t -> t
    val is_some: t -> bool
    val is_none: t -> bool
    val value_def: t -> def:A.t -> A.t
    val value: ?exc:exn -> t -> A.t
    val or_failure: ('a, unit, string, string, string, t -> A.t) CamlinternalFormatBasics.format6 -> 'a
    val map: t -> f:(A.t -> 'a) -> 'a option
    val iter: t -> f:(A.t -> unit) -> unit
    val filter: t -> f:(A.t -> bool) -> t
    val filter_map: t -> f:(A.t -> 'a option) -> 'a option
    val value_map: t -> def:'a -> f:(A.t -> 'a) -> 'a
  end
end

module Lazy: sig
  type 'a t = 'a lazy_t
  val is_value: 'a t -> bool
  val value: 'a t -> 'a
  val map: 'a t -> f:('a -> 'b) -> 'b t
end

module Reference: sig
  type 'a t = 'a OCamlStandard.Pervasives.ref = {mutable contents: 'a}
  module O: sig
    val ref: 'a -> 'a t
    val (!): 'a t -> 'a
    val (:=): 'a t -> 'a -> unit
  end

  val of_contents: 'a -> 'a t
  val contents: 'a t -> 'a
  val assign: 'a t -> 'a -> unit
  module SpecializeOperators(A: sig type t end): sig
    type nonrec t = A.t t
    val ref: A.t -> t
    val (!): t -> A.t
    val (:=): t -> A.t -> unit
  end

  module Specialize(A: sig type t end): sig
    type nonrec t = A.t t
    val of_contents: A.t -> t
    val contents: t -> A.t
    val assign: t -> A.t -> unit
    module O: module type of SpecializeOperators(A) with type t := t
  end

  module SpecializePredSucc(A: Facets.PredSucc.S0): sig
    type nonrec t = A.t t
    val increment: t -> unit
    val decrement: t -> unit
  end

  module SpecializeRingoidOperators(A: Facets.RingoidBasic.S0): sig
    type nonrec t = A.t t
    val (=+): t -> A.t -> unit
    val (=-): t -> A.t -> unit
    val (=*): t -> A.t -> unit
    val (=/): t -> A.t -> unit
  end

  module SpecializeRingoid(A: Facets.RingoidBasic.S0): sig
    type nonrec t = A.t t
    module O: module type of SpecializeRingoidOperators(A) with type t := t
  end
end

module Tuple2: sig
  type ('a, 'b) t = 'a * 'b
  include Facets.Able.S2 with type ('a, 'b) t := ('a, 'b) t
  val make: 'a -> 'b -> ('a, 'b) t
  val get_0: ('a, 'b) t -> 'a
  val get_1: ('a, 'b) t -> 'b
  val flip: ('a, 'b) t -> ('b, 'a) t
end

module Tuple3: sig
  type ('a, 'b, 'c) t = 'a * 'b * 'c
  include Facets.Able.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  val make: 'a -> 'b -> 'c -> ('a, 'b, 'c) t
  val get_0: ('a, 'b, 'c) t -> 'a
  val get_1: ('a, 'b, 'c) t -> 'b
  val get_2: ('a, 'b, 'c) t -> 'c
  val flip: ('a, 'b, 'c) t -> ('c, 'b, 'a) t
end

module Tuple4: sig
  type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd
  include Facets.Able.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  val make: 'a -> 'b -> 'c -> 'd -> ('a, 'b, 'c, 'd) t
  val get_0: ('a, 'b, 'c, 'd) t -> 'a
  val get_1: ('a, 'b, 'c, 'd) t -> 'b
  val get_2: ('a, 'b, 'c, 'd) t -> 'c
  val get_3: ('a, 'b, 'c, 'd) t -> 'd
  val flip: ('a, 'b, 'c, 'd) t -> ('d, 'c, 'b, 'a) t
end

module Tuple5: sig
  type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e
  include Facets.Able.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  val make: 'a -> 'b -> 'c -> 'd -> 'e -> ('a, 'b, 'c, 'd, 'e) t
  val get_0: ('a, 'b, 'c, 'd, 'e) t -> 'a
  val get_1: ('a, 'b, 'c, 'd, 'e) t -> 'b
  val get_2: ('a, 'b, 'c, 'd, 'e) t -> 'c
  val get_3: ('a, 'b, 'c, 'd, 'e) t -> 'd
  val get_4: ('a, 'b, 'c, 'd, 'e) t -> 'e
  val flip: ('a, 'b, 'c, 'd, 'e) t -> ('e, 'd, 'c, 'b, 'a) t
end
