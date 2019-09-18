module Exception: sig
  type t = exn
  include Concepts.Identifiable.S0 with type t := t
  include Traits.Displayable.S0 with type t := t
  exception MatchFailure of (string * int * int)
  exception AssertFailure of (string * int * int)
  exception InvalidArgument of string
  exception Failure of string
  exception NotFound
  exception OutOfMemory
  exception StackOverflow
  exception SysError of string
  exception EndOfFile
  exception DivisionByZero
  exception SysBlockedIO
  exception UndefinedRecursiveModule of (string * int * int)
  exception Exit
  val register_printer: (t -> string option) -> unit
  val record_backtraces: bool -> unit
  val recording_backtraces: unit -> bool
  val most_recent_backtrace: unit -> CallStack.t option
  val raise: t -> 'a
  val raise_without_backtrace: t -> 'a
  val invalid_argument: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a
  val failure: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a
  val failure_if: bool -> ('a, unit, string, string, string, unit) CamlinternalFormatBasics.format6 -> 'a
  val failure_unless: bool -> ('a, unit, string, string, string, unit) CamlinternalFormatBasics.format6 -> 'a
  val name: exn -> string
  val or_none: 'a lazy_t -> 'a option
end

module Exit: sig
  type t = Success | Failure of int
  val of_int: int -> t
  val exit: t -> 'a
  val at_exit: (unit -> unit) -> unit
end

module Function1: sig
  type ('a, 'z) t = 'a -> 'z
  module O: sig
    val (@@): ('a, 'z) t -> 'a -> 'z
    val (|>): 'a -> ('a, 'z) t -> 'z
    val (%): ('a, 'b) t -> ('c, 'a) t -> ('c, 'b) t
  end

  val identity: ('a, 'a) t
  val apply: ('a, 'z) t -> 'a -> 'z
  val rev_apply: 'a -> ('a, 'z) t -> 'z
  val compose: ('a, 'b) t -> ('c, 'a) t -> ('c, 'b) t
end

module Function2: sig
  type ('a, 'b, 'z) t = 'a -> 'b -> 'z
  val flip: ('a, 'b, 'z) t -> ('b, 'a, 'z) t
  val curry: ('a * 'b, 'z) Function1.t -> ('a, 'b, 'z) t
  val uncurry: ('a, 'b, 'z) t -> ('a * 'b, 'z) Function1.t
end

module Function3: sig
  type ('a, 'b, 'c, 'z) t = 'a -> 'b -> 'c -> 'z
  val flip: ('a, 'b, 'c, 'z) t -> ('c, 'b, 'a, 'z) t
  val curry: ('a * 'b * 'c, 'z) Function1.t -> ('a, 'b, 'c, 'z) t
  val uncurry: ('a, 'b, 'c, 'z) t -> ('a * 'b * 'c, 'z) Function1.t
end

module Function4: sig
  type ('a, 'b, 'c, 'd, 'z) t = 'a -> 'b -> 'c -> 'd -> 'z
  val flip: ('a, 'b, 'c, 'd, 'z) t -> ('d, 'c, 'b, 'a, 'z) t
  val curry: ('a * 'b * 'c * 'd, 'z) Function1.t -> ('a, 'b, 'c, 'd, 'z) t
  val uncurry: ('a, 'b, 'c, 'd, 'z) t -> ('a * 'b * 'c * 'd, 'z) Function1.t
end

module Function5: sig
  type ('a, 'b, 'c, 'd, 'e, 'z) t = 'a -> 'b -> 'c -> 'd -> 'e -> 'z
  val flip: ('a, 'b, 'c, 'd, 'e, 'z) t -> ('e, 'd, 'c, 'b, 'a, 'z) t
  val curry: ('a * 'b * 'c * 'd * 'e, 'z) Function1.t -> ('a, 'b, 'c, 'd, 'e, 'z) t
  val uncurry: ('a, 'b, 'c, 'd, 'e, 'z) t -> ('a * 'b * 'c * 'd * 'e, 'z) Function1.t
end

module Unit: sig
  type t = unit
  include Concepts.Able.S0 with type t := t
  val ignore: _ -> t
end

module Bool: sig
  type t = bool
  module O: sig
    include Concepts.Able.Operators.S0 with type t := t
    val not: t -> t
    val (&&): t -> t -> t
    val (||): t -> t -> t
    val xor: t -> t -> t
  end

  include Concepts.Able.S0 with type t := t and module O := O
  include Concepts.Stringable.S0 with type t := t
  val not: t -> t
  val and_: t -> t -> t
  val or_: t -> t -> t
  val xor: t -> t -> t
end

module Char: sig
  type t = char
  include Concepts.Able.S0 with type t := t
  include Traits.Displayable.S0 with type t := t
  include Traits.OfInt.S0 with type t := t
  include Traits.ToInt.S0 with type t := t
  val repeat: t -> len:(int) -> string
end

module Int: sig
  type t = int
  include Concepts.FixedWidthInteger.S0 with type t := t
end

module Int32: sig
  type t = Pervasives.OCamlStandard.Int32.t
  include Concepts.FixedWidthInteger.S0 with type t := t
end

module Int64: sig
  type t = Pervasives.OCamlStandard.Int64.t
  include Concepts.FixedWidthInteger.S0 with type t := t
end

module NativeInt: sig
  type t = Pervasives.OCamlStandard.Nativeint.t
  include Concepts.FixedWidthInteger.S0 with type t := t
end

module BigInt: sig
  type t = Pervasives.OCamlStandard.Big_int.big_int
  include Concepts.Integer.S0 with type t := t
end

module Float: sig
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
  module Class: sig
    type t = Normal | SubNormal | Zero | Infinite | NotANumber
    include Concepts.Able.S0 with type t := t
    val of_float: float -> t
  end
end

module String: sig
  type t = string
  module O: sig
    include Concepts.Able.Operators.S0 with type t := t
    val (^): t -> t -> t
  end

  include Concepts.Able.S0 with type t := t and module O := O
  include Concepts.Stringable.S0 with type t := t
  val of_char: char -> t
  val of_list: char list -> t
  val to_list: t -> char list
  val size: t -> int
  val get: t -> int -> char
  val set: bytes -> int -> char -> unit
  val of_bytes: bytes -> t
  val to_bytes: t -> bytes
  val concat: t -> t -> t
  val substring: t -> pos:(int) -> len:(int) -> t
  val prefix: t -> len:(int) -> t
  val suffix: t -> len:(int) -> t
  val has_prefix: t -> pre:(t) -> bool
  val try_drop_prefix: t -> pre:(t) -> t option
  val drop_prefix: t -> pre:(t) -> t
  val drop_prefix': t -> len:(int) -> t
  val has_suffix: t -> suf:(t) -> bool
  val try_drop_suffix: t -> suf:(t) -> t option
  val drop_suffix: t -> suf:(t) -> t
  val drop_suffix': t -> len:(int) -> t
  val split: t -> sep:(t) -> t list
  val split': t -> seps:(char list) -> t list
  val fold: init:('a) -> t -> f:('a -> char -> 'a) -> 'a
  val filter: t -> f:(char -> bool) -> t
end

module Bytes: sig
  type t = bytes
  include Concepts.Able.S0 with type t := t
  include Traits.Displayable.S0 with type t := t
  val size: t -> int
  val of_string: string -> t
  val get: t -> int -> char
  val set: t -> int -> char -> unit
  val empty: t
  val make: len:(int) -> t
end
