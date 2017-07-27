open Abbr_
module Lazy = OCamlStandard.Lazy
module Printexc = OCamlStandard.Printexc

module Result = struct
  module Status = struct
    type failure =
      | NotEqual of (string * string)
      | NoException of exn
      | WrongException of exn * exn * Printexc.raw_backtrace option
      | Custom of string

    let failure_repr = function
      | NotEqual (x, y) ->
        Frmt.sprintf "NotEqual (%S, %S)" x y
      | NoException exc ->
        Frmt.sprintf "NoException %s" (Printexc.to_string exc)
      | WrongException (expected, exc, bt) ->
        Frmt.sprintf "WrongException (%s, %s, %s)" (Printexc.to_string expected) (Printexc.to_string exc) (Opt.repr ~repr:Printexc.raw_backtrace_to_string bt)
      | Custom x ->
        Frmt.sprintf "Custom %S" x

    type t =
      | Success
      | Failure of failure
      | Error of exn * Printexc.raw_backtrace option

    let repr = function
      | Success ->
        "Success"
      | Failure reason ->
        Frmt.sprintf "Failure (%s)" (failure_repr reason)
      | Error (exc, bt) ->
        Frmt.sprintf "Error (%s, %s)" (Printexc.to_string exc) (Opt.repr ~repr:Printexc.raw_backtrace_to_string bt)

    let to_string = function
        | Success ->
          "OK"
        | Failure (NotEqual (expected, actual)) ->
          (* @todo split lines, quote each line, display very explicitly. Unless both values are single line. Quote anyway *)
          Frmt.sprintf "FAILED: expected %s, but got %s" expected actual
        | Failure (NoException expected) ->
          Frmt.sprintf "FAILED: expected exception %s not raised" (OCamlStandard.Printexc.to_string expected)
        | Failure (WrongException (expected, exc, None)) ->
          Frmt.sprintf "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" (OCamlStandard.Printexc.to_string expected) (OCamlStandard.Printexc.to_string exc) (*BISECT-IGNORE*) (* Covered only in Javascript *)
        | Failure (WrongException (expected, exc, Some bt)) ->
          Frmt.sprintf "FAILED: expected exception %s not raised, but exception %s raised\n%s"(OCamlStandard.Printexc.to_string expected) (OCamlStandard.Printexc.to_string exc) (OCamlStandard.Printexc.raw_backtrace_to_string bt)
        | Failure (Custom message) ->
          Frmt.sprintf "FAILED: %s" message
        | Error (exc, None) ->
          Frmt.sprintf "ERROR: exception %s raised (no backtrace)" (Printexc.to_string exc)
        | Error (exc, Some bt) ->
          Frmt.sprintf "ERROR: exception %s raised\n%s" (Printexc.to_string exc) (Printexc.raw_backtrace_to_string bt)
  end

  type single = {
    label: string;
    status: Status.t;
  }

  type group = {
    name: string;
    children: t list;
  }

  and t =
    | Single of single
    | Group of group

  let rec repr = function
    | Single {label; status} ->
      Frmt.sprintf "Single {label=%S; status=%s}" label (Status.repr status)
    | Group {name; children} ->
      Frmt.sprintf "Group {name=%S; children=%s}" name (Li.repr ~repr children)

  let equal x y =
    Equate_.Poly.equal x y

  module Counts = struct
    type t = {
      successes: int;
      failures: int;
      errors: int;
    }

    let zero = {successes=0; failures=0; errors=0}

    let of_status = function
      | Status.Success -> {successes=1; failures=0; errors=0}
      | Status.Failure _ -> {successes=0; failures=1; errors=0}
      | Status.Error _ -> {successes=0; failures=0; errors=1}

    let add {successes; failures; errors} {successes=successes'; failures=failures'; errors=errors'} =
      Int.O.{
        successes = successes + successes';
        failures = failures + failures';
        errors = errors + errors';
      }
  end

  let rec decorate_with_counts = function
    | Single {label; status} ->
      `Single (label, status)
    | Group {name; children} ->
      let children = Li.map ~f:decorate_with_counts children in
      let counts =
        children
        |> Li.map ~f:(function
          | `Single (_, status) ->
            Counts.of_status status
          | `Group (_, _, counts) ->
            counts
        )
        |> Li.fold ~init:Counts.zero ~f:Counts.add
      in
      `Group (name, children, counts)

  let to_indented_strings ~verbose =
    let rec aux indent = function
      | `Single (label, status) ->
        if verbose || status <> Status.Success then
          (* @todo Indent potential backtrace or anything else that could span several lines *)
          [Frmt.sprintf "%s%S: %s" indent label (Status.to_string status)]
        else
          []
      | `Group (name, children, {Counts.successes; failures; errors}) ->
        let children =
          children
          |> Li.concat_map ~f:(aux (indent ^ "  "))
        and line =
          if Int.O.(failures + errors = 0) then
            Frmt.sprintf "%s%S (Successes: %i)" indent name successes
          else
            Frmt.sprintf "%s%S (Successes: %i, failures: %i, errors: %i)" indent name successes failures errors
        in
        if verbose || Int.O.(failures + errors <> 0) then
          line::children
        else
          [line]
    in
    function result ->
      result
      |> aux ""
end

exception TestFailure of Result.Status.failure

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


  let run ?(record_backtrace=true) test =
    Printexc.record_backtrace record_backtrace;
    let rec aux = function
      | Group {name; tests} ->
        let children = Li.map ~f:aux tests in
        Result.Group {Result.name; children}
      | Single {label; check} ->
        try
          Lazy.force check;
          Result.Single {Result.label; status=Result.Status.Success}
        with
          | TestFailure reason ->
            Result.Single {Result.label; status=Result.Status.Failure reason}
          | exc ->
            Result.Single {Result.label; status=Result.Status.Error (exc, Opt.some_if (Printexc.backtrace_status ()) (lazy (Printexc.get_raw_backtrace ())))}
    in
    aux test
end

(* Running *)

(*BISECT-IGNORE-BEGIN*) (* Test code *)
let command_line_main ~argv test =
  let verbose =
    match argv with
      | [_; "--verbose"] -> true
      | _ -> false
  in
  let result =
    test
    |> Test.run
    |> Result.decorate_with_counts
  in
  result
  |> Result.to_indented_strings ~verbose
  |> Li.iter ~f:(Frmt.printf "%s\n");
  match result with
    | `Single (_, Result.Status.Success) | `Group (_, _, {Result.Counts.failures=0; errors=0; _}) ->
      0
    | _ -> 1
(*BISECT-IGNORE-END*)

(* Test factories *)

let (>::) name tests =
  Test.(Group {name; tests})

let (>:) label check =
  Test.(Single {label; check})

let (~::) format =
  Frmt.ksprintf ~f:(>::) format

let (~:) format =
  Frmt.ksprintf ~f:(>:) format

(* Checks *)

let fail format =
  Frmt.ksprintf
    ~f:(fun message ->
      Exn.raise (TestFailure (Result.Status.Custom message))
    )
    format

exception NoExceptionRaised
let expect_exception ~expected x =
  try
    ignore (Lazy.force x);
    Exn.raise NoExceptionRaised
  with
    | NoExceptionRaised -> Exn.raise (TestFailure (Result.Status.NoException expected))
    | actual when Exn.equal actual expected -> ()
    | exc -> Exn.raise (TestFailure (Result.Status.WrongException (expected, exc, Opt.some_if (OCamlStandard.Printexc.backtrace_status ()) (lazy (OCamlStandard.Printexc.get_raw_backtrace ())))))

let check ~repr ~equal ~expected actual =
  if not (equal expected actual) then
    Exn.raise (TestFailure (Result.Status.NotEqual (repr expected, repr actual)))

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

let check_list ~repr ~equal ~expected actual =
  check ~repr:(Li.repr ~repr) ~equal:(Li.equal ~equal) ~expected actual

let check_string_list ~expected actual =
  check_list ~repr:Str.repr ~equal:Str.equal ~expected actual
