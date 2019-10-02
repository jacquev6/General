open General

module Standard = struct
  module Facets = Facets
  include Standard
end

let tests = [
  (let module T = BigInt.MakeTests(Standard) in T.test);
  (let module T = BinaryHeap.MakeTests(Standard) in T.test);
  (let module T = Bool.MakeTests(Standard) in T.test);
  (let module T = Bytes.MakeTests(Standard) in T.test);
  (let module T = Char.MakeTests(Standard) in T.test);
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
]
