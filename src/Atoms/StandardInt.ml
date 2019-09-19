module Make(M: sig
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
end): Facets.FixedWidthInteger.S0 with type t = M.t = struct
  module SelfA = struct
    open M

    type nonrec t = t

    let width = size

    let zero = zero
    let one = one
    let greatest = max_int
    let smallest = min_int

    let of_float = of_float
    let to_float = to_float
    let of_int = of_int
    let to_int = to_int
    let of_string = of_string
    let try_of_string s =
      Exception.or_none (lazy (of_string s))
    let to_string = to_string
    let repr n =
      Format.apply "%s%s" (to_string n) repr_suffix

    let abs = abs

    let succ = succ
    let pred = pred

    let negate = neg
    let add = add
    let subtract = sub
    let multiply = mul
    let divide = div
    let modulo = rem

    let compare = Compare.of_standard compare
    let equal = equal

    module Bitwise = struct
      let logical_and = logand
      let logical_or = logor
      let logical_xor = logxor
      let logical_not = lognot
      let logical_shift_left n ~shift = shift_left n shift
      let logical_shift_right n ~shift = shift_right_logical n shift
      let arithmetic_shift_right n ~shift = shift_right n shift
    end
  end

  module SelfB = struct
    include Facets.Comparable.GreaterLessThan.Make0(SelfA)
    include Facets.Comparable.MinMax.Make0(SelfA)
    include Facets.Equatable.Different.Make0(SelfA)
    include Facets.Ringoid.Square.Make0(SelfA)

    include SelfA
  end

  module SelfC = struct
    include Facets.Ringoid.Exponentiate.Make0(struct
      include SelfB

      let exponentiate_negative_exponent ~exponentiate:_ _ n =
        Exception.invalid_argument "%s.exponentiate: Negative exponent: %i" M.name n
    end)
    include Facets.Comparable.Between.Make0(SelfB)

    include SelfB
  end

  module Self = struct
    module O = struct
      include Facets.Comparable.Operators.Make0(SelfC)
      include Facets.Equatable.Operators.Make0(SelfC)
      include Facets.Ringoid.Operators.Make0(SelfC)

      let (mod) = SelfC.modulo
    end

    include SelfC
  end

  include Self
end
