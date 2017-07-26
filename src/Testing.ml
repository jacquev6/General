open General_.Abbr
module Lazy = OCamlStandard.Lazy
module Printexc = OCamlStandard.Printexc
module Printf = OCamlStandard.Printf

module Test = struct
  type single = {
    label: string;
    check: unit lazy_t;
  }

  type group = {
    name: string;
    tests: t list;
  }

  and t =
    | Single of single
    | Group of group
end

module type Testable = sig
  val test: Test.t
end

module Result = struct
  type failure =
    | NotEqual of (string * string)
    | NoException of exn
    | WrongException of exn * exn * Printexc.raw_backtrace option
    | Custom of string

  type status =
    | Success
    | Failed of failure
    | Error of exn * Printexc.raw_backtrace option

  type single = {
    label: string;
    status: status;
  }

  type group = {
    name: string;
    successes: int;
    failures: int;
    errors: int;
    children: t list;
  }

  and t =
    | Single of single
    | Group of group
end

let string_of_status = Result.(function
    | Success ->
      "OK"
    | Failed (NotEqual (expected, actual)) ->
      (* @todo split lines, quote each line, display very explicitly. Unless both values are single line. Quote anyway *)
      Printf.sprintf "FAILED: expected %s, but got %s" expected actual
    | Failed (NoException expected) ->
      OCamlStandard.Printf.sprintf "FAILED: expected exception %s not raised" (OCamlStandard.Printexc.to_string expected)
    | Failed (WrongException (expected, exc, None)) ->
      OCamlStandard.Printf.sprintf "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" (OCamlStandard.Printexc.to_string expected) (OCamlStandard.Printexc.to_string exc) (*BISECT-IGNORE*) (* Covered only in Javascript *)
    | Failed (WrongException (expected, exc, Some bt)) ->
      OCamlStandard.Printf.sprintf "FAILED: expected exception %s not raised, but exception %s raised\n%s"(OCamlStandard.Printexc.to_string expected) (OCamlStandard.Printexc.to_string exc) (OCamlStandard.Printexc.raw_backtrace_to_string bt)
    | Failed (Custom message) ->
      Printf.sprintf "FAILED: %s" message
    | Error (exc, None) ->
      Printf.sprintf "ERROR: exception %s raised (no backtrace)" (Printexc.to_string exc)
    | Error (exc, Some bt) ->
      Printf.sprintf "ERROR: exception %s raised\n%s" (Printexc.to_string exc) (Printexc.raw_backtrace_to_string bt)
)

exception TestFailure of Result.failure

let run test =
  Printexc.record_backtrace true;
  let single {Test.label; check} =
    try
      Lazy.force check;
      {Result.label; status=Result.Success}
    with
      | TestFailure reason -> {Result.label; status=Result.Failed reason}
      | exc -> {Result.label; status=Result.Error (exc, if Printexc.backtrace_status () then Some (Printexc.get_raw_backtrace ()) else None)}
  in
  let rec group {Test.name; tests} =
    let children = Li.map ~f:aux tests in
    let (successes, failures, errors) =
      Li.fold ~init:(0, 0, 0) children ~f:Int.O.(fun (s, f, e) -> function
        | Result.Single {Result.status=Result.Success; _} -> (s + 1, f, e)
        | Result.Single {Result.status=Result.Failed _; _} -> (s, f + 1, e)
        | Result.Single {Result.status=Result.Error _; _} -> (s, f, e + 1)
        | Result.Group {Result.successes; failures; errors; _} -> (s + successes, f + failures, e + errors)
      )
    in
    {Result.name; successes; failures; errors; children}
  and aux = function
    | Test.Single s -> Result.Single (single s)
    | Test.Group g -> Result.Group (group g)
  in
  aux test

let string_of_result result = Ref.O.(
  let report = Ref.of_contents "" in
  let rec aux indent = function
    | Result.Group {Result.name; successes; failures=0; errors=0; _} ->
      report := !report ^ Printf.sprintf "%s%s (Success: %i)\n" indent name successes
    | Result.Group  {Result.name; successes; failures; errors; children}  ->
      report := !report ^ Printf.sprintf "%s%s (Success: %i, failure: %i, error: %i)\n" indent name successes failures errors;
      Li.iter children ~f:(aux (indent ^ "  "))
    | Result.Single {Result.status=Result.Success; _} -> ()
    | Result.Single {Result.label; status} -> report := !report ^ Printf.sprintf "%s%s: %s\n" indent label (string_of_status status)
  in aux "" result;
  !report
)

let report_to_console result =
  result |> string_of_result |> Printf.printf "%s";
  match result with
    | Result.Single {Result.status=Result.Success; _}
    | Result.Group {Result.failures=0; errors=0; _} -> ()
    | _ -> exit 1

(* Test factories *)

let (>::) name tests =
  Test.(Group {name; tests})

let (>:) label check =
  Test.(Single {label; check})

let (~::) format =
  Printf.ksprintf (>::) format

let (~:) format =
  Printf.ksprintf (>:) format

(* Checks *)

let fail format =
  Printf.ksprintf
    (fun message ->
      Exn.raise (TestFailure (Result.Custom message))
    )
    format

exception FunctionReturned
let expect_exception ~expected x =
  try
    ignore (Lazy.force x);
    Exn.raise FunctionReturned
  with
    | FunctionReturned -> Exn.raise (TestFailure (Result.NoException expected))
    | actual when Exn.equal actual expected -> ()
    | exc -> Exn.raise (TestFailure (Result.WrongException (expected, exc, Opt.some_if (OCamlStandard.Printexc.backtrace_status ()) (lazy (OCamlStandard.Printexc.get_raw_backtrace ())))))

let check ~repr ~equal ~expected actual =
  if not (equal expected actual) then
    Exn.raise (TestFailure (Result.NotEqual (repr expected, repr actual)))

let check_bool ~expected actual =
  check ~repr:Bo.repr ~equal:Bo.equal ~expected actual

let check_true actual =
  check_bool ~expected:true actual

let check_false actual =
  check_bool ~expected:false actual

let check_string ~expected actual =
  check ~repr:Str.repr ~equal:Str.equal ~expected actual

let check_int ~expected actual =
  check ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_float_exact ~expected actual =
  check ~repr:Fl.repr ~equal:Fl.equal ~expected actual

let check_option ~repr ~equal ~expected actual =
  check ~repr:(Opt.repr ~repr) ~equal:(Opt.equal ~equal) ~expected actual

let check_int_option ~expected actual =
  check_option ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_some_int ~expected actual =
  check_int_option ~expected:(Some expected) actual

let check_none_int actual =
  check_int_option ~expected:None actual
