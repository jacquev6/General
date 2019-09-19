module Option: sig
  type 'a t = 'a option
  include Concepts.Able.S1 with type 'a t := 'a t
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
