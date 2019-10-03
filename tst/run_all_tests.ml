include AllPleaseUseSymbols

module Tests = struct
  open General.Testing

  let test = "General" >:: [
    CallStackTests.test;
    ExceptionTests.test;
    General.TestingTests.test;
    BigIntTests.test;
    BinaryHeapTests.test;
    BoolTests.test;
    BytesTests.test;
    CharTests.test;
    ExitTests.test;
    FloatTests.test;
    Function1Tests.test;
    Function2Tests.test;
    Function3Tests.test;
    Function4Tests.test;
    Function5Tests.test;
    IntTests.test;
    Int32Tests.test;
    Int64Tests.test;
    IntRangeTests.test;
    LazyTests.test;
    ListTests.test;
    NativeIntTests.test;
    OptionTests.test;
    RedBlackTreeTests.test;
    ReferenceTests.test;
    StreamTests.test;
    StringTests.test;
    Tuple2Tests.test;
    Tuple3Tests.test;
    Tuple4Tests.test;
    Tuple5Tests.test;
    UnitTests.test;

    "Syntactic sugar" >:: [
      "Standard" >:: General.Standard.[
        "array" >:: [
          "get" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 a.(0)));
          "set" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 (Array.get a 0); a.(0) <- 37; check_int ~expected:37 (Array.get a 0)));
        ];
        "string" >:: [
          "get" >: (let a: string = "a" in lazy (check_char ~expected:'a' a.[0]));
        ];
        "bytes" >:: [
          "set" >: (let a: bytes = Bytes.of_string "a" in lazy (check_char ~expected:'a' (Bytes.get a 0); a.[0] <- 'z'; check_char ~expected:'z' (Bytes.get a 0)));
        ];
      ];
      "Abbr" >:: General.Abbr.[
        "array" >:: [
          "get" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 a.(0)));
          "set" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 (Ar.get a 0); a.(0) <- 37; check_int ~expected:37 (Ar.get a 0)));
        ];
        "string" >:: [
          "get" >: (let a: string = "a" in lazy (check_char ~expected:'a' a.[0]));
        ];
        "bytes" >:: [
          "set" >: (let a: bytes = By.of_string "a" in lazy (check_char ~expected:'a' (By.get a 0); a.[0] <- 'z'; check_char ~expected:'z' (By.get a 0)));
        ];
      ];
    ];
  ]
end

open General.Abbr

let () =
  let argv = Li.of_array OCamlStandard.Sys.argv in
  Exit.exit (Tst.command_line_main ~argv Tests.test)
