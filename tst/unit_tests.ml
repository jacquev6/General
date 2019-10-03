include AllPleaseUseSymbols

module Tests = struct
  open General
  open Testing

  module Standard = struct
    module Facets = Facets
    include Standard
  end

  let test = "General" >:: (
    [
      (let module T = CallStack.MakeTests(Standard) in T.test);
      (let module T = Exception.MakeTests(Standard) in T.test);
      TestingTests.test;
    ]
    @ Tests1.tests
    @ Tests2.tests
    @ Tests3.tests
    @ Tests4.tests
    @ [
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
  )
end

open General.Abbr

let () =
  let argv = Li.of_array OCamlStandard.Sys.argv in
  Exit.exit (Tst.command_line_main ~argv Tests.test)
