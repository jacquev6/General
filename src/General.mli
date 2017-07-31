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

module Bool: sig
  type t = bool

  include Traits.Representable.S0 with type t := t
end

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

module Int: sig
  type t = int

  include Concepts.Integer.S0 with type t := t
end

module Std: sig
  module Bool: module type of Bool
  module Exception: module type of Exception
  module Exit: module type of Exit
  module Float: module type of Float
  module Format: module type of Format
  module Int: module type of Int

  include module type of Pervasives_ with module Format := Format
end

module Abbr: sig
  module Bo: module type of Bool
  module Exn: module type of Exception
  module Fl: module type of Float
  module Frmt: module type of Format
  module Int: module type of Int

  include module type of Pervasives_
end

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
