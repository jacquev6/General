type t = exn

include Traits_.Equatable_.S0 with type t := t

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
