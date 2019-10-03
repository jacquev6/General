(* The position of these symbols is tested below. Moving them requires fixing the tests *)
let callstack = CallStack.current ()
(* End of symbols to not move *)

open Standard
open Testing

exception TestException0
exception TestException0'
exception TestException1 of string

let () = Exception.register_printer (function
  | TestException0 -> Some "TestingTests.Tests.TestException0"
  | TestException0' -> Some "TestingTests.Tests.TestException0'"
  | TestException1 s -> Some (Format.apply "TestingTests.Tests.TestException1(%S)" s)
  | _ -> None
)

module ResultExamples = struct
  open Result
  open Status
  open Counts

  let representations = [
    (Single {label="foo"; status=Success}, "Single {label=\"foo\"; status=Success}");
    (Single {label="foo"; status=Failure (NotEqual ("a", "b"))}, "Single {label=\"foo\"; status=Failure (NotEqual (\"a\", \"b\"))}");
    (Single {label="foo"; status=Failure (NoException TestException0)}, "Single {label=\"foo\"; status=Failure (NoException TestingTests.Tests.TestException0)}");
    (Single {label="foo"; status=Failure (NoExceptionNamed "Foo")}, "Single {label=\"foo\"; status=Failure (NoExceptionNamed \"Foo\")}");
    (Single {label="foo"; status=Failure (WrongException (TestException0, TestException0', None))}, "Single {label=\"foo\"; status=Failure (WrongException (TestingTests.Tests.TestException0, TestingTests.Tests.TestException0', None))}");
    (Single {label="foo"; status=Failure (WrongExceptionNamed ("Foo", TestException0', None))}, "Single {label=\"foo\"; status=Failure (WrongExceptionNamed (\"Foo\", TestingTests.Tests.TestException0', None))}");
    (Single {label="foo"; status=Failure (Custom "bad")}, "Single {label=\"foo\"; status=Failure (Custom \"bad\")}");
    (Single {label="foo"; status=Error (TestException0, None)}, "Single {label=\"foo\"; status=Error (TestingTests.Tests.TestException0, None)}");
    (Group {name="bar"; children=[Single {label="foo"; status=Success}]; counts={successes=1; failures=2; errors=3}}, "Group {name=\"bar\"; children=[Single {label=\"foo\"; status=Success}]; counts={successes=1; failures=2; errors=3}}");
  ]
end

let test = "Testing" >:: [
  "Result" >:: [
    (let module T = Facets.Representable.Tests.Make0(Result)(ResultExamples) in T.test);
    "to_indented_strings" >:: (
      let make ?(verbose=false) expected result =
        (expected |> StringList.join ~sep:"\n") >: (lazy (
          let actual =
            result
            |> Result.to_indented_strings ~verbose
          in
          check_string_list ~expected actual
        ))
      in
      Result.(Status.(Counts.[
        make ~verbose:true
          ["\"foo\": OK"]
          (Single {label="foo"; status=Success});
        make
          ["\"bar 1\": FAILED: expected a, but got b"]
          (Single {label="bar 1"; status=Failure (NotEqual ("a", "b"))});
        make
          ["\"bar 2\": FAILED: expected exception TestingTests.Tests.TestException0 not raised"]
          (Single {label="bar 2"; status=Failure (NoException TestException0)});
        make
          ["\"bar 2'\": FAILED: expected exception Foo not raised"]
          (Single {label="bar 2'"; status=Failure (NoExceptionNamed "Foo")});
        make
          ["\"bar 3\": FAILED: expected exception TestingTests.Tests.TestException0 not raised, but exception TestingTests.Tests.TestException0' raised (no backtrace)"]
          (Single {label="bar 3"; status=Failure (WrongException (TestException0, TestException0', None))});
        make
          ["\"bar 3'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException0' raised (no backtrace)"]
          (Single {label="bar 3'"; status=Failure (WrongExceptionNamed ("Foo", TestException0', None))});
        make
          [
            match Testing.context with
              | NodeJs ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n"
              | ByteCode ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Native (4, (2|3), _) ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n"
              | Native _ ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda (4, 3, _) ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n"
              | Flambda (4, 4, _) ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\", line 249, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\" (inlined), line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda (4, (5|6|7), _) ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\" (inlined), line 251, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda _ ->
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\" (inlined), line 253, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
          ]
          (Single {label="bar 4"; status=Failure (WrongException (TestException1 "bad", TestException1 "too bad", Some callstack))});
        make
          [
            match Testing.context with
              | NodeJs ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n"
              | ByteCode ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Native (4, (2|3), _) ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n"
              | Native _ ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda (4, 3, _) ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n"
              | Flambda (4, 4, _) ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\", line 249, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\" (inlined), line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda (4, (5|6|7), _) ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\" (inlined), line 251, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda _ ->
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\" (inlined), line 253, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
          ]
          (Single {label="bar 4'"; status=Failure (WrongExceptionNamed ("Foo", TestException1 "too bad", Some callstack))});
        make
          ["\"bar 5\": FAILED: too bad"]
          (Single {label="bar 5"; status=Failure (Custom "too bad")});
        make
          ["\"bar 6\": ERROR: exception TestingTests.Tests.TestException0 raised (no backtrace)"]
          (Single {label="bar 6"; status=Error (TestException0, None)});
        make
          [
            match Testing.context with
              | NodeJs ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n"
              | ByteCode ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Raised by primitive operation at file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Native (4, (2|3), _) ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n"
              | Native _ ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Raised by primitive operation at file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda (4, 3, _) ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n"
              | Flambda (4, 4, _) ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\", line 249, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\" (inlined), line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda (4, (5|6|7), _) ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\" (inlined), line 251, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
              | Flambda _ ->
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                  Raised by primitive operation at file \"printexc.ml\" (inlined), line 253, characters 0-75\n\
                  Called from file \"Atoms/CallStack.ml\", line 5, characters 4-49\n\
                  Called from file \"Testing/Tests.ml\", line 2, characters 16-36\n"
          ]
          (Single {label="bar 7"; status=Error (TestException1 "bad", Some callstack)});
        make ~verbose:true
          [
            "\"foo\" (Successes: 2)";
            "  \"bar\": OK";
            "  \"baz\": OK";
          ]
          (Group {name="foo"; children=[Single {label="bar"; status=Success}; Single {label="baz"; status=Success}]; counts={successes=2; failures=0; errors=0}});
        make ~verbose:false
          [
            "\"foo\" (Successes: 2)";
          ]
          (Group {name="foo"; children=[Single {label="bar"; status=Success}; Single {label="baz"; status=Success}]; counts={successes=2; failures=0; errors=0}});
        make ~verbose:true
          [
            "\"foo\" (Successes: 1, failures: 1, errors: 0)";
            "  \"bar\": FAILED: nope";
            "  \"baz\": OK";
          ]
          (Group {name="foo"; children=[Single {label="bar"; status=Failure (Custom "nope")}; Single {label="baz"; status=Success}]; counts={successes=1; failures=1; errors=0}});
        make ~verbose:false
          [
            "\"foo\" (Successes: 1, failures: 1, errors: 0)";
            "  \"bar\": FAILED: nope";
          ]
          (Group {name="foo"; children=[Single {label="bar"; status=Failure (Custom "nope")}; Single {label="baz"; status=Success}]; counts={successes=1; failures=1; errors=0}});
        make
          [
            "\"foo\" (Successes: 0, failures: 0, errors: 1)";
            "  \"bar\": ERROR: exception TestingTests.Tests.TestException0 raised (no backtrace)";
          ]
          (Group {name="foo"; children=[Single {label="bar"; status=Error (TestException0, None)}]; counts={successes=0; failures=0; errors=1}});
      ]))
    );
  ];
  "Test" >:: [
    ~:: "ru%s" "n" (
      let make expected test =
        let name = match test with
          | Test.Single {Test.label; _} -> label
          | Test.Group {Test.name; _} -> name
        in
        name >: (lazy Result.(check ~repr ~equal ~expected (run ~record_backtrace:false test)))
      in
      Result.(Status.(Counts.[
        make (Single {label="single success"; status=Success}) ("single success" >: (lazy ()));
        make
          (Group {name="group success"; children=[Single {label="child"; status=Success}]; counts={successes=1; failures=0; errors=0}})
          ("group success" >:: ["child" >: (lazy ())]);
        make
          (Single {label="not equal failure"; status=Failure (NotEqual ("42", "43"))})
          ("not equal failure" >: (lazy (check_int ~expected:42 43)));
        make
          (Single {label="no exception"; status=Failure (NoException TestException0)})
          ("no exception" >: (lazy (expect_exception ~expected:TestException0 (lazy ()))));
        make
          (Single {label="wrong exception"; status=Failure (WrongException (TestException0, TestException0', None))})
          ("wrong exception" >: (lazy (expect_exception ~expected:TestException0 (lazy (Exception.raise TestException0')))));
        make
          (Single {label="custom failure"; status=Failure (Custom "bad")})
          ("custom failure" >: (lazy (fail "bad")));
        make
          (Single {label="error"; status=Error (TestException0, None)})
          ("error" >: (lazy (Exception.raise TestException0)));
      ]))
    );
  ];
]
