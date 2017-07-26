open Abbr_

include BuiltinTypes_.Exception_

module Tests = struct
  open Testing

  exception TestException

  let test = "Exception" >:: [
    "raise" >: (lazy (expect_exception ~expected:TestException (lazy (raise TestException))));
    "raise_no_backtrace" >: (lazy (expect_exception ~expected:TestException (lazy (raise_no_backtrace TestException))));
    "failure" >: (lazy (expect_exception ~expected:(Failure "Foo bar 42") (lazy (failure "Foo %s %n" "bar" 42))));
    "invalid_argument" >: (lazy (expect_exception ~expected:(Invalid_argument "Grmbl baz 43") (lazy (invalid_argument "Grmbl %s %n" "baz" 43))));
  ]
end
