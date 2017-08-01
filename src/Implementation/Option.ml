module Self = struct
  include Foundations.Option
  include Traits.Equatable.Different.Make1(Foundations.Option)
  include Traits.Comparable.GreaterLessThan.Make1(Foundations.Option)
  include Traits.Comparable.MinMax.Make1(Foundations.Option)
end

include Self

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

    let ordered = [
      [None; Some 0; Some 1];
    ]
  end

  let test = "Option" >:: [
    (let module T = Traits.Comparable.Tests.Make1(Self)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make1(Self)(Examples) in T.test);
    (let module T = Traits.Representable.Tests.Make1(Self)(Examples) in T.test);
    "some_if true" >: (lazy (check_some_int ~expected:42 (some_if true (lazy 42))));
    "some_if false" >: (lazy (check_none_int (some_if false (lazy (Exception.failure "Don't call me")))));
    "repr None" >: (lazy (check_string ~expected:"None" (repr ~repr:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
  ]
end
