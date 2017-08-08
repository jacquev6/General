open Foundations

(* fold[_short][_right][_i|_acc] *)
(* [try_|]reduce[_short][_right][_i|_acc] *)

module Basic = struct
  module type S0 = sig
    type elt
    type t

    val fold: init:'b -> t -> f:('b -> elt -> 'b) -> 'b
    val fold_i: init:'b -> t -> f:(i:int -> 'b -> elt -> 'b) -> 'b
    val fold_acc: acc:'acc -> init:'b -> t -> f:(acc:'acc -> 'b -> elt -> 'acc * 'b) -> 'b
  end

  module type S1 = sig
    type 'a t

    val fold: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b
    val fold_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b
    val fold_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b
  end
end

module type S0 = sig
  include Basic.S0

  val reduce: t -> f:(elt -> elt -> elt) -> elt
  val reduce_i: t -> f:(i:int -> elt -> elt -> elt) -> elt
  val reduce_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> elt

  val try_reduce: t -> f:(elt -> elt -> elt) -> (elt) option
  val try_reduce_i: t -> f:(i:int -> elt -> elt -> elt) -> (elt) option
  val try_reduce_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> (elt) option

  val iter: t -> f:(elt -> unit) -> unit
  val iter_i: t -> f:(i:int -> elt -> unit) -> unit
  val iter_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc) -> unit

  val count: t -> f:(elt -> bool) -> int
  val count_i: t -> f:(i:int -> elt -> bool) -> int
  val count_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> int
end

module type S1 = sig
  include Basic.S1

  val reduce: 'a t -> f:('a -> 'a -> 'a) -> 'a
  val reduce_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> 'a
  val reduce_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> 'a

  val try_reduce: 'a t -> f:('a -> 'a -> 'a) -> ('a) option
  val try_reduce_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> ('a) option
  val try_reduce_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> ('a) option

  val iter: 'a t -> f:('a -> unit) -> unit
  val iter_i: 'a t -> f:(i:int -> 'a -> unit) -> unit
  val iter_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc) -> unit

  val count: 'a t -> f:('a -> bool) -> int
  val count_i: 'a t -> f:(i:int -> 'a -> bool) -> int
  val count_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> int
end

module Right = struct
  module Basic = struct
    module type S0 = sig
      type elt
      type t

      val fold_right: t -> init:'b -> f:(elt -> 'b -> 'b) -> 'b
      val fold_right_i: t -> init:'b -> f:(i:int -> elt -> 'b -> 'b) -> 'b
      val fold_right_acc: acc:'acc -> t -> init:'b -> f:(acc:'acc -> elt -> 'b -> 'acc * 'b) -> 'b
    end

    module type S1 = sig
      type 'a t

      val fold_right: 'a t -> init:'b -> f:('a -> 'b -> 'b) -> 'b
      val fold_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> 'b) -> 'b
      val fold_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * 'b) -> 'b
    end
  end

  module type S0 = sig
    include Basic.S0

    val reduce_right: t -> f:(elt -> elt -> elt) -> elt
    val reduce_right_i: t -> f:(i:int -> elt -> elt -> elt) -> elt
    val reduce_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> elt

    val try_reduce_right: t -> f:(elt -> elt -> elt) -> (elt) option
    val try_reduce_right_i: t -> f:(i:int -> elt -> elt -> elt) -> (elt) option
    val try_reduce_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> (elt) option

    val iter_right: t -> f:(elt -> unit) -> unit
    val iter_right_i: t -> f:(i:int -> elt -> unit) -> unit
    val iter_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * unit) -> unit
  end

  module type S1 = sig
    include Basic.S1

    val reduce_right: 'a t -> f:('a -> 'a -> 'a) -> 'a
    val reduce_right_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> 'a
    val reduce_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> 'a

    val try_reduce_right: 'a t -> f:('a -> 'a -> 'a) -> ('a) option
    val try_reduce_right_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> ('a) option
    val try_reduce_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> ('a) option

    val iter_right: 'a t -> f:('a -> unit) -> unit
    val iter_right_i: 'a t -> f:(i:int -> 'a -> unit) -> unit
    val iter_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * unit) -> unit
  end
end

module Short = struct
  module Basic = struct
    module type S0 = sig
      type elt
      type t

      val fold_short: init:'b -> t -> f:('b -> elt -> Shorten.t * 'b) -> 'b
      val fold_short_i: init:'b -> t -> f:(i:int -> 'b -> elt -> Shorten.t * 'b) -> 'b
      val fold_short_acc: acc:'acc -> init:'b -> t -> f:(acc:'acc -> 'b -> elt -> 'acc * Shorten.t * 'b) -> 'b
    end

    module type S1 = sig
      type 'a t

      val fold_short: init:'b -> 'a t -> f:('b -> 'a -> Shorten.t * 'b) -> 'b
      val fold_short_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> Shorten.t * 'b) -> 'b
      val fold_short_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * Shorten.t * 'b) -> 'b
    end
  end

  module type S0 = sig
    include Basic.S0

    val reduce_short: t -> f:(elt -> elt -> Shorten.t * elt) -> elt
    val reduce_short_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> elt
    val reduce_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> elt

    val try_reduce_short: t -> f:(elt -> elt -> Shorten.t * elt) -> (elt) option
    val try_reduce_short_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> (elt) option
    val try_reduce_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> (elt) option

    val iter_short: t -> f:(elt -> Shorten.t) -> unit
    val iter_short_i: t -> f:(i:int -> elt -> Shorten.t) -> unit
    val iter_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * Shorten.t) -> unit

    val for_all: t -> f:(elt -> bool) -> bool
    val for_all_i: t -> f:(i:int -> elt -> bool) -> bool
    val for_all_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> bool

    val there_exists: t -> f:(elt -> bool) -> bool
    val there_exists_i: t -> f:(i:int -> elt -> bool) -> bool
    val there_exists_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> bool

    val find: t -> f:(elt -> bool) -> elt
    val find_i: t -> f:(i:int -> elt -> bool) -> elt
    val find_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> elt

    val try_find: t -> f:(elt -> bool) -> (elt) option
    val try_find_i: t -> f:(i:int -> elt -> bool) -> (elt) option
    val try_find_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> (elt) option

    val find_map: t -> f:(elt -> 'b option) -> 'b
    val find_map_i: t -> f:(i:int -> elt -> 'b option) -> 'b
    val find_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> 'b

    val try_find_map: t -> f:(elt -> 'b option) -> ( 'b) option
    val try_find_map_i: t -> f:(i:int -> elt -> 'b option) -> ( 'b) option
    val try_find_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> ( 'b) option
  end

  module type S1 = sig
    include Basic.S1

    val reduce_short: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> 'a
    val reduce_short_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> 'a
    val reduce_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> 'a

    val try_reduce_short: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> ('a) option
    val try_reduce_short_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> ('a) option
    val try_reduce_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> ('a) option

    val iter_short: 'a t -> f:('a -> Shorten.t) -> unit
    val iter_short_i: 'a t -> f:(i:int -> 'a -> Shorten.t) -> unit
    val iter_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * Shorten.t) -> unit

    val for_all: 'a t -> f:('a -> bool) -> bool
    val for_all_i: 'a t -> f:(i:int -> 'a -> bool) -> bool
    val for_all_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> bool

    val there_exists: 'a t -> f:('a -> bool) -> bool
    val there_exists_i: 'a t -> f:(i:int -> 'a -> bool) -> bool
    val there_exists_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> bool

    val find: 'a t -> f:('a -> bool) -> 'a
    val find_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a
    val find_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a

    val try_find: 'a t -> f:('a -> bool) -> ('a) option
    val try_find_i: 'a t -> f:(i:int -> 'a -> bool) -> ('a) option
    val try_find_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> ('a) option

    val find_map: 'a t -> f:('a -> 'b option) -> 'b
    val find_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b
    val find_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b

    val try_find_map: 'a t -> f:('a -> 'b option) -> ( 'b) option
    val try_find_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> ( 'b) option
    val try_find_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> ( 'b) option
  end

  module Right = struct
    module Basic = struct
      module type S0 = sig
        type elt
        type t

        val fold_short_right: t -> init:'b -> f:(elt -> 'b -> Shorten.t * 'b) -> 'b
        val fold_short_right_i: t -> init:'b -> f:(i:int -> elt -> 'b -> Shorten.t * 'b) -> 'b
        val fold_short_right_acc: acc:'acc -> t -> init:'b -> f:(acc:'acc -> elt -> 'b -> 'acc * Shorten.t * 'b) -> 'b
      end

      module type S1 = sig
        type 'a t

        val fold_short_right: 'a t -> init:'b -> f:('a -> 'b -> Shorten.t * 'b) -> 'b
        val fold_short_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> Shorten.t * 'b) -> 'b
        val fold_short_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * Shorten.t * 'b) -> 'b
      end
    end

    module type S0 = sig
      include Basic.S0

      val reduce_short_right: t -> f:(elt -> elt -> Shorten.t * elt) -> elt
      val reduce_short_right_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> elt
      val reduce_short_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> elt

      val try_reduce_short_right: t -> f:(elt -> elt -> Shorten.t * elt) -> (elt) option
      val try_reduce_short_right_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> (elt) option
      val try_reduce_short_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> (elt) option

      val iter_short_right: t -> f:(elt -> Shorten.t) -> unit
      val iter_short_right_i: t -> f:(i:int -> elt -> Shorten.t) -> unit
      val iter_short_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * Shorten.t) -> unit
    end

    module type S1 = sig
      include Basic.S1

      val reduce_short_right: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> 'a
      val reduce_short_right_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> 'a
      val reduce_short_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> 'a

      val try_reduce_short_right: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> ('a) option
      val try_reduce_short_right_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> ('a) option
      val try_reduce_short_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> ('a) option

      val iter_short_right: 'a t -> f:('a -> Shorten.t) -> unit
      val iter_short_right_i: 'a t -> f:(i:int -> 'a -> Shorten.t) -> unit
      val iter_short_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * Shorten.t) -> unit
    end
  end
end
