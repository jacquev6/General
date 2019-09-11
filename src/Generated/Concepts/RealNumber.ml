module Operators = struct
  module type S0 = sig
    type t
    include Number.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t
    val ( mod ): t -> t -> t
  end
  module Make0(M: sig
    type t
    val modulo: t -> t -> t
  end) = struct
    let ( mod ) = M.modulo
  end
end
module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Number.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O
  include Traits.ToStandardNumbers.S0 with type t := t
  val abs: t -> t
  val modulo: t -> t -> t
end
module Tests = struct
  module Examples = struct
    module type S0 = sig
      type t
      include Number.Tests.Examples.S0 with type t := t
      include Traits.Comparable.Tests.Examples.S0 with type t := t
    end
  end
  module Testable = struct
    module type S0 = sig
      include S0
    end
  end
  module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    module E = struct
      include E
      let ordered = ordered @ [
          [M.zero; M.one];
      ]
    end
    let test = "RealNumber" >:: [
      (let module T = Number.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
    ] @ (
      (
          E.negate
          |> List.flat_map ~f:(fun (x, y) ->
              let abs_x = M.(if greater_or_equal x zero then x else y)
              and abs_y = M.(if greater_or_equal y zero then y else x) in
              [
                  ~: "abs %s" (M.repr x) (lazy M.(check ~repr ~equal ~expected:abs_x (abs x)));
                  ~: "abs %s" (M.repr y) (lazy M.(check ~repr ~equal ~expected:abs_y (abs y)));
              ]
          )
      ) @ [
          "to_int zero" >: (lazy (check_int ~expected:0 M.(to_int zero)));
          "to_float zero" >: (lazy (check_float_exact ~expected:0. M.(to_float zero)));
          "to_int one" >: (lazy (check_int ~expected:1 M.(to_int one)));
          "to_float one" >: (lazy (check_float_exact ~expected:1. M.(to_float one)));
      ]
    )
  end
end
