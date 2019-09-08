
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
        Format.apply "NotEqual (%S, %S)" x y
      | NoException exc ->
        Format.apply "NoException %s" (Exception.repr exc)
      | NoExceptionNamed exc ->
        Format.apply "NoExceptionNamed %S" exc
      | WrongException (expected, exc, bt) ->
        Format.apply "WrongException (%s, %s, %s)" (Exception.repr expected) (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)
      | WrongExceptionNamed (expected, exc, bt) ->
        Format.apply "WrongExceptionNamed (%S, %s, %s)" expected (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)
      | Custom x ->
        Format.apply "Custom %S" x

    type t =
      | Success
      | Failure of failure
      | Error of exn * CallStack.t option

    let repr = function
      | Success ->
        "Success"
      | Failure reason ->
        Format.apply "Failure (%s)" (failure_repr reason)
      | Error (exc, bt) ->
        Format.apply "Error (%s, %s)" (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)

    let to_string = function
        | Success ->
          "OK"
        | Failure (NotEqual (expected, actual)) ->
          (* @todo split lines, quote each line, display very explicitly. Unless both values are single line. Quote anyway *)
          Format.apply "FAILED: expected %s, but got %s" expected actual
        | Failure (NoException expected) ->
          Format.apply "FAILED: expected exception %s not raised" (Exception.to_string expected)
        | Failure (NoExceptionNamed expected) ->
          Format.apply "FAILED: expected exception %s not raised" expected
        | Failure (WrongException (expected, exc, None)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" (Exception.to_string expected) (Exception.to_string exc)
        | Failure (WrongException (expected, exc, Some bt)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised\n%s" (Exception.to_string expected) (Exception.to_string exc) (CallStack.to_string bt)
        | Failure (WrongExceptionNamed (expected, exc, None)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" expected (Exception.to_string exc)
        | Failure (WrongExceptionNamed (expected, exc, Some bt)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised\n%s" expected (Exception.to_string exc) (CallStack.to_string bt)
        | Failure (Custom message) ->
          Format.apply "FAILED: %s" message
        | Error (exc, None) ->
          Format.apply "ERROR: exception %s raised (no backtrace)" (Exception.to_string exc)
        | Error (exc, Some bt) ->
          Format.apply "ERROR: exception %s raised\n%s" (Exception.to_string exc) (CallStack.to_string bt)
  end

  type single = {
    label: string;
    status: Status.t;
  }

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

    let repr {successes; failures; errors} =
      Format.apply "{successes=%i; failures=%i; errors=%i}" successes failures errors
  end

  type group = {
    name: string;
    children: t list;
    counts: Counts.t;
  }

  and t =
    | Single of single
    | Group of group

  let rec repr = function
    | Single {label; status} ->
      Format.apply "Single {label=%S; status=%s}" label (Status.repr status)
    | Group {name; children; counts} ->
      Format.apply "Group {name=%S; children=%s; counts=%s}" name (List.repr ~repr_a:repr children) (Counts.repr counts)

  let equal x y =
    Equate.Poly.equal x y

  let to_indented_strings ~verbose =
    let rec aux indent = function
      | Single {label; status} ->
        if verbose || status <> Status.Success then
          (* @todo Indent potential backtrace or anything else that could span several lines *)
          [Format.apply "%s%S: %s" indent label (Status.to_string status)]
        else
          []
      | Group {name; children; counts={Counts.successes; failures; errors}} ->
        let children =
          children
          |> List.flat_map ~f:(aux (indent ^ "  "))
        and line =
          if Int.O.(failures + errors = 0) then
            Format.apply "%s%S (Successes: %i)" indent name successes
          else
            Format.apply "%s%S (Successes: %i, failures: %i, errors: %i)" indent name successes failures errors
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
