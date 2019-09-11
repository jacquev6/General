module Operators = struct
  module type S0 = sig
    type t
    include Identifiable.Operators.S0 with type t := t
    include Traits.Ringoid.Operators.S0 with type t := t
  end
end
module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Identifiable.S0 with type t := t and module O := O
  include Stringable.S0 with type t := t
  include Traits.Ringoid.S0 with type t := t and module O := O
  include Traits.OfStandardNumbers.S0 with type t := t
end
module Tests = struct
  open Testing
  module Examples = struct
    module type S0 = sig
      type t
      include Identifiable.Tests.Examples.S0 with type t := t
      include Stringable.Tests.Examples.S0 with type t := t
      include Traits.Ringoid.Tests.Examples.S0 with type t := t
    end
  end
  module Testable = struct
    module type S0 = sig
      include S0
    end
  end
  module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    module E = struct
      include E
      let equal = equal @ [
          [M.zero; M.of_int 0; M.of_float 0.; M.of_string "0"];
          [M.one; M.of_int 1; M.of_float 1.; M.of_string "1"];
      ]
      let different = different @ [
          (M.zero, M.one);
      ]
    end
    let test = "Number" >:: [
      (let module T = Identifiable.Tests.Make0(M)(E) in T.test);
      (let module T = Stringable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Ringoid.Tests.Make0(M)(E) in T.test);
    ]
  end
end
