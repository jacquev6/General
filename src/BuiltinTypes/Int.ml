open Abbr_

include BuiltinTypes_.Int_

module Examples = struct
  let repr = [
    (-3, "-3");
    (-0, "0");
    (0, "0");
    (1, "1");
    (15, "15");
  ]

  let equal = [
    [0];
    [1];
    [2];
  ]

  let different = [
    (0, 1);
    (1, -1);
  ]

  let ordered = [
    [-10; -5; -1; 0; 1; 2; 5];
  ]

  let add_substract = [
    (4, 3, 7);
    (4, -2, 2);
    (5, -7, -2);
  ]

  let negate = [
    (4, -4);
    (-7, 7);
  ]

  let multiply = [
    (4, 3, 12);
    (4, -3, -12);
    (-4, -3, 12);
  ]

  let divide = [
    (5, 2, 2);
    (4, 2, 2);
    (4, 3, 1);
    (4, 4, 1);
    (4, 5, 0);
  ]
end

module Tests = struct
  open Testing

  let test = "Int" >:: [
    (let module T = Concepts.Integer.Tests.Make0(BuiltinTypes_.Int_)(Examples) in T.test);
  ]
end
