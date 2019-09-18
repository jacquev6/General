type t = float
include Concepts.RealNumber.S0 with type t := t
include Traits.Bounded.S0 with type t := t
val approx_equal: ?precision:(t) -> t -> t -> bool
val epsilon: t
val infinity: t
val negative_infinity: t
val not_a_number: t
val pi: t
val e: t
val of_parts: significand:(t) -> exponent:(int) -> t
val to_parts: t -> t * int
val to_fractional_and_integral: t -> t * t
val sqrt: t -> t
val exp: t -> t
val log: t -> t
val log10: t -> t
val expm1: t -> t
val log1p: t -> t
val cos: t -> t
val sin: t -> t
val tan: t -> t
val acos: t -> t
val asin: t -> t
val atan: t -> t
val atan2: y:(t) -> x:(t) -> t
val hypot: t -> t -> t
val cosh: t -> t
val sinh: t -> t
val tanh: t -> t
val ceil: t -> t
val floor: t -> t
val copy_sign: t -> sign:(t) -> t
