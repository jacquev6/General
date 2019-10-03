open General

module Standard = struct
  module Facets = Facets
  include Standard
end

let tests = [
  (let module T = Function1.MakeTests(Standard) in T.test);
  (let module T = Function2.MakeTests(Standard) in T.test);
  (let module T = Function3.MakeTests(Standard) in T.test);
  (let module T = Function4.MakeTests(Standard) in T.test);
  (let module T = Function5.MakeTests(Standard) in T.test);
  (let module T = Int.MakeTests(Standard) in T.test);
  (let module T = Int32.MakeTests(Standard) in T.test);
  (let module T = Int64.MakeTests(Standard) in T.test);
]
