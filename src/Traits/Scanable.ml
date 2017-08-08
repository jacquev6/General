open Foundations

(* [ToList.|ToArray.|]scan[|_short][|_right][|_i|_acc] *)

(* @feature [try_|]scan_reduce[...] (like [try_|]reduce[...], but returning the intermediate results) *)

module type S0 = sig
  type elt
  type t

  val scan: init:elt -> t -> f:(elt -> elt -> elt) -> t
  val scan_i: init:elt -> t -> f:(i:int -> elt -> elt -> elt) -> t
  val scan_acc: acc:'acc -> init:elt -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> t
end

module type S1 = sig
  type 'a t

  val scan: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b t
  val scan_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b t
  val scan_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b t
end

module ToContainer(C: sig type 'a t end) = struct
  module type S0 = sig
    type elt
    type t

    val scan: init:'a -> t -> f:('a -> elt -> 'a) -> 'a C.t
    val scan_i: init:'a -> t -> f:(i:int -> 'a -> elt -> 'a) -> 'a C.t
    val scan_acc: acc:'acc -> init:'a -> t -> f:(acc:'acc -> 'a -> elt -> 'acc * 'a) -> 'a C.t
  end

  module type S1 = sig
    type 'a t

    val scan: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b C.t
    val scan_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b C.t
    val scan_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b C.t
  end
end

module ToList = ToContainer(struct type 'a t = 'a list end)

module ToArray = ToContainer(struct type 'a t = 'a array end)

module Right = struct
  module type S0 = sig
    type elt
    type t

    val scan_right: t -> init:elt -> f:(elt -> elt -> elt) -> t
    val scan_right_i: t -> init:elt -> f:(i:int -> elt -> elt -> elt) -> t
    val scan_right_acc: acc:'acc -> t -> init:elt -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> t
  end

  module type S1 = sig
    type 'a t

    val scan_right: 'a t -> init:'b -> f:('a -> 'b -> 'b) -> 'b t
    val scan_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> 'b) -> 'b t
    val scan_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * 'b) -> 'b t
  end

  module ToContainer(C: sig type 'a t end) = struct
    module type S0 = sig
      type elt
      type t

      val scan_right: t -> init:'a -> f:(elt -> 'a -> 'a) -> 'a C.t
      val scan_right_i: t -> init:'a -> f:(i:int -> elt -> 'a -> 'a) -> 'a C.t
      val scan_right_acc: acc:'acc -> t -> init:'a -> f:(acc:'acc -> elt -> 'a -> 'acc * 'a) -> 'a C.t
    end

    module type S1 = sig
      type 'a t

      val scan_right: 'a t -> init:'b -> f:('a -> 'b -> 'b) -> 'b C.t
      val scan_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> 'b) -> 'b C.t
      val scan_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * 'b) -> 'b C.t
    end
  end

  module ToList = ToContainer(struct type 'a t = 'a list end)

  module ToArray = ToContainer(struct type 'a t = 'a array end)
end

module Short = struct
  module type S0 = sig
    type elt
    type t

    val scan_short: init:elt -> t -> f:(elt -> elt -> Shorten.t * elt) -> t
    val scan_short_i: init:elt -> t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> t
    val scan_short_acc: acc:'acc -> init:elt -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> t
  end

  module type S1 = sig
    type 'a t

    val scan_short: init:'b -> 'a t -> f:('b -> 'a -> Shorten.t * 'b) -> 'b t
    val scan_short_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> Shorten.t * 'b) -> 'b t
    val scan_short_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * Shorten.t * 'b) -> 'b t
  end

  module ToContainer(C: sig type 'a t end) = struct
    module type S0 = sig
      type elt
      type t

      val scan_short: init:'a -> t -> f:('a -> elt -> Shorten.t * 'a) -> 'a C.t
      val scan_short_i: init:'a -> t -> f:(i:int -> 'a -> elt -> Shorten.t * 'a) -> 'a C.t
      val scan_short_acc: acc:'acc -> init:'a -> t -> f:(acc:'acc -> 'a -> elt -> 'acc * Shorten.t * 'a) -> 'a C.t
    end

    module type S1 = sig
      type 'a t

      val scan_short: init:'b -> 'a t -> f:('b -> 'a -> Shorten.t * 'b) -> 'b C.t
      val scan_short_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> Shorten.t * 'b) -> 'b C.t
      val scan_short_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * Shorten.t * 'b) -> 'b C.t
    end
  end

  module ToList = ToContainer(struct type 'a t = 'a list end)

  module ToArray = ToContainer(struct type 'a t = 'a array end)

  module Right = struct
    module type S0 = sig
      type elt
      type t

      val scan_short_right: t -> init:elt -> f:(elt -> elt -> Shorten.t * elt) -> t
      val scan_short_right_i: t -> init:elt -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> t
      val scan_short_right_acc: acc:'acc -> t -> init:elt -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> t
    end

    module type S1 = sig
      type 'a t

      val scan_short_right: 'a t -> init:'b -> f:('a -> 'b -> Shorten.t * 'b) -> 'b t
      val scan_short_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> Shorten.t * 'b) -> 'b t
      val scan_short_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * Shorten.t * 'b) -> 'b t
    end

    module ToContainer(C: sig type 'a t end) = struct
      module type S0 = sig
        type elt
        type t

        val scan_short_right: t -> init:'a -> f:(elt -> 'a -> Shorten.t * 'a) -> 'a C.t
        val scan_short_right_i: t -> init:'a -> f:(i:int -> elt -> 'a -> Shorten.t * 'a) -> 'a C.t
        val scan_short_right_acc: acc:'acc -> t -> init:'a -> f:(acc:'acc -> elt -> 'a -> 'acc * Shorten.t * 'a) -> 'a C.t
      end

      module type S1 = sig
        type 'a t

        val scan_short_right: 'a t -> init:'b -> f:('a -> 'b -> Shorten.t * 'b) -> 'b C.t
        val scan_short_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> Shorten.t * 'b) -> 'b C.t
        val scan_short_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * Shorten.t * 'b) -> 'b C.t
      end
    end

    module ToList = ToContainer(struct type 'a t = 'a list end)

    module ToArray = ToContainer(struct type 'a t = 'a array end)
  end
end
