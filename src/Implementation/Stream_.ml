module Self = Foundations.Stream_

include Self

module Tests = struct
  open Testing

  let test = "Stream" >:: [
    "map" >: (lazy (check_int_list ~expected:[2; 7; 4; 0] ([1; 6; 3; -1] |> of_list |> map ~f:((+) 1) |> to_list)));
    "map_i" >: (lazy (check_int_list ~expected:[1; 7; 5; 2] ([1; 6; 3; -1] |> of_list |> map_i ~f:(fun ~i x -> i + x) |> to_list)));
    "map_acc" >: (lazy (check_int_list ~expected:[43; 48; 255; 755] ([1; 6; 3; -1] |> of_list |> map_acc ~acc:42 ~f:(fun ~acc x -> (acc * x, x + acc)) |> to_list)));
    "filter" >: (lazy (check_int_list ~expected:[3; 15; 9] ([1; 3; 4; 15; 9; 7] |> of_list |> filter ~f:(fun x -> x mod 3 = 0) |> to_list)));
    "filter_i" >: (lazy (check_int_list ~expected:[3; 15] ([3; 4; 15; 9; 7] |> of_list |> filter_i ~f:(fun ~i x -> i mod 2 = 0 && x mod 3 = 0) |> to_list)));
    "filter_acc" >: (lazy (check_int_list ~expected:[3; 9] ([2; 3; 4; 15; 9; 7] |> of_list |> filter_acc ~acc:42 ~f:(fun ~acc x -> (acc + x, acc mod 2 = 0 && x mod 3 = 0)) |> to_list)));
    "filter_map" >: (lazy (check_int_list ~expected:[4; 16; 10] ([1; 3; 4; 15; 9; 7] |> of_list |> filter_map ~f:(fun x -> Option.some_if' (x mod 3 = 0) (x + 1)) |> to_list)));
    "filter_map_i" >: (lazy (check_int_list ~expected:[4; 16] ([3; 4; 15; 9; 7] |> of_list |> filter_map_i ~f:(fun ~i x -> Option.some_if' (i mod 2 = 0 && x mod 3 = 0) (x + 1)) |> to_list)));
    "filter_map_acc" >: (lazy (check_int_list ~expected:[4; 10] ([2; 3; 4; 15; 9; 7] |> of_list |> filter_map_acc ~acc:42 ~f:(fun ~acc x -> (acc + x, Option.some_if' (acc mod 2 = 0 && x mod 3 = 0) (x + 1))) |> to_list)));
    "flat_map" >: (lazy (check_int_list
      ~expected:[1; 2; 4; 3; 9; 27; 4; 16; 64; 256]
      (
        [1; 2; 0; 3; 4]
        |> of_list
        |> flat_map ~f:(fun x ->
          IntRange.create x
          |> IntRange.ToList.map ~f:(fun n -> Int.exponentiate x (n + 1))
          |> of_list
        )
        |> to_list
      )
    ));
    "flat_map_i" >: (lazy (check_int_list
      ~expected:[1; 3; 9; 6; 36; 216; 8; 64; 512; 4096]
      (
        [1; 2; 0; 3; 4]
        |> of_list
        |> flat_map_i ~f:(fun ~i x ->
          IntRange.create x
          |> IntRange.ToList.map ~f:(fun n -> Int.exponentiate (x + i) (n + 1))
          |> of_list
        )
        |> to_list
      )
    ));
    "flat_map_acc" >: (lazy (check_int_list
      ~expected:[43; 86; 88; 255; 261; 279; 1012; 1024; 1072; 1264]
      (
        [1; 2; 0; 3; 4]
        |> of_list
        |> flat_map_acc ~acc:42 ~f:(fun ~acc x ->
          let acc = acc * (x + 1)
          and ys =
            IntRange.create x
            |> IntRange.ToList.map ~f:(fun n -> acc + Int.exponentiate x (n + 1))
            |> of_list
          in
          (acc, ys)
        )
        |> to_list
      )
    ));
  ]
end
