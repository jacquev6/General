(* Basics *)

module Compare: sig
  type t = LT | EQ | GT

  module Poly: sig include Traits.Comparable.SP end
end

module Equate: sig
  module Poly: sig include Traits.Equatable.SP end

  module Physical: Traits.Equatable.SP with module O := Poly.O (* SP without module O. Should we create a sig in the trait for that? *)
end

module Traits: module type of Traits

module Concepts: module type of Concepts

(* Technical, utility modules *)

module Exception: sig
  type t = exn

  include Traits.Equatable.S0 with type t := t

  (*
  Aliases for all predefined exceptions, checked in OCaml:
  - 4.00 (https://caml.inria.fr/pub/docs/manual-ocaml-4.00/manual034.html#toc154)
  - 4.05 (https://caml.inria.fr/pub/docs/manual-ocaml-4.05/core.html#sec527)
  *)
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

  (* Aliases for all exceptions in Pervasives, checked in OCaml:
  - 4.00 (https://caml.inria.fr/pub/docs/manual-ocaml-4.00/libref/Pervasives.html)
  - 4.05 (https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libref/Pervasives.html)
  *)
  exception Exit

  val raise: t -> 'a

  val raise_without_backtrace: t -> 'a

  val invalid_argument: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val failure: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a
end

module Exit: sig
  val exit: int -> unit

  val at_exit: (unit -> unit) -> unit
end

(* Functions *)

module Function: sig
  type ('a, 'b) t = 'a -> 'b

  val identity: 'a -> 'a

  val apply: ('a, 'b) t -> 'a -> 'b
  val rev_apply: 'a -> ('a, 'b) t -> 'b

  module O: sig
    val (@@): ('a, 'b) t -> 'a -> 'b
    val (|>): 'a -> ('a, 'b) t -> 'b
  end
end

(* Atomic values *)

module Unit: sig
  type t = unit

  val ignore: 'a -> t
end

module Bool: sig
  type t = bool

  include Traits.Representable.S0 with type t := t
  include Traits.Displayable.S0 with type t := t

  val of_string: string -> t

  val not: t -> t
  val and_: t -> t -> t
  val or_: t -> t -> t

  module O: sig
    val not: t -> t
    val (&&): t -> t -> t
    val (||): t -> t -> t
  end
end

module Char: sig
  type t = char

  val of_int: int -> t
  val to_int: t -> int
end

module Int: sig
  type t = int

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t

  module Bitwise: sig
    val logical_and: t -> t -> t
    val logical_or: t -> t -> t
    val logical_xor: t -> t -> t
    val logical_not: t -> t
    val logical_shift_left: t -> shift:t -> t
    val logical_shift_right: t -> shift:t -> t
    val arithmetic_shift_right: t -> shift:t -> t
  end
end

module Float: sig
  type t = float

  include Concepts.RealNumber.S0 with type t := t

  val epsilon: t
  val smallest: t
  val greatest: t
  val infinity: t
  val negative_infinity: t
  val not_a_number: t
  val pi: float
  val e: float

  val of_parts: significand:float -> exponent:int -> t
  val to_parts: t -> float * int
  val to_fractional_and_integral: t -> float * float

  val sqrt: float -> float

  val exp: float -> float
  val log: float -> float
  val log10: float -> float
  val expm1: float -> float
  val log1p: float -> float

  val cos: float -> float
  val sin: float -> float
  val tan: float -> float
  val acos: float -> float
  val asin: float -> float
  val atan: float -> float
  val atan2: y:float -> x:float -> float
  val hypot: float -> float -> float
  val cosh: float -> float
  val sinh: float -> float
  val tanh: float -> float

  val ceil: float -> float
  val floor: float -> float
  val copy_sign: t -> sign:t -> t

  module Class: sig
    type t =
      | Normal
      | SubNormal
      | Zero
      | Infinite
      | NotANumber

    include Traits.Representable.S0 with type t := t

    val of_float: float -> t
  end
end

module String: sig
  type t = string

  module O: sig
    include Traits.Comparable.Operators.S0 with type t := t
    include Traits.Equatable.Operators.S0 with type t := t
    val (^): t -> t -> t
  end

  include Traits.Representable.S0 with type t := t
  include Traits.Displayable.S0 with type t := t
  include Traits.Comparable.S0 with type t := t and module O := O
  include Traits.Equatable.S0 with type t := t and module O := O

  val concat: t -> t -> t
end

(* Fixed-size containers *)

module Option: sig
  type 'a t = 'a option
end

module Lazy: sig
  type 'a t = 'a lazy_t
end

module Reference: sig
  type 'a t = 'a OCamlStandard.Pervasives.ref = {mutable contents: 'a}

  val of_contents: 'a -> 'a t
  val contents: 'a t -> 'a
  val assign: 'a t -> 'a -> unit

  module O: sig
    val (!): 'a t -> 'a
    val (:=): 'a t -> 'a -> unit
  end

  module Specialize(E: sig type t end): sig
    type nonrec t = E.t t

    val of_contents: E.t -> t
    val contents: t -> E.t
    val assign: t -> E.t -> unit

    module O: sig
      val (!): t -> E.t
      val (:=): t -> E.t -> unit
    end
  end

  module SpecializePredSucc(E: Traits.PredSucc.S0): sig
    val increment: E.t t -> unit
    val decrement: E.t t -> unit
  end
end

module Tuple2: sig
  type ('a, 'b) t = 'a * 'b

  val get_0: ('a, _) t -> 'a
  val get_1: (_, 'b) t -> 'b
end

(* Specializations of fixed-size containers *)

module IntReference: sig
  type t = int Reference.t

  val of_contents: int -> t
  val contents: t -> int
  val assign: t -> int -> unit

  val increment: t -> unit
  val decrement: t -> unit

  module O: sig
    val (!): t -> int
    val (:=): t -> int -> unit
  end
end

(* Input/output *)

module Format: sig
  type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6

  (* From Pervasives:
  type ('a, 'b, 'c, 'd) format4 = ('a, 'b, 'c, 'c, 'c, 'd) format6
  type ('a, 'b, 'c) format = ('a, 'b, 'c, 'c, 'c, 'c) format6 *)

  val ksprintf: ('b, unit, string, string, string, 'a) t -> f:(string -> 'a) -> 'b

  val sprintf : ('a, unit, string, string, string, string) t -> 'a

  val printf : ('a, OCamlStandard.Pervasives.out_channel, unit, unit, unit, unit) t -> 'a

  val to_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> string

  val of_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('a, 'b, 'c, 'd, 'e, 'f) t

  val concat: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('f, 'b, 'c, 'e, 'g, 'h) t -> ('a, 'b, 'c, 'd, 'g, 'h) t
end

(* Testing *)

module Testing: sig
  module Result: sig
    (* @todo Publish this type (so that clients can write reports) *)
    type t
  end

  module Test: sig
    type t = Testing.Test.t

    val run: ?record_backtrace:bool -> t -> Result.t
  end

  val command_line_main: argv:string list -> Test.t -> int (* @todo Should we have a type for exit codes? (In the module containing exit) *)

  val (>::): string -> Test.t list -> Test.t

  val (>:): string -> unit lazy_t -> Test.t

  val (~:): ('a, unit, string, string, string, unit lazy_t -> Test.t) CamlinternalFormatBasics.format6 -> 'a

  val (~::): ('a, unit, string, string, string, Test.t list -> Test.t) CamlinternalFormatBasics.format6 -> 'a

  val fail: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val check: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a -> unit

  val check_string: expected:string -> string -> unit

  val check_bool: expected:bool -> bool -> unit

  val check_int: expected:int -> int -> unit

  val check_true: bool -> unit

  val check_false: bool -> unit
end

(* Modules to be opened *)

module Pervasives: sig
  include module type of Foundations.ResetPervasives
  include module type of Foundations.ResetStandardLibrary
  include module type of Foundations.PervasivesWhitelist
end

module Std: sig
  module Bool: module type of Bool
  module Char: module type of Char
  module Exception: module type of Exception
  module Exit: module type of Exit
  module Float: module type of Float
  module Format: module type of Format
  module Function: module type of Function
  module Int: module type of Int
  module Lazy: module type of Lazy
  module Option: module type of Option
  module Reference: module type of Reference
  module String: module type of String
  module Tuple2: module type of Tuple2
  module Unit: module type of Unit

  module IntReference: module type of IntReference

  include module type of Pervasives
  with module Char := Char
  and module Format := Format
  and module Lazy := Lazy
  and module String := String
end

module Abbr: sig
  module Bo: module type of Bool
  module Ch: module type of Char
  module Exit: module type of Exit
  module Exn: module type of Exception
  module Fl: module type of Float
  module Frmt: module type of Format
  module Fun: module type of Function
  module Int: module type of Int
  module Laz: module type of Lazy
  module Opt: module type of Option
  module Ref: module type of Reference
  module Str: module type of String
  module Tu2: module type of Tuple2
  module Unit: module type of Unit

  module IntRef: module type of IntReference

  include module type of Pervasives
end
