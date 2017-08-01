include Foundations.Bool

module Tests = struct
  open Testing

  module Examples = struct
    let repr = [
      (false, "false");
      (true, "true");
    ]

    let to_string = repr

    let of_string = [
      ("false", false);
      ("true", true);
    ]

    let equal = [
      [true];
      [false];
    ]

    let different = [
      (true, false);
    ]

    let ordered = [
      [false; true];
    ]
  end

  let test = "Bool" >:: [
    (let module T = Traits.Comparable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (let module T = Traits.Displayable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (let module T = Traits.Representable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (* @todo Should Bool be a Ringoid? *)
  ]
end
