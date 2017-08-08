open Foundations

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

  module Tests = struct
    open Testing

    module Make1(M: sig
      type 'a t

      val of_list: 'a list -> 'a t
    end)(ToContainer: sig
      include S1 with type 'a t := 'a M.t
    end)(Container: sig
      val of_list: 'a list -> 'a C.t
      val to_list: 'a C.t -> 'a list
    end) = struct
      open ToContainer

      let test = "FilterMapable.ToContainer" >:: [
        "map" >: (lazy (check_int_list ~expected:[2; 7; 4; 0] ([1; 6; 3; -1] |> M.of_list |> map ~f:((+) 1) |> Container.to_list)));
        "map_i" >: (lazy (check_int_list ~expected:[1; 7; 5; 2] ([1; 6; 3; -1] |> M.of_list |> map_i ~f:(fun ~i x -> i + x) |> Container.to_list)));
        "map_acc" >: (lazy (check_int_list ~expected:[43; 48; 255; 755] ([1; 6; 3; -1] |> M.of_list |> map_acc ~acc:42 ~f:(fun ~acc x -> (acc * x, x + acc)) |> Container.to_list)));
        "filter" >: (lazy (check_int_list ~expected:[3; 15; 9] ([1; 3; 4; 15; 9; 7] |> M.of_list |> filter ~f:(fun x -> x mod 3 = 0) |> Container.to_list)));
        "filter_i" >: (lazy (check_int_list ~expected:[3; 15] ([3; 4; 15; 9; 7] |> M.of_list |> filter_i ~f:(fun ~i x -> i mod 2 = 0 && x mod 3 = 0) |> Container.to_list)));
        "filter_acc" >: (lazy (check_int_list ~expected:[3; 9] ([2; 3; 4; 15; 9; 7] |> M.of_list |> filter_acc ~acc:42 ~f:(fun ~acc x -> (acc + x, acc mod 2 = 0 && x mod 3 = 0)) |> Container.to_list)));
        "filter_map" >: (lazy (check_int_list ~expected:[4; 16; 10] ([1; 3; 4; 15; 9; 7] |> M.of_list |> filter_map ~f:(fun x -> Option.some_if' (x mod 3 = 0) (x + 1)) |> Container.to_list)));
        "filter_map_i" >: (lazy (check_int_list ~expected:[4; 16] ([3; 4; 15; 9; 7] |> M.of_list |> filter_map_i ~f:(fun ~i x -> Option.some_if' (i mod 2 = 0 && x mod 3 = 0) (x + 1)) |> Container.to_list)));
        "filter_map_acc" >: (lazy (check_int_list ~expected:[4; 10] ([2; 3; 4; 15; 9; 7] |> M.of_list |> filter_map_acc ~acc:42 ~f:(fun ~acc x -> (acc + x, Option.some_if' (acc mod 2 = 0 && x mod 3 = 0) (x + 1))) |> Container.to_list)));
        "flat_map" >: (lazy (check_int_list
          ~expected:[1; 2; 4; 3; 6; 9; 4; 8; 12; 16]
          (
            [1; 2; 0; 3; 4]
            |> M.of_list
            |> flat_map ~f:(fun x ->
              IntRange.create x
              |> IntRange.ToList.map ~f:(fun n -> x * (n + 1))
              |> Container.of_list
            )
            |> Container.to_list
          )
        ));
        "flat_map_i" >: (lazy (check_int_list
          ~expected:[1; 3; 6; 6; 12; 18; 8; 16; 24; 32]
          (
            [1; 2; 0; 3; 4]
            |> M.of_list
            |> flat_map_i ~f:(fun ~i x ->
              IntRange.create x
              |> IntRange.ToList.map ~f:(fun n -> (x + i) * (n + 1))
              |> Container.of_list
            )
            |> Container.to_list
          )
        ));
        "flat_map_acc" >: (lazy (check_int_list
          ~expected:[43; 86; 88; 255; 258; 261; 1012; 1016; 1020; 1024]
          (
            [1; 2; 0; 3; 4]
            |> M.of_list
            |> flat_map_acc ~acc:42 ~f:(fun ~acc x ->
              let acc = acc * (x + 1)
              and ys =
                IntRange.create x
                |> IntRange.ToList.map ~f:(fun n -> acc + x * (n + 1))
                |> Container.of_list
              in
              (acc, ys)
            )
            |> Container.to_list
          )
        ));
      ]
    end
  end
end

module ToList = ToContainer(struct type 'a t = 'a list end)

module ToArray = ToContainer(struct type 'a t = 'a array end)

module Tests = struct
  open Testing

  module Make1(M: sig
    include S1

    val to_list: 'a t -> 'a list
    val of_list: 'a list -> 'a t
  end): sig
    val test: Test.t
  end = struct
    module T = ToContainer(M)
    include T.Tests.Make1(M)(M)(M)
  end
end
