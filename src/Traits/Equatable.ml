module Basic = struct
  module type S0 = sig
    type t

    val equal: t -> t -> bool
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (=): t -> t -> bool
    val (<>): t -> t -> bool
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    val different: t -> t -> bool

    module O: Operators.S0 with type t := t
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    open B

    let different x y =
      not (equal x y)

    module O = struct
      let (=) x y =
        equal x y

      let (<>) x y =
        different x y
    end
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end
module Testable = struct
  module type S0 = sig
    include S0
    include Representable.S0 with type t := t

    val equal_lists: t list list
    val different_pairs: (t * t) list
  end
end

module Tests = struct
  module Make0(M: Testable.S0) = struct
    open M
    open Testing
    open StdLabels

    (* @todo (Make terminal recursive and) Put in General.List *)
    let rec cartesian_product xs ys =
      match xs with
        | [] -> []
        | x::xs -> (List.map ys ~f:(fun y -> (x, y))) @ (cartesian_product xs ys)

    let test = "Equatable" >::: (
      equal_lists
      |> List.map ~f:(fun xs ->
        cartesian_product xs xs
        |> List.map ~f:(fun (x, y) ->
          [
            (Printf.sprintf "equal %s %s" (repr x) (repr y)) >:: (fun () -> check_true (equal x y));
            (Printf.sprintf "different %s %s" (repr x) (repr y)) >:: (fun () -> check_false (different x y));
            (Printf.sprintf "%s = %s" (repr x) (repr y)) >:: (fun () -> check_true (x = y));
            (Printf.sprintf "%s <> %s" (repr x) (repr y)) >:: (fun () -> check_false (x <> y));
          ]
        )
        |> List.concat
      )
      |> List.concat
    ) @ (
      different_pairs
      |> List.map ~f:(fun (x, y) ->
        [
          (Printf.sprintf "equal %s %s" (repr x) (repr y)) >:: (fun () -> check_false (equal x y));
          (Printf.sprintf "different %s %s" (repr x) (repr y)) >:: (fun () -> check_true (different x y));
          (Printf.sprintf "%s = %s" (repr x) (repr y)) >:: (fun () -> check_false (x = y));
          (Printf.sprintf "%s <> %s" (repr x) (repr y)) >:: (fun () -> check_true (x <> y));
        ]
      )
      |> List.concat
    )
  end
end
