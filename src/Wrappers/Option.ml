module Basic = struct
  type 'a t = 'a option

  let equal x y ~equal_a =
    match (x, y) with
      | (None, None) -> true
      | (None, Some _) | (Some _, None) -> false
      | (Some x, Some y) -> equal_a x y

  let compare x y ~compare_a =
    match (x, y) with
      | (None, None) -> Compare.EQ
      | (None, Some _) -> Compare.LT
      | (Some _, None) -> Compare.GT
      | (Some x, Some y) -> compare_a x y

  let repr x ~repr_a =
    match x with
      | None -> "None"
      | Some x -> Format.apply "Some %s" (repr_a x)

  let none = None

  let some x =
    Some x

  let some_if condition value =
    if condition then Some (Lazy.value value) else None

  let some_if' condition value =
    if condition then Some value else None

  let value_def x ~def =
    match x with
      | Some x -> x
      | None -> def

  let value ?(exc=Failure "Option.value") x =
    match x with
      | Some x -> x
      | None -> OCSP.raise exc

  (* @todo Why does (o |> value) complain about missing ?exc, but (ss |> StrLi.join) doesn't complain about ?sep ? *)

  let or_failure format =
    Format.with_result
      ~f:(fun message ->
        function
        | None ->
          Exception.(raise (Failure message))
        | Some x ->
          x
      )
      format

  let map x ~f =
    match x with
      | None -> None
      | Some x -> Some (f x)

  let value_map x ~def ~f =
    match x with
      | None -> def
      | Some x -> f x

  let is_some = function
    | None -> false
    | Some _ -> true

  let is_none = function
    | None -> true
    | Some _ -> false

  let iter x ~f =
    match x with
      | None -> ()
      | Some x -> f x

  let filter x ~f =
    match x with
      | None -> None
      | Some x -> some_if' (f x) x

  let filter_map x ~f =
    match x with
      | None -> None
      | Some x -> (f x)
end

module Extended(Facets: Facets) = struct
  module SelfA = struct
    include Basic
    include Facets.Equatable.Different.Make1(Basic)
    include Facets.Comparable.GreaterLessThan.Make1(Basic)
    include Facets.Comparable.MinMax.Make1(Basic)
  end

  module Self = struct
    include SelfA
    include Facets.Comparable.Between.Make1(SelfA)
  end

  module Specialize(A: sig type t end) = struct
    type t = A.t option

    include (Self: module type of Self with type 'a t := 'a Self.t)
  end

  include Self

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Wrappers/Option.ml"

    include Tests_.Make(Self)(struct
      module A = Int

      let values = [None; Some 42]

      let conversions_to_string = [
        (None, "None");
        (Some 42, "Some 42");
      ]

      let representations = conversions_to_string

      let equalities = []

      let differences = [
        (None, Some 42);
        (Some 42, Some 43);
      ]

      let strict_orders = [
        [None; Some 0; Some 1];
      ]

      let order_classes = []
    end)(struct
      open Testing

      let tests = [
        "Option: some_if true" >: (lazy (check_some_int ~expected:42 (some_if true (lazy 42))));
        "Option: some_if false" >: (lazy (check_none_int (some_if false (lazy (Exception.failure "Don't call me"))))); (*BISECT-IGNORE*)
        "Option: some_if' true" >: (lazy (check_some_int ~expected:42 (some_if' true 42)));
        "Option: some_if' false" >: (lazy (check_none_int (some_if' false 42)));
        "Option: is_some None" >: (lazy (check_false (is_some None)));
        "Option: is_some Some" >: (lazy (check_true (is_some (Some 42))));
        "Option: is_none None" >: (lazy (check_true (is_none None)));
        "Option: is_none Some" >: (lazy (check_false (is_none (Some 42))));
        "Option: value_def None" >: (lazy (check_string ~expected:"def" (value_def None ~def:"def")));
        "Option: value_def Some" >: (lazy (check_string ~expected:"val" (value_def (Some "val") ~def:"def")));
        "Option: value Some" >: (lazy (check_string ~expected:"val" (value (Some "val"))));
        "Option: value None" >: (lazy (expect_exception ~expected:(Exception.Failure "Option.value") (lazy (value None))));
        "Option: value ~exc None" >: (lazy (expect_exception ~expected:(Exception.Failure "Nope") (lazy (value ~exc:(Exception.Failure "Nope") None))));
        "Option: repr None" >: (lazy (check_string ~expected:"None" (repr ~repr_a:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*) (*BISECT-IGNORE*)
        "Option: map None" >: (lazy (check_none_int (map ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
        "Option: map Some" >: (lazy (check_some_int ~expected:42 (map ~f:(OCSP.( * ) 2) (Some 21))));
        "Option: value_map None" >: (lazy (check_int ~expected:42 (value_map ~def:42 ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
        "Option: value_map Some" >: (lazy (check_int ~expected:42 (value_map ~def:57 ~f:(OCSP.( * ) 2) (Some 21))));
        "Option: iter None" >: (lazy (iter ~f:(fun _ -> Exception.failure "Don't call me") None)); (*BISECT-IGNORE*)
        "Option: iter Some" >: (lazy (check_int ~expected:42 (let x = ref 0 in iter ~f:(fun n -> x := n) (Some 42); !x)));
        "Option: filter None" >: (lazy (check_none_int (filter ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
        "Option: filter Some true" >: (lazy (check_some_int ~expected:42 (filter ~f:(fun _ -> true) (Some 42))));
        "Option: filter Some false" >: (lazy (check_none_int (filter ~f:(fun _ -> false) (Some 42))));
        "Option: filter_map None" >: (lazy (check_none_int (filter_map ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
        "Option: filter_map Some true" >: (lazy (check_some_int ~expected:57 (filter_map ~f:(fun _ -> Some 57) (Some 42))));
        "Option: filter_map Some false" >: (lazy (check_none_int (filter_map ~f:(fun _ -> None) (Some 42))));
      ]
    end)
  end
end
