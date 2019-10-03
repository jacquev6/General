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
  (let module T = Stream.MakeTests(Standard) in T.test);
  (let module T = String.MakeTests(Standard) in T.test);
  (let module T = Tuple2.MakeTests(Standard) in T.test);
  (let module T = Tuple3.MakeTests(Standard) in T.test);
  (let module T = Tuple4.MakeTests(Standard) in T.test);
  (let module T = Tuple5.MakeTests(Standard) in T.test);
  (let module T = Unit.MakeTests(Standard) in T.test);
]
