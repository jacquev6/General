(* The position of these symbols is tested bellow. Moving them requires fixing the tests *)
let callstack = OCamlStandard.Printexc.get_callstack 1
(* End of symbols to not move *)

open Foundations

include Testing

module Tests = struct
  exception TestException0
  exception TestException0'
  exception TestException1 of string

  type many = {
    byte: string;
    js: string;
  }

  type expected =
    | One of string
    | Many of many

  (*BISECT-IGNORE-BEGIN*) (* Test code *)
  let homogenize =
    if OCamlStandard.(Int.O.(StringLabels.sub ~pos:((StringLabels.length Sys.argv.(0)) - 3) ~len:3 (Sys.argv.(0))) = ".js") then
      function
        | One x -> x
        | Many {js; _} -> js
    else
      function
        | One x -> x
        | Many {byte; _} -> byte
  (*BISECT-IGNORE-END*)

  module ResultExamples = struct
    open Result
    open Status

    let repr = [
      (Single {label="foo"; status=Success}, "Single {label=\"foo\"; status=Success}");
      (Single {label="foo"; status=Failure (NotEqual ("a", "b"))}, "Single {label=\"foo\"; status=Failure (NotEqual (\"a\", \"b\"))}");
      (Single {label="foo"; status=Failure (NoException TestException0)}, "Single {label=\"foo\"; status=Failure (NoException TestingTests.Tests.TestException0)}");
      (Single {label="foo"; status=Failure (WrongException (TestException0, TestException0', None))}, "Single {label=\"foo\"; status=Failure (WrongException (TestingTests.Tests.TestException0, TestingTests.Tests.TestException0', None))}");
      (Single {label="foo"; status=Failure (Custom "bad")}, "Single {label=\"foo\"; status=Failure (Custom \"bad\")}");
      (Single {label="foo"; status=Error (TestException0, None)}, "Single {label=\"foo\"; status=Error (TestingTests.Tests.TestException0, None)}");
      (Group {name="bar"; children=[Single {label="foo"; status=Success}]}, "Group {name=\"bar\"; children=[Single {label=\"foo\"; status=Success}]}");
    ]
  end

  let test = "Testing" >:: [
    "Result" >:: [
      (let module T = Traits.Representable.Tests.Make0(Result)(ResultExamples) in T.test);
      "to_indented_strings" >:: (
        let make expected result =
          let expected =
            expected
            |> List_.map ~f:homogenize
          in
          (expected |> OCamlStandard.StringLabels.concat ~sep:"\n") >: (lazy (
            let actual =
              result
              |> Result.decorate_with_counts
              |> Result.to_indented_strings ~verbose:true
            in
            check_string_list ~expected actual
          ))
        in
        Result.(Status.[
          make
            [One "\"foo\": OK"]
            (Single {label="foo"; status=Success});
          make
            [One "\"bar 1\": FAILED: expected a, but got b"]
            (Single {label="bar 1"; status=Failure (NotEqual ("a", "b"))});
          make
            [One "\"bar 2\": FAILED: expected exception TestingTests.Tests.TestException0 not raised"]
            (Single {label="bar 2"; status=Failure (NoException (TestException0))});
          make
            [One "\"bar 3\": FAILED: expected exception TestingTests.Tests.TestException0 not raised, but exception TestingTests.Tests.TestException0' raised (no backtrace)"]
            (Single {label="bar 3"; status=Failure (WrongException (TestException0, TestException0', None))});
          make
            [
              Many {
                js = "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(bad) not raised, but exception TestingTests.Tests.TestException1(too bad) raised\n";
                byte = "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                        Raised by primitive operation at file \"src/Implementation/TestingTests.ml\", line 2, characters 16-54\n";
              }
            ]
            (Single {label="bar 4"; status=Failure (WrongException (TestException1 "bad", TestException1 "too bad", Some callstack))});
          make
            [One "\"bar 5\": FAILED: too bad"]
            (Single {label="bar 5"; status=Failure (Custom "too bad")});
          make
            [One "\"bar 6\": ERROR: exception TestingTests.Tests.TestException0 raised (no backtrace)"]
            (Single {label="bar 6"; status=Error (TestException0, None)});
          make
            [Many {
              js = "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(bad) raised\n";
              byte = "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                      Raised by primitive operation at file \"src/Implementation/TestingTests.ml\", line 2, characters 16-54\n";
            }]
            (Single {label="bar 7"; status=Error (TestException1 "bad", Some callstack)});
          make
            [
              One "\"foo\" (Successes: 2)";
              One "  \"bar\": OK";
              One "  \"baz\": OK";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Success}; Single {label="baz"; status=Success}]});
          make
            [
              One "\"foo\" (Successes: 1, failures: 1, errors: 0)";
              One "  \"bar\": FAILED: nope";
              One "  \"baz\": OK";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Failure (Custom "nope")}; Single {label="baz"; status=Success}]});
          make
            [
              One "\"foo\" (Successes: 0, failures: 0, errors: 1)";
              One "  \"bar\": ERROR: exception TestingTests.Tests.TestException0 raised (no backtrace)";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Error (TestException0, None)}]});
        ])
      );
    ];
    "Test" >:: [
      ~:: "ru%s" "n" (
        let make expected test =
          let name = match test with
            | Test.Single {Test.label; _} -> label
            | Test.Group {Test.name; _} -> name
          in
          name >: (lazy (check ~repr:Result.repr ~equal:Result.equal ~expected (Test.run ~record_backtrace:false test)))
        in
        Result.(Status.[
          make (Single {label="single success"; status=Success}) ("single success" >: (lazy ()));
          make
            (Group {name="group success"; children=[Single {label="child"; status=Success}]})
            ("group success" >:: ["child" >: (lazy ())]);
          make
            (Single {label="not equal failure"; status=Failure (NotEqual ("42", "43"))})
            ("not equal failure" >: (lazy (check_42 43)));
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
        ])
      );
    ];
  ]
end
