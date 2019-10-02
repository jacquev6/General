include AllPleaseUseSymbols

module Tests = struct
  open General
  open Testing

  module Standard = struct
    module Facets = Facets
    include Standard
  end

  let test = "General" >:: [
    (let module T = BigInt.MakeTests(Standard) in T.test);
    (let module T = BinaryHeap.MakeTests(Standard) in T.test);
    (let module T = Bool.MakeTests(Standard) in T.test);
    (let module T = Bytes.MakeTests(Standard) in T.test);
    (let module T = CallStack.MakeTests(Standard) in T.test);
    (let module T = Char.MakeTests(Standard) in T.test);
    (let module T = Exception.MakeTests(Standard) in T.test);
    (let module T = Exit.MakeTests(Standard) in T.test);
    (let module T = Float.MakeTests(Standard) in T.test);
    (let module T = Function1.MakeTests(Standard) in T.test);
    (let module T = Function2.MakeTests(Standard) in T.test);
    (let module T = Function3.MakeTests(Standard) in T.test);
    (let module T = Function4.MakeTests(Standard) in T.test);
    (let module T = Function5.MakeTests(Standard) in T.test);
    (let module T = Int.MakeTests(Standard) in T.test);
    (let module T = Int32.MakeTests(Standard) in T.test);
    (let module T = Int64.MakeTests(Standard) in T.test);
    (let module T = IntRange.MakeTests(Standard) in T.test);
    (let module T = Lazy.MakeTests(Standard) in T.test);
    (let module T = List.MakeTests(Standard) in T.test);
    (let module T = NativeInt.MakeTests(Standard) in T.test);
    (let module T = Option.MakeTests(Standard) in T.test);
    (let module T = RedBlackTree.MakeTests(Standard) in T.test);
    (let module T = Reference.MakeTests(Standard) in T.test);
    (let module T = Stream.MakeTests(Standard) in T.test);
    (let module T = String.MakeTests(Standard) in T.test);
    (let module T = Tuple2.MakeTests(Standard) in T.test);
    (let module T = Tuple3.MakeTests(Standard) in T.test);
    (let module T = Tuple4.MakeTests(Standard) in T.test);
    (let module T = Tuple5.MakeTests(Standard) in T.test);
    (let module T = Unit.MakeTests(Standard) in T.test);
    TestingTests.test;

    "Syntactic sugar" >:: [
      "Standard" >:: Standard.[
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
      "Abbr" >:: Abbr.[
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
