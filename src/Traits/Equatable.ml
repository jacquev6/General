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

    let different a b =
      not (equal a b)

    module O = struct
      let (=) = equal
      let (<>) = different
    end
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end

module Tests = struct
  module Make0(M: sig
    include S0
    include Representable.S0 with type t := t

    val equality_classes: t list list
  end) = struct
    open M
    open Testing
    open StdLabels

    (* @todo (Make terminal recursive and) Put in General.List *)
    let rec cartesian_product xs ys =
      match xs with
        | [] -> []
        | x::xs -> (List.map ys ~f:(fun y -> (x, y))) @ (cartesian_product xs ys)

    let test = "Equatable" >::: (
      cartesian_product equality_classes equality_classes
      |> List.map ~f:(fun (xs, ys) ->
        let eq = xs == ys in
        cartesian_product xs ys
        |> List.map ~f:(fun (x, y) ->
          [
            (Printf.sprintf "equal %s %s" (repr x) (repr y)) >:: (fun () -> check_bool ~expected:eq (equal x y));
            (Printf.sprintf "different %s %s" (repr x) (repr y)) >:: (fun () -> check_bool ~expected:(not eq) (different x y));
            (Printf.sprintf "%s = %s" (repr x) (repr y)) >:: (fun () -> check_bool ~expected:eq (x = y));
            (Printf.sprintf "%s <> %s" (repr x) (repr y)) >:: (fun () -> check_bool ~expected:(not eq) (x <> y));
          ]
        )
        |> List.concat
      )
      |> List.concat
    )
  end
end
