open General

module Standard = struct
  module Facets = Facets
  include Standard
end

let tests = [
  (let module T = Stream.MakeTests(Standard) in T.test);
  (let module T = String.MakeTests(Standard) in T.test);
  (let module T = Tuple2.MakeTests(Standard) in T.test);
  (let module T = Tuple3.MakeTests(Standard) in T.test);
  (let module T = Tuple4.MakeTests(Standard) in T.test);
  (let module T = Tuple5.MakeTests(Standard) in T.test);
  (let module T = Unit.MakeTests(Standard) in T.test);
]
