module MakeBasic(M: sig
  type t

  val name: string
  val repr_suffix: string
  val size: int

  val zero: t
  val one: t
  (* val minus_one: t *)
  val neg: t -> t
  val add: t -> t -> t
  val sub: t -> t -> t
  val mul: t -> t -> t
  val div: t -> t -> t
  val rem: t -> t -> t
  val succ: t -> t
  val pred: t -> t
  val abs: t -> t
  val max_int: t
  val min_int: t
  val logand: t -> t -> t
  val logor: t -> t -> t
  val logxor: t -> t -> t
  val lognot: t -> t
  val shift_left: t -> int -> t
  val shift_right: t -> int -> t
  val shift_right_logical: t -> int -> t
  val of_int: int -> t
  val to_int: t -> int
  val of_float: float -> t
  val to_float: t -> float
  val of_string: string -> t
  val to_string: t -> string
  val compare: t -> t -> int
  val equal: t -> t -> bool
end) = struct
  type t = M.t

  let width = M.size

  let zero = M.zero
  let one = M.one
  let greatest = M.max_int
  let smallest = M.min_int

  let of_float = M.of_float
  let to_float = M.to_float
  let of_int = M.of_int
  let to_int = M.to_int

  let of_string s =
    try
      M.of_string s
    with Failure _ -> Exception.invalid_argument "%s.of_string" M.name

  let try_of_string s =
    Exception.or_none (lazy (M.of_string s))

  let to_string = M.to_string

  let repr n =
    Format.apply "%s%s" (to_string n) M.repr_suffix

  let abs = M.abs

  let succ = M.succ
  let pred = M.pred

  let negate = M.neg
  let add = M.add
  let subtract = M.sub
  let multiply = M.mul
  let divide = M.div
  let modulo = M.rem

  let compare = Compare.of_standard M.compare
  let equal = M.equal

  module Bitwise = struct
    let logical_and = M.logand
    let logical_or = M.logor
    let logical_xor = M.logxor
    let logical_not = M.lognot
    let logical_shift_left n ~shift = M.shift_left n shift
    let logical_shift_right n ~shift = M.shift_right_logical n shift
    let arithmetic_shift_right n ~shift = M.shift_right n shift
  end
end

module MakeExtensions(Facets: Facets)(M: sig
  type t

  val name: string
  include Facets.ComparableBasic.S0 with type t := t
  include Facets.EquatableBasic.S0 with type t := t
  include Facets.RingoidBasic.S0 with type t := t
  val modulo: t -> t -> t
end) = struct
  module SelfB = struct
    include M

    include Facets.Comparable.GreaterLessThan.Make0(M)
    include Facets.Comparable.MinMax.Make0(M)
    include Facets.Equatable.Different.Make0(M)
    include Facets.Ringoid.Square.Make0(M)
  end

  module SelfC = struct
    include SelfB

    include Facets.Ringoid.Exponentiate.Make0(struct
      include SelfB

      let exponentiate_negative_exponent ~exponentiate:_ _ n =
        Exception.invalid_argument "%s.exponentiate: Negative exponent: %i" M.name n
    end)
    include Facets.Comparable.Between.Make0(SelfB)
  end

  include (SelfC: module type of SelfC with type t := M.t)

  module O = struct
    include Facets.Comparable.Operators.Make0(SelfC)
    include Facets.Equatable.Operators.Make0(SelfC)
    include Facets.Ringoid.Operators.Make0(SelfC)

    let (mod) = M.modulo
  end
end
