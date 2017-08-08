open Foundations

module OCSS = OCamlStandard.Sys
module OCSPf = OCamlStandard.Printf (* @todo Put StdOut in Foundations *)

module Result = struct
  module Status = struct
    type failure =
      | NotEqual of (string * string)
      | NoException of exn
      | NoExceptionNamed of string
      | WrongException of exn * exn * CallStack.t option
      | WrongExceptionNamed of string * exn * CallStack.t option
      | Custom of string

    let failure_repr = function
      | NotEqual (x, y) ->
        Format_.apply "NotEqual (%S, %S)" x y
      | NoException exc ->
        Format_.apply "NoException %s" (Exception.repr exc)
      | NoExceptionNamed exc ->
        Format_.apply "NoExceptionNamed %S" exc
      | WrongException (expected, exc, bt) ->
        Format_.apply "WrongException (%s, %s, %s)" (Exception.repr expected) (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)
      | WrongExceptionNamed (expected, exc, bt) ->
        Format_.apply "WrongExceptionNamed (%S, %s, %s)" expected (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)
      | Custom x ->
        Format_.apply "Custom %S" x

    type t =
      | Success
      | Failure of failure
      | Error of exn * CallStack.t option

    let repr = function
      | Success ->
        "Success"
      | Failure reason ->
        Format_.apply "Failure (%s)" (failure_repr reason)
      | Error (exc, bt) ->
        Format_.apply "Error (%s, %s)" (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)

    let to_string = function
        | Success ->
          "OK"
        | Failure (NotEqual (expected, actual)) ->
          (* @todo split lines, quote each line, display very explicitly. Unless both values are single line. Quote anyway *)
          Format_.apply "FAILED: expected %s, but got %s" expected actual
        | Failure (NoException expected) ->
          Format_.apply "FAILED: expected exception %s not raised" (Exception.to_string expected)
        | Failure (NoExceptionNamed expected) ->
          Format_.apply "FAILED: expected exception %s not raised" expected
        | Failure (WrongException (expected, exc, None)) ->
          Format_.apply "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" (Exception.to_string expected) (Exception.to_string exc)
        | Failure (WrongException (expected, exc, Some bt)) ->
          Format_.apply "FAILED: expected exception %s not raised, but exception %s raised\n%s" (Exception.to_string expected) (Exception.to_string exc) (CallStack.to_string bt)
        | Failure (WrongExceptionNamed (expected, exc, None)) ->
          Format_.apply "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" expected (Exception.to_string exc)
        | Failure (WrongExceptionNamed (expected, exc, Some bt)) ->
          Format_.apply "FAILED: expected exception %s not raised, but exception %s raised\n%s" expected (Exception.to_string exc) (CallStack.to_string bt)
        | Failure (Custom message) ->
          Format_.apply "FAILED: %s" message
        | Error (exc, None) ->
          Format_.apply "ERROR: exception %s raised (no backtrace)" (Exception.to_string exc)
        | Error (exc, Some bt) ->
          Format_.apply "ERROR: exception %s raised\n%s" (Exception.to_string exc) (CallStack.to_string bt)
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
      Format_.apply "Single {label=%S; status=%s}" label (Status.repr status)
    | Group {name; children} ->
      Format_.apply "Group {name=%S; children=%s}" name (List_.repr ~repr_a:repr children)

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
          [Format_.apply "%s%S: %s" indent label (Status.to_string status)]
        else
          []
      | `Group (name, children, {Counts.successes; failures; errors}) ->
        let children =
          children
          |> List_.flat_map ~f:(aux (indent ^ "  "))
        and line =
          if Int.O.(failures + errors = 0) then
            Format_.apply "%s%S (Successes: %i)" indent name successes
          else
            Format_.apply "%s%S (Successes: %i, failures: %i, errors: %i)" indent name successes failures errors
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
    Exception.record_backtraces record_backtrace;
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
            Result.Single {Result.label; status=Result.Status.Error (exc, Exception.most_recent_backtrace ())}
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
  |> List_.iter ~f:(OCSPf.printf "%s\n");
  match result with
    | `Single (_, Result.Status.Success) | `Group (_, _, {Result.Counts.failures=0; errors=0; _}) ->
      Exit.Success
    | _ -> Exit.Failure 1
(*BISECT-IGNORE-END*)

(* Test factories *)

let (>::) name tests =
  Test.(Group {name; tests})

let (>:) label check =
  Test.(Single {label; check})

let (~::) format =
  Format_.with_result ~f:(>::) format

let (~:) format =
  Format_.with_result ~f:(>:) format

(* Checks *)

let javascript = String_.has_suffix OCSS.argv.(0) ~suf:".js"
#if OCAML_VERSION < (4, 4, 0)
let old_javascript = javascript
#else
let old_javascript = false
#endif

let fail format =
  Format_.with_result
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
    | exc -> Exception.raise (TestFailure (Result.Status.WrongException (expected, exc, Exception.most_recent_backtrace ())))

let expect_exception_named ~expected x =
  try
    ignore (Lazy_.value x);
    Exception.raise NoExceptionRaised
  with
    | NoExceptionRaised -> Exception.raise (TestFailure (Result.Status.NoExceptionNamed expected))
    | actual when String_.equal (Exception.name actual) expected -> ()
    | exc -> Exception.raise (TestFailure (Result.Status.WrongExceptionNamed (expected, exc, Exception.most_recent_backtrace ())))

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
  check ~repr:(Option.repr ~repr_a:repr) ~equal:(Option.equal ~equal_a:equal) ~expected actual

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

let check_string_option ~expected actual =
  check_option ~repr:String_.repr ~equal:String_.equal ~expected actual

let check_some_string ~expected actual =
  check_string_option ~expected:(Some expected) actual

let check_none_string actual =
  check_string_option ~expected:None actual

let check_list ~repr ~equal ~expected actual =
  check ~repr:(List_.repr ~repr_a:repr) ~equal:(List_.equal ~equal_a:equal) ~expected actual

let check_string_list ~expected actual =
  check_list ~repr:String_.repr ~equal:String_.equal ~expected actual

let check_int_list ~expected actual =
  check_list ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_tuple2 ~repr_a ~repr_b ~equal_a ~equal_b ~expected actual =
  check
    ~repr:(Tuples.Tuple2.repr ~repr_a ~repr_b)
    ~equal:(Tuples.Tuple2.equal ~equal_a ~equal_b)
    ~expected actual

let check_int_tuple2 ~expected actual =
  check_tuple2
    ~repr_a:Int.repr ~repr_b:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal
    ~expected actual

let check_tuple3 ~repr_a ~repr_b ~repr_c ~equal_a ~equal_b ~equal_c ~expected actual =
  check
    ~repr:(Tuples.Tuple3.repr ~repr_a ~repr_b ~repr_c)
    ~equal:(Tuples.Tuple3.equal ~equal_a ~equal_b ~equal_c)
    ~expected actual

let check_int_tuple3 ~expected actual =
  check_tuple3
    ~repr_a:Int.repr ~repr_b:Int.repr ~repr_c:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal ~equal_c:Int.equal
    ~expected actual

let check_tuple4 ~repr_a ~repr_b ~repr_c ~repr_d ~equal_a ~equal_b ~equal_c ~equal_d ~expected actual =
  check
    ~repr:(Tuples.Tuple4.repr ~repr_a ~repr_b ~repr_c ~repr_d)
    ~equal:(Tuples.Tuple4.equal ~equal_a ~equal_b ~equal_c ~equal_d)
    ~expected actual

let check_int_tuple4 ~expected actual =
  check_tuple4
    ~repr_a:Int.repr ~repr_b:Int.repr ~repr_c:Int.repr ~repr_d:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal ~equal_c:Int.equal ~equal_d:Int.equal
    ~expected actual

let check_tuple5 ~repr_a ~repr_b ~repr_c ~repr_d ~repr_e ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e ~expected actual =
  check
    ~repr:(Tuples.Tuple5.repr ~repr_a ~repr_b ~repr_c ~repr_d ~repr_e)
    ~equal:(Tuples.Tuple5.equal ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e)
    ~expected actual

let check_int_tuple5 ~expected actual =
  check_tuple5
    ~repr_a:Int.repr ~repr_b:Int.repr ~repr_c:Int.repr ~repr_d:Int.repr ~repr_e:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal ~equal_c:Int.equal ~equal_d:Int.equal ~equal_e:Int.equal
    ~expected actual
