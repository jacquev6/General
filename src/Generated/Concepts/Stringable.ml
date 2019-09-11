module type S0 = sig
  type t
  include Traits.Displayable.S0 with type t := t
  include Traits.Parsable.S0 with type t := t
end
module Tests = struct
  module Examples = struct
    module type S0 = sig
      type t
      include Traits.Displayable.Tests.Examples.S0 with type t := t
      include Traits.Parsable.Tests.Examples.S0 with type t := t
    end
  end
  module Testable = struct
    module type S0 = sig
      include S0
      include Traits.Representable.S0 with type t := t
      include Traits.Equatable.Basic.S0 with type t := t
    end
  end
  module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    let test = "Stringable" >:: [
      (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Parsable.Tests.Make0(M)(E) in T.test);
    ]
  end
end
