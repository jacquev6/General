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
]
