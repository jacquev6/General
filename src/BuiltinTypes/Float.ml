open Abbr_

include BuiltinTypes_.Float_

module Examples = struct
  let repr = [
    (-3., "-3.");
    (-0., "-0.");
    (0., "0.");
    (1., "1.");
    (15., "15.");
  ]

  let to_string = repr

  let equal = [
    [0.];
    [1.];
    [2.];
  ]

  let different = [
    (0., 1.);
    (1., -1.);
  ]

  let ordered = [
    [-10.; -5.; -1.; -0.2; 0.; 0.7; 1.; 2.; 5.];
  ]

  let add_substract = [
    (4., 3., 7.);
    (4., -2., 2.);
    (5., -7., -2.);
  ]

  let negate = [
    (4., -4.);
    (-7., 7.);
  ]

  let multiply = [
    (4., 3., 12.);
    (4., -3., -12.);
    (-4., -3., 12.);
  ]

  let divide = [
    (5., 2., 2.5);
    (4., 2., 2.);
    (1., 4., 0.25);
    (4., 4., 1.);
    (4., 5., 0.8);
  ]

  let exponentiate = [
    (3., 3, 27.);
    (2., 7, 128.);
    (0.5, 4, 0.0625);
    (2., -4, 0.0625);
  ]
end

module ClassExamples = struct
  open BuiltinTypes_.Float_.Class

  let repr = [
    (Normal, "Normal");
    (SubNormal, "SubNormal");
    (Zero, "Zero");
    (Infinite, "Infinite");
    (Nan, "Nan");
  ]

  let equal = [
    [Normal];
    [SubNormal];
    [Zero];
    [Infinite];
    [Nan];
  ]

  let different = [
    (Normal, SubNormal);
  ]
end

module Tests = struct
  open Testing_
  open BuiltinTypes_.Float_.O

  let test = "Float" >:: [
    (let module T = Concepts.RealNumber.Tests.Make0(BuiltinTypes_.Float_)(Examples) in T.test);
    "Class" >:: [
      (let module T = Traits.Representable.Tests.Make0(BuiltinTypes_.Float_.Class)(ClassExamples) in T.test);
      (let module T = Traits.Equatable.Tests.Make0(BuiltinTypes_.Float_.Class)(ClassExamples) in T.test);
      "of_float" >:: BuiltinTypes_.Float_.Class.(
        let check = check ~repr ~equal in
        [
          "Normal" >: (lazy (check ~expected:Normal (of_float 1.)));
          "SubNormal" >: (lazy (check ~expected:SubNormal (of_float (1. / OCamlStandard.Pervasives.max_float))));
          "Zero" >: (lazy (check ~expected:Zero (of_float 0.)));
          "Zero-" >: (lazy (check ~expected:Zero (of_float (-0.))));
          "Infinite+" >: (lazy (check ~expected:Infinite (of_float (1. / 0.))));
          "Infinite-" >: (lazy (check ~expected:Infinite (of_float (-1. / 0.))));
          "Nan" >: (lazy (check ~expected:Nan (of_float (0. / 0.))));
          "Nan-" >: (lazy (check ~expected:Nan (of_float (-0. / 0.))));
        ]
      );
    ];
  ]
end
