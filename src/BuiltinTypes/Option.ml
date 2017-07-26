open General_.Abbr

include BuiltinTypes_.Option_

module Tests = struct
  open Testing

  module Examples = struct
    module Element = Int

    let repr = [
      (None, "None");
      (Some 42, "Some 42");
    ]

    let equal = [
      [None];
      [Some 42];
    ]

    let different = [
      (None, Some 42);
      (Some 42, Some 43);
    ]
  end

  let test = "Option" >:: [
    "some_if true" >: (lazy (check_some_int ~expected:42 (some_if true (lazy 42))));
    "some_if false" >: (lazy (check_none_int (some_if false (lazy (Exn.failure "Don't call me")))));
    (let module T = Traits.Representable.Tests.Make1(BuiltinTypes_.Option_)(Examples) in T.test);
    "repr None" >: (lazy (check_string ~expected:"None" (repr ~repr:(fun _ -> Exn.failure "Don't call me") None))); (*BISECT-IGNORE*)
    (let module T = Traits.Equatable.Tests.Make1(BuiltinTypes_.Option_)(Examples) in T.test);
  ]
end
