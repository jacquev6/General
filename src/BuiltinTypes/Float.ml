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

module Tests = struct
  open Testing_

  let test = "Float" >:: [
    (let module T = Concepts.RealNumber.Tests.Make0(BuiltinTypes_.Float_)(Examples) in T.test);
  ]
end
