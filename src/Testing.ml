open Foundations

module OCSPex = OCamlStandard.Printexc

module Result = struct
  module Status = struct
    type failure =
      | NotEqual of (string * string)
      | NoException of exn
      | WrongException of exn * exn * OCSPex.raw_backtrace option
      | Custom of string

    let failure_repr = function
      | NotEqual (x, y) ->
        Format_.sprintf "NotEqual (%S, %S)" x y
      | NoException exc ->
        Format_.sprintf "NoException %s" (OCSPex.to_string exc)
      | WrongException (expected, exc, bt) ->
        Format_.sprintf "WrongException (%s, %s, %s)" (OCSPex.to_string expected) (OCSPex.to_string exc) (Option.repr ~repr:OCSPex.raw_backtrace_to_string bt)
      | Custom x ->
        Format_.sprintf "Custom %S" x

    type t =
      | Success
      | Failure of failure
      | Error of exn * OCSPex.raw_backtrace option

    let repr = function
      | Success ->
        "Success"
      | Failure reason ->
        Format_.sprintf "Failure (%s)" (failure_repr reason)
      | Error (exc, bt) ->
        Format_.sprintf "Error (%s, %s)" (OCSPex.to_string exc) (Option.repr ~repr:OCSPex.raw_backtrace_to_string bt)

    let to_string = function
        | Success ->
          "OK"
        | Failure (NotEqual (expected, actual)) ->
          (* @todo split lines, quote each line, display very explicitly. Unless both values are single line. Quote anyway *)
          Format_.sprintf "FAILED: expected %s, but got %s" expected actual
        | Failure (NoException expected) ->
          Format_.sprintf "FAILED: expected exception %s not raised" (OCSPex.to_string expected)
        | Failure (WrongException (expected, exc, None)) ->
          Format_.sprintf "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" (OCSPex.to_string expected) (OCSPex.to_string exc)
        | Failure (WrongException (expected, exc, Some bt)) ->
          Format_.sprintf "FAILED: expected exception %s not raised, but exception %s raised\n%s"(OCSPex.to_string expected) (OCSPex.to_string exc) (OCSPex.raw_backtrace_to_string bt)
        | Failure (Custom message) ->
          Format_.sprintf "FAILED: %s" message
        | Error (exc, None) ->
          Format_.sprintf "ERROR: exception %s raised (no backtrace)" (OCSPex.to_string exc)
        | Error (exc, Some bt) ->
          Format_.sprintf "ERROR: exception %s raised\n%s" (OCSPex.to_string exc) (OCSPex.raw_backtrace_to_string bt)
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
      Format_.sprintf "Single {label=%S; status=%s}" label (Status.repr status)
    | Group {name; children} ->
      Format_.sprintf "Group {name=%S; children=%s}" name (List_.repr ~repr children)

  let equal x y =
    Equate.Poly.equal x y

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
      let children = List_.map ~f:decorate_with_counts children in
      let counts =
        children
        |> List_.map ~f:(function
          | `Single (_, status) ->
            Counts.of_status status
          | `Group (_, _, counts) ->
            counts
        )
        |> List_.fold ~init:Counts.zero ~f:Counts.add
      in
      `Group (name, children, counts)

  let to_indented_strings ~verbose =
    let rec aux indent = function
      | `Single (label, status) ->
        if verbose || status <> Status.Success then
          (* @todo Indent potential backtrace or anything else that could span several lines *)
          [Format_.sprintf "%s%S: %s" indent label (Status.to_string status)]
        else
          []
      | `Group (name, children, {Counts.successes; failures; errors}) ->
        let children =
          children
          |> List_.concat_map ~f:(aux (indent ^ "  "))
        and line =
          if Int.O.(failures + errors = 0) then
            Format_.sprintf "%s%S (Successes: %i)" indent name successes
          else
            Format_.sprintf "%s%S (Successes: %i, failures: %i, errors: %i)" indent name successes failures errors
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
    OCSPex.record_backtrace record_backtrace;
    let rec aux = function
      | Group {name; tests} ->
        let children = List_.map ~f:aux tests in
        Result.Group {Result.name; children}
      | Single {label; check} ->
        try
          Lazy_.value check;
          Result.Single {Result.label; status=Result.Status.Success}
        with
          | TestFailure reason ->
            Result.Single {Result.label; status=Result.Status.Failure reason}
          | exc ->
            Result.Single {Result.label; status=Result.Status.Error (exc, Option.some_if (OCSPex.backtrace_status ()) (lazy (OCSPex.get_raw_backtrace ())))}
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
  |> List_.iter ~f:(Format_.printf "%s\n");
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
  Format_.ksprintf ~f:(>::) format

let (~:) format =
  Format_.ksprintf ~f:(>:) format

(* Checks *)

let fail format =
  Format_.ksprintf
    ~f:(fun message ->
      Exception.raise (TestFailure (Result.Status.Custom message))
    )
    format

exception NoExceptionRaised
let expect_exception ~expected x =
  try
    ignore (Lazy_.value x);
    Exception.raise NoExceptionRaised
  with
    | NoExceptionRaised -> Exception.raise (TestFailure (Result.Status.NoException expected))
    | actual when Exception.equal actual expected -> ()
    | exc -> Exception.raise (TestFailure (Result.Status.WrongException (expected, exc, Option.some_if (OCSPex.backtrace_status ()) (lazy (OCSPex.get_raw_backtrace ())))))

let check ~repr ~equal ~expected actual =
  if not (equal expected actual) then
    Exception.raise (TestFailure (Result.Status.NotEqual (repr expected, repr actual)))

let check_poly ~repr ~expected actual =
  check ~repr ~equal:Equate.Poly.equal ~expected actual

let check_bool ~expected actual =
  check ~repr:Bool.repr ~equal:Bool.equal ~expected actual

let check_true actual =
  check_bool ~expected:true actual

let check_false actual =
  check_bool ~expected:false actual

let check_string ~expected actual =
  check ~repr:String_.repr ~equal:String_.equal ~expected actual

let check_int ~expected actual =
  check ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_42 actual =
  check ~repr:Int.repr ~equal:Int.equal ~expected:42 actual

let check_float_exact ~expected actual =
  check ~repr:Float.repr ~equal:Float.equal ~expected actual

let check_option ~repr ~equal ~expected actual =
  check ~repr:(Option.repr ~repr) ~equal:(Option.equal ~equal) ~expected actual

let check_some ~repr ~equal ~expected actual =
  check_option ~repr ~equal ~expected:(Some expected) actual

let check_none ~repr ~equal actual =
  check_option ~repr ~equal ~expected:None actual

let check_int_option ~expected actual =
  check_option ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_some_int ~expected actual =
  check_int_option ~expected:(Some expected) actual

let check_some_42 actual =
  check_some_int ~expected:42 actual

let check_none_int actual =
  check_int_option ~expected:None actual

let check_list ~repr ~equal ~expected actual =
  check ~repr:(List_.repr ~repr) ~equal:(List_.equal ~equal) ~expected actual

let check_string_list ~expected actual =
  check_list ~repr:String_.repr ~equal:String_.equal ~expected actual

let check_int_list ~expected actual =
  check_list ~repr:Int.repr ~equal:Int.equal ~expected actual
