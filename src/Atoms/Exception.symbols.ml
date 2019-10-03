(* The position of these symbols is unit-tested. Moving them requires fixing the tests *)
[@@@ocaml.warning "-8"]
let match_failure = lazy (let 0 = 1 in 0)
[@@@ocaml.warning "+8"]
let assert_failure = lazy (assert false)
