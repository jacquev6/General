#include "../Generated/Wrappers/Option.ml"

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
end

(*
module Tests = Tests_.Make(Self)(struct
  module A = Int

  let representations = [
    (None, "None");
    (Some 42, "Some 42");
  ]

  let equalities = [
    [None];
    [Some 42];
  ]

  let differences = [
    (None, Some 42);
    (Some 42, Some 43);
  ]

  let orders = [
    [None; Some 0; Some 1];
  ]
end)(struct
  open Testing

  let tests = [
    "some_if true" >: (lazy (check_some_42 (some_if true (lazy 42))));
    "some_if false" >: (lazy (check_none_int (some_if false (lazy (Exception.failure "Don't call me"))))); (*BISECT-IGNORE*)
    "some_if' true" >: (lazy (check_some_42 (some_if' true 42)));
    "some_if' false" >: (lazy (check_none_int (some_if' false 42)));
    "is_some None" >: (lazy (check_false (is_some None)));
    "is_some Some" >: (lazy (check_true (is_some (Some 42))));
    "is_none None" >: (lazy (check_true (is_none None)));
    "is_none Some" >: (lazy (check_false (is_none (Some 42))));
    "value_def None" >: (lazy (check_string ~expected:"def" (value_def None ~def:"def")));
    "value_def Some" >: (lazy (check_string ~expected:"val" (value_def (Some "val") ~def:"def")));
    "value Some" >: (lazy (check_string ~expected:"val" (value (Some "val"))));
    "value None" >: (lazy (expect_exception ~expected:(Exception.Failure "Option.value") (lazy (value None))));
    "value ~exc None" >: (lazy (expect_exception ~expected:(Exception.Failure "Nope") (lazy (value ~exc:(Exception.Failure "Nope") None))));
    "repr None" >: (lazy (check_string ~expected:"None" (repr ~repr_a:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*) (*BISECT-IGNORE*)
    "map None" >: (lazy (check_none_int (map ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "map Some" >: (lazy (check_some_42 (map ~f:(( * ) 2) (Some 21))));
    "value_map None" >: (lazy (check_42 (value_map ~def:42 ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "value_map Some" >: (lazy (check_42 (value_map ~def:57 ~f:(( * ) 2) (Some 21))));
    "iter None" >: (lazy (iter ~f:(fun _ -> Exception.failure "Don't call me") None)); (*BISECT-IGNORE*)
    "iter Some" >: (lazy (check_42 (let x = ref 0 in iter ~f:(fun n -> x := n) (Some 42); !x)));
    "filter None" >: (lazy (check_none_int (filter ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "filter Some true" >: (lazy (check_some_42 (filter ~f:(fun _ -> true) (Some 42))));
    "filter Some false" >: (lazy (check_none_int (filter ~f:(fun _ -> false) (Some 42))));
    "filter_map None" >: (lazy (check_none_int (filter_map ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "filter_map Some true" >: (lazy (check_some_int ~expected:57 (filter_map ~f:(fun _ -> Some 57) (Some 42))));
    "filter_map Some false" >: (lazy (check_none_int (filter_map ~f:(fun _ -> None) (Some 42))));
  ]
end)
*)
