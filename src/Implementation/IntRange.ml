module Self = Foundations.IntRange

include Self

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
