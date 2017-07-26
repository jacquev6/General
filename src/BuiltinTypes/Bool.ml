open General_.Abbr

include BuiltinTypes_.Bool_

module Tests = struct
  open Testing

  module Examples = struct
    let repr = [
      (false, "false");
      (true, "true");
    ]

    let equal = [
      [true];
      [false];
    ]

    let different = [
      (true, false);
    ]
  end

  let test = "Bool" >:: [
    (let module T = Traits.Representable.Tests.Make0(BuiltinTypes_.Bool_)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make0(BuiltinTypes_.Bool_)(Examples) in T.test);
  ]
end
