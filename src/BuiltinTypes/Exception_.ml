module P = OCamlStandard.Pervasives

type t = exn

include Equate_.Poly

exception MatchFailure = Match_failure
exception AssertFailure = Assert_failure
exception InvalidArgument = Invalid_argument
exception Failure = Failure
exception NotFound = Not_found
exception OutOfMemory = Out_of_memory
exception StackOverflow = Stack_overflow
exception SysError = Sys_error
exception EndOfFile = End_of_file
exception DivisionByZero = Division_by_zero
exception SysBlockedIO = Sys_blocked_io
exception UndefinedRecursiveModule = Undefined_recursive_module

exception Exit = P.Exit

(* Direct aliases, without named parameter. Rationale: don't add a stack frame. *)
let raise = P.raise
let raise_without_backtrace = P.raise_notrace

let invalid_argument format =
  Format_.ksprintf
    ~f:(fun message -> raise (InvalidArgument message))
    format

let failure format =
  Format_.ksprintf
    ~f:(fun message -> raise (Failure message))
    format
