open General

module Standard = struct
  module Facets = Facets
  include Standard
end

let tests = [
  (let module T = IntRange.MakeTests(Standard) in T.test);
  (let module T = Lazy.MakeTests(Standard) in T.test);
  (let module T = List.MakeTests(Standard) in T.test);
  (let module T = NativeInt.MakeTests(Standard) in T.test);
  (let module T = Option.MakeTests(Standard) in T.test);
  (let module T = RedBlackTree.MakeTests(Standard) in T.test);
  (let module T = Reference.MakeTests(Standard) in T.test);
]
