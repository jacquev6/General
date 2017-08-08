(* [ToList.|ToArray.|][filter|map|filter_map|flat_map][|_i|_acc] *)

module type S0 = sig
  type elt
  type t

  val map: t -> f:(elt -> elt) -> t
  val map_i: t -> f:(i:int -> elt -> elt) -> t
  val map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * elt) -> t

  val filter: t -> f:(elt -> bool) -> t
  val filter_i: t -> f:(i:int -> elt -> bool) -> t
  val filter_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> t

  val filter_map: t -> f:(elt -> elt option) -> t
  val filter_map_i: t -> f:(i:int -> elt -> elt option) -> t
  val filter_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * elt option) -> t

  val flat_map: t -> f:(elt -> t) -> t
  val flat_map_i: t -> f:(i:int -> elt -> t) -> t
  val flat_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * t) -> t
end

module type S1 = sig
  type 'a t

  val map: 'a t -> f:('a -> 'b) -> 'b t
  val map_i: 'a t -> f:(i:int -> 'a -> 'b) -> 'b t
  val map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b) -> 'b t

  val filter: 'a t -> f:('a -> bool) -> 'a t
  val filter_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a t
  val filter_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a t

  val filter_map: 'a t -> f:('a -> 'b option) -> 'b t
  val filter_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b t
  val filter_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b t

  val flat_map: 'a t -> f:('a -> 'b t) -> 'b t
  val flat_map_i: 'a t -> f:(i:int -> 'a -> 'b t) -> 'b t
  val flat_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b t) -> 'b t
end

module ToContainer(C: sig type 'a t end) = struct
  module type S0 = sig
    type elt
    type t

    val map: t -> f:(elt -> 'b) -> 'b C.t
    val map_i: t -> f:(i:int -> elt -> 'b) -> 'b C.t
    val map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b) -> 'b C.t

    val filter: t -> f:(elt -> bool) -> elt C.t
    val filter_i: t -> f:(i:int -> elt -> bool) -> elt C.t
    val filter_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> elt C.t

    val filter_map: t -> f:(elt -> 'b option) -> 'b C.t
    val filter_map_i: t -> f:(i:int -> elt -> 'b option) -> 'b C.t
    val filter_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> 'b C.t

    val flat_map: t -> f:(elt -> 'b C.t) -> 'b C.t
    val flat_map_i: t -> f:(i:int -> elt -> 'b C.t) -> 'b C.t
    val flat_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b C.t) -> 'b C.t
  end

  module type S1 = sig
    type 'a t

    val map: 'a t -> f:('a -> 'b) -> 'b C.t
    val map_i: 'a t -> f:(i:int -> 'a -> 'b) -> 'b C.t
    val map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b) -> 'b C.t

    val filter: 'a t -> f:('a -> bool) -> 'a C.t
    val filter_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a C.t
    val filter_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a C.t

    val filter_map: 'a t -> f:('a -> 'b option) -> 'b C.t
    val filter_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b C.t
    val filter_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b C.t

    val flat_map: 'a t -> f:('a -> 'b C.t) -> 'b C.t
    val flat_map_i: 'a t -> f:(i:int -> 'a -> 'b C.t) -> 'b C.t
    val flat_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b C.t) -> 'b C.t
  end
end

module ToList = ToContainer(struct type 'a t = 'a list end)

module ToArray = ToContainer(struct type 'a t = 'a array end)
