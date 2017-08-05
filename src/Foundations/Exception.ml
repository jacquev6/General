type t = exn

module OCSPE = OCamlStandard.Printexc

let register_printer = OCSPE.register_printer

include Equate.Poly

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

exception Exit = OCSP.Exit

let raise = OCSP.raise
let raise_without_backtrace = OCSP.raise_notrace

let invalid_argument format =
  Format_.ksprintf
    ~f:(fun message -> raise (InvalidArgument message))
    format

let failure format =
  Format_.ksprintf
    ~f:(fun message -> raise (Failure message))
    format

let to_string = OCSPE.to_string
let repr = to_string

let name = OCSPE.exn_slot_name

let record_backtraces = OCSPE.record_backtrace
let recording_backtraces = OCSPE.backtrace_status

let most_recent_backtrace () =
  Option.some_if (recording_backtraces ()) (lazy (OCSPE.get_raw_backtrace ()))

let or_none x =
  try
    Some (Lazy_.value x)
  with
    | _ -> None
