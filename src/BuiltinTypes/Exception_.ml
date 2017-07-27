module SelfA = struct
  type t = exn

  exception Exit = OCamlStandard.Pervasives.Exit

  (* Direct aliases, without named parameter. Rationale: don't add a stack frame. *)
  let raise = OCamlStandard.Pervasives.raise
  let raise_without_backtrace = OCamlStandard.Pervasives.raise_notrace

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
end

module SelfB = struct
  include Traits_.Equatable_.Different.Make0(SelfA)
  include SelfA
end

include SelfB

module O = struct
  include Traits_.Equatable_.Operators.Make0(SelfB)
end
