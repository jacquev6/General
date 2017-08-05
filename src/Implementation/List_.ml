module Self = struct
  include Traits.Equatable.Different.Make1(Foundations.List_)
  include Foundations.List_
end

include Self

module Specialize(A: sig type t end) = struct
  type t = A.t list

  include (Self: module type of Self with type 'a t := 'a Self.t)
end

module SpecializeEquatable(A: Traits.Equatable.Basic.S0) = struct
  type t = A.t list

  let contains xs x =
    Self.contains xs x ~equal_a:A.equal
end

module Examples = struct
  module A = Foundations.Int

  let repr = [
    ([], "[]");
    ([1], "[1]");
    ([1; 2; 3], "[1; 2; 3]");
  ]

  let equal = [
    [empty; []];
    [[1]];
    [[1; 2; 3]];
  ]

  let different = [
    ([], [1]);
    ([1], [2]);
    ([1; 1; 1], [1; 1; 2]);
    ([1; 1; 1], [1; 1; 1; 1]);
  ]
end

module Tests = struct
  open Testing

  let test = "List" >:: [
    (let module T = Traits.Representable.Tests.Make1(Self)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make1(Self)(Examples) in T.test);
    "reverse" >: (lazy (check_string_list ~expected:["3"; "2"; "1"] (reverse ["1"; "2"; "3"])));
    "append" >: (lazy (check_int_list ~expected:[1; 2; 3; 4; 5; 6] (append [1; 2; 3] [4; 5; 6])));
    "cons" >: (lazy (check_int_list ~expected:[1; 2; 3] (cons 1 [2; 3])));
    "try_head" >: (lazy (check_some_int ~expected:1 (try_head [1; 2; 3])));
    "try_head []" >: (lazy (check_none_int (try_head [])));
    "try_tail" >: (lazy (check_some ~repr:(repr ~repr_a:Int.repr) ~equal:(equal ~equal_a:Int.equal) ~expected:[2; 3] (try_tail [1; 2; 3])));
    "try_tail []" >: (lazy (check_none ~repr:(repr ~repr_a:Float.repr) ~equal:(equal ~equal_a:Float.equal) (try_tail [])));
    "head" >: (lazy (check_int ~expected:1 (head [1; 2; 3])));
    "head []" >: (lazy (expect_exception ~expected:(Exception.Failure "List.head") (lazy (head []))));
    "tail" >: (lazy (check_int_list ~expected:[2; 3] (tail [1; 2; 3])));
    "tail []" >: (lazy (expect_exception ~expected:(Exception.Failure "List.tail") (lazy (tail []))));
    "fold []" >: (lazy (check_int ~expected:0 (fold ~init:0 ~f:(fun _ -> Exception.failure "Don't call me") []))); (*BISECT-IGNORE*)
    "fold" >: (lazy (check_string ~expected:"init-3-4" (fold ~init:"init" ~f:(Format_.apply "%s-%d") [3; 4])));
    "reduce [0]" >: (lazy (check_int ~expected:0 (reduce ~f:(fun _ -> Exception.failure "Don't call me") [0]))); (*BISECT-IGNORE*)
    "reduce" >: (lazy (check_int ~expected:4096 (reduce ~f:Int.exponentiate [2; 3; 4])));
    "try_reduce" >: (lazy (check_some_int ~expected:4096 (try_reduce ~f:Int.exponentiate [2; 3; 4])));
    "try_reduce []" >: (lazy (check_none_int (try_reduce ~f:Int.exponentiate [])));
    "map" >: (lazy (check_string_list ~expected:["1"; "2"; "3"] (map ~f:Int.to_string [1; 2; 3])));
    "iter" >: (lazy (check_int ~expected:4096 (let p = ref 2 in iter ~f:(fun n -> p := Int.exponentiate !p n) [3; 4]; !p)));
  ]
end
