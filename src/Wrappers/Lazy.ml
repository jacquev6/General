module Basic = struct
  type 'a t = 'a lazy_t

  let value = OCamlStandard.Lazy.force

  let is_value = OCamlStandard.Lazy.is_val

  let map x ~f =
    lazy (f (value x))
end

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Wrappers/Lazy.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
      open Testing

      let tests = [
        "Lazy: value" >: (lazy (check_int ~expected:42 (value (lazy 42))));
        "Lazy: value exc" >: (lazy (expect_exception ~expected:(Exception.Failure "nope") (lazy (value (lazy (Exception.failure "nope"))))));
        "Lazy: is_value" >: (lazy (
          let x = lazy ((fun () -> 42)()) in
          check_false (is_value x);
          check_int ~expected:42 (value x);
          check_true (is_value x);
        ));
        "Lazy: map" >: (lazy (check_int ~expected:42 (value (map (lazy 21) ~f:(( * ) 2)))));
        "Lazy: map is lazy" >: (lazy (
          let x = lazy (Exception.failure "You called me!") in
          let y = map x ~f:(fun _ -> Exception.failure "Don't call me") in
          expect_exception ~expected:(Exception.Failure "You called me!") (lazy (value y))
        ));
      ]
    end)
  end
end
