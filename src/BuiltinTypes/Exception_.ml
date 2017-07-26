exception Exit = OCamlStandard.Pervasives.Exit

(* Direct aliases, without named parameter. Rationale: don't add a stack frame. *)
let raise = OCamlStandard.Pervasives.raise
let raise_no_backtrace = OCamlStandard.Pervasives.raise_notrace

let invalid_argument format =
  OCamlStandard.Printf.ksprintf
    OCamlStandard.Pervasives.invalid_arg
    format

let failure format =
  OCamlStandard.Printf.ksprintf
    OCamlStandard.Pervasives.failwith
    format

let equal x y =
  OCamlStandard.Pervasives.(=) x y
