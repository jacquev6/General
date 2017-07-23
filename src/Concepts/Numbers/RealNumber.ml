module Basic = struct
  module type S0 = sig
    include Number.Basic.S0
    include Traits.Comparable.Basic.S0 with type t := t

    val abs: t -> t
    (* @todo val modulo: t -> t -> t *)

    val to_int: t -> int
    val to_float: t -> float
  end
end

module Operators = struct
  module type S0 = sig
    include Number.Operators.S0
    include Traits.Comparable.Operators.S0 with type t := t
  end
end

module Extensions = struct
  module type S0 = sig
    type t

    module O: Operators.S0 with type t := t

    include Number.Extensions.S0 with type t := t and module O := O
    include Traits.Comparable.Extensions.S0 with type t := t and module O := O
  end

  module Make0(B: Basic.S0): S0 with type t := B.t = struct
    module Number_ = Number.Extensions.Make0(B)
    module Comparable_ = Traits.Comparable.Extensions.Make0(B)

    type t = B.t

    module O = struct
      include Number_.O
      include Comparable_.O
    end

    include (Number_: Number.Extensions.S0 with type t := t and module O := O)
    include (Comparable_: Traits.Comparable.Extensions.S0 with type t := t and module O := O)
  end
end

module type S0 = sig
  include Basic.S0
  include Extensions.S0 with type t := t
end

module Examples = struct
  module type S0 = sig
    include Number.Examples.S0
    include Traits.Comparable.Examples.S0 with type t := t
  end
end

module Tests = struct
  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open StdLabels

    open M

    module E = struct
      include E

      let ordered = ordered @ [
        [zero; one];
      ]
    end

    let check = check ~repr ~equal

    let test = "RealNumber" >:: [
      (let module T = Number.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
    ] @ (
      E.negate
      |> List.map ~f:(fun (x, y) ->
        let abs_x = if greater_or_equal x zero then x else y
        and abs_y = if greater_or_equal y zero then y else x in
        [
          ~: "abs %s" (repr x) (lazy (check ~expected:abs_x (abs x)));
          ~: "abs %s" (repr y) (lazy (check ~expected:abs_y (abs y)));
        ]
      )
      |> List.concat
    ) @ [
      "to_int zero" >: (lazy (check_int ~expected:0 (to_int zero)));
      "to_float zero" >: (lazy (check_float_exact ~expected:0. (to_float zero)));
      "to_int one" >: (lazy (check_int ~expected:1 (to_int one)));
      "to_float one" >: (lazy (check_float_exact ~expected:1. (to_float one)));
    ]
  end
end
