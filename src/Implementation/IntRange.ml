type full = {
  min: int;
  max: int;
  step: int;
}

module Self = struct
  type t =
    | Empty
    | Ascending of full
    | Descending of full

  let empty = Empty

  let create ?(start=0) ?(step=1) stop =
    (* We normalize everything here, so that to_list is simpler, and Equate.Poly is appropriate *)
    if (stop - start) * step <= 0 then
      Empty
    else if step > 0 then
      let min = start
      and max = stop - 1 - (stop - 1 - start) mod step in
      assert ((max - min) mod step = 0);
      Ascending {min; max; step}
    else
      let step = -step in
      let min = stop + 1 - (stop + 1 - start) mod step
      and max = start in
      assert ((max - min) mod step = 0);
      Descending {min; max; step}

  let repr = function
    | Empty ->
      "[]"
    | Ascending {min; max; step} ->
      Format_.apply "[%i to %i step %i]" min max step
    | Descending {min; max; step} ->
      Format_.apply "[%i down to %i step -%i]" max min step

  include Equate.Poly
end

include Self

let to_list = function
  | Empty -> []
  | Ascending {min; max; step} ->
    let rec aux xs x =
      assert (x >= min);
      if x = min then x::xs else aux (x::xs) (x - step)
    in
    aux [] max
  | Descending {min; max; step} ->
    let rec aux xs x =
      assert (x <= max);
      if x = max then x::xs else aux (x::xs) (x + step)
    in
    aux [] min

let to_array r =
  r |> to_list |> List_.to_array

let fold ~init r ~f =
  r |> to_list |> List_.fold ~init ~f

let fold_i ~init r ~f =
  r |> to_list |> List_.fold_i ~init ~f

let fold_acc ~acc ~init r ~f =
  r |> to_list |> List_.fold_acc ~acc ~init ~f

let reduce r ~f =
  r |> to_list |> List_.reduce ~f

let reduce_i r ~f =
  r |> to_list |> List_.reduce_i ~f

let reduce_acc ~acc r ~f =
  r |> to_list |> List_.reduce_acc ~acc ~f

let try_reduce r ~f =
  r |> to_list |> List_.try_reduce ~f

let try_reduce_i r ~f =
  r |> to_list |> List_.try_reduce_i ~f

let try_reduce_acc ~acc r ~f =
  r |> to_list |> List_.try_reduce_acc ~acc ~f

let iter r ~f =
  r |> to_list |> List_.iter ~f

let iter_i r ~f =
  r |> to_list |> List_.iter_i ~f

let iter_acc ~acc r ~f =
  r |> to_list |> List_.iter_acc ~acc ~f

let count r ~f =
  r |> to_list |> List_.count ~f

let count_i r ~f =
  r |> to_list |> List_.count_i ~f

let count_acc ~acc r ~f =
  r |> to_list |> List_.count_acc ~acc ~f

let fold_short ~init r ~f =
  r |> to_list |> List_.fold_short ~init ~f

let fold_short_i ~init r ~f =
  r |> to_list |> List_.fold_short_i ~init ~f

let fold_short_acc ~acc ~init r ~f =
  r |> to_list |> List_.fold_short_acc ~acc ~init ~f

let reduce_short r ~f =
  r |> to_list |> List_.reduce_short ~f

let reduce_short_i r ~f =
  r |> to_list |> List_.reduce_short_i ~f

let reduce_short_acc ~acc r ~f =
  r |> to_list |> List_.reduce_short_acc ~acc ~f

let try_reduce_short r ~f =
  r |> to_list |> List_.try_reduce_short ~f

let try_reduce_short_i r ~f =
  r |> to_list |> List_.try_reduce_short_i ~f

let try_reduce_short_acc ~acc r ~f =
  r |> to_list |> List_.try_reduce_short_acc ~acc ~f

let iter_short r ~f =
  r |> to_list |> List_.iter_short ~f

let iter_short_i r ~f =
  r |> to_list |> List_.iter_short_i ~f

let iter_short_acc ~acc r ~f =
  r |> to_list |> List_.iter_short_acc ~acc ~f

let for_all r ~f =
  r |> to_list |> List_.for_all ~f

let for_all_i r ~f =
  r |> to_list |> List_.for_all_i ~f

let for_all_acc ~acc r ~f =
  r |> to_list |> List_.for_all_acc ~acc ~f

let there_exists r ~f =
  r |> to_list |> List_.there_exists ~f

let there_exists_i r ~f =
  r |> to_list |> List_.there_exists_i ~f

let there_exists_acc ~acc r ~f =
  r |> to_list |> List_.there_exists_acc ~acc ~f

let find r ~f =
  r |> to_list |> List_.find ~f

let find_i r ~f =
  r |> to_list |> List_.find_i ~f

let find_acc ~acc r ~f =
  r |> to_list |> List_.find_acc ~acc ~f

let try_find r ~f =
  r |> to_list |> List_.try_find ~f

let try_find_i r ~f =
  r |> to_list |> List_.try_find_i ~f

let try_find_acc ~acc r ~f =
  r |> to_list |> List_.try_find_acc ~acc ~f

let find_map r ~f =
  r |> to_list |> List_.find_map ~f

let find_map_i r ~f =
  r |> to_list |> List_.find_map_i ~f

let find_map_acc ~acc r ~f =
  r |> to_list |> List_.find_map_acc ~acc ~f

let try_find_map r ~f =
  r |> to_list |> List_.try_find_map ~f

let try_find_map_i r ~f =
  r |> to_list |> List_.try_find_map_i ~f

let try_find_map_acc ~acc r ~f =
  r |> to_list |> List_.try_find_map_acc ~acc ~f

module ToList = struct
  let map r ~f =
    r |> to_list |> List_.map ~f

  let map_i r ~f =
    r |> to_list |> List_.map_i ~f

  let map_acc ~acc r ~f =
    r |> to_list |> List_.map_acc ~acc ~f

  let filter r ~f =
    r |> to_list |> List_.filter ~f

  let filter_i r ~f =
    r |> to_list |> List_.filter_i ~f

  let filter_acc ~acc r ~f =
    r |> to_list |> List_.filter_acc ~acc ~f

  let filter_map r ~f =
    r |> to_list |> List_.filter_map ~f

  let filter_map_i r ~f =
    r |> to_list |> List_.filter_map_i ~f

  let filter_map_acc ~acc r ~f =
    r |> to_list |> List_.filter_map_acc ~acc ~f

  let flat_map r ~f =
    r |> to_list |> List_.flat_map ~f

  let flat_map_i r ~f =
    r |> to_list |> List_.flat_map_i ~f

  let flat_map_acc ~acc r ~f =
    r |> to_list |> List_.flat_map_acc ~acc ~f

  let scan ~init r ~f =
    r |> to_list |> List_.scan ~init ~f

  let scan_i ~init r ~f =
    r |> to_list |> List_.scan_i ~init ~f

  let scan_acc ~acc ~init r ~f =
    r |> to_list |> List_.scan_acc ~acc ~init ~f

  let scan_short ~init r ~f =
    r |> to_list |> List_.scan_short ~init ~f

  let scan_short_i ~init r ~f =
    r |> to_list |> List_.scan_short_i ~init ~f

  let scan_short_acc ~acc ~init r ~f =
    r |> to_list |> List_.scan_short_acc ~acc ~init ~f
end

module Tests = struct
  open Testing

  (* @feature Comparable: compare ranges as equal if to_list produces the same integers in the same order, not if they have the same start, stop and step. Poly.equal wouldn't work. *)

  module Examples = struct
    let repr = [
      (create 0, "[]");
      (create (-5), "[]");
      (create 5, "[0 to 4 step 1]");
      (create ~step:(-3) (-15), "[0 down to -12 step -3]");
      (create ~start:3 ~step:4 25, "[3 to 23 step 4]");
    ]

    let equal = [
      [create 0; create ~step:2 0; create (-4); create 10 ~step:0; create 10 ~step:(-1); create ~start:5 3; empty];
      [create 10; create ~start:0 ~step:1 10];
      [create ~start:5 ~step:3 9; create ~start:5 ~step:3 10; create ~start:5 ~step:3 11]
    ]

    let different = [
      (create 0, create 1);
      (create ~start:5 ~step:3 11, create ~start:5 ~step:3 12);
    ]
  end

  let test = "IntRange" >:: [
    (let module T = Traits.Representable.Tests.Make0(Self)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make0(Self)(Examples) in T.test);
    "to_list" >:: [
      "simplest" >: (lazy (check_int_list ~expected:[0; 1; 2; 3; 4] (to_list (create 5))));
      "with start" >: (lazy (check_int_list ~expected:[2; 3; 4] (to_list (create 5 ~start:2))));
      "with stop < 0" >: (lazy (check_int_list ~expected:[] (to_list (create (-5)))));
      "with stop <= start" >: (lazy (check_int_list ~expected:[] (to_list (create 0))));
      "with stop <= start" >: (lazy (check_int_list ~expected:[] (to_list (create (-5)))));
      "with stop <= start" >: (lazy (check_int_list ~expected:[] (to_list (create 5 ~start:5))));
      "with step" >: (lazy (check_int_list ~expected:[0; 2; 4] (to_list (create 5 ~step:2))));
      "with step" >: (lazy (check_int_list ~expected:[0; 2; 4] (to_list (create 6 ~step:2))));
      "with step = 0" >: (lazy (check_int_list ~expected:[] (to_list (create 6 ~step:0))));
      "with start and step" >: (lazy (check_int_list ~expected:[2; 4; 6] (to_list (create ~start:2 ~step:2 7))));
      "with start and step" >: (lazy (check_int_list ~expected:[2; 4; 6] (to_list (create ~start:2 ~step:2 8))));
      "with start and step" >: (lazy (check_int_list ~expected:[3; 5; 7] (to_list (create ~start:3 ~step:2 8))));
      "with start and step" >: (lazy (check_int_list ~expected:[3; 5; 7] (to_list (create ~start:3 ~step:2 9))));
      "with step < 0" >: (lazy (check_int_list ~expected:[] (to_list (create 6 ~step:(-1)))));
      "with step < 0" >: (lazy (check_int_list ~expected:[0; -1; -2; -3; -4; -5] (to_list (create (-6) ~step:(-1)))));
      "with step < 0" >: (lazy (check_int_list ~expected:[0; -2; -4] (to_list (create (-6) ~step:(-2)))));
      "with step < 0 and start" >: (lazy (check_int_list ~expected:[-3; -5; -7; -9] (to_list (create (-10) ~start:(-3) ~step:(-2)))));
      "with step < 0 and start" >: (lazy (check_int_list ~expected:[-3; -5; -7; -9] (to_list (create (-11) ~start:(-3) ~step:(-2)))));
      (* "fail" >: (lazy (fail "fail")); *)
    ];
  ]
end
