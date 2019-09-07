#ext python3
from geni import *
generate(able.module_items)
#endext

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Identifiable.Tests.Examples.S0 with type t := t
      include Traits.Comparable.Tests.Examples.S0 with type t := t
    end

    module type Element = sig
      type t

      include Identifiable.Tests.Examples.Element with type t := t
      include Traits.Comparable.Tests.Examples.Element with type t := t
    end

    module type S1 = sig
      type 'a t

      module A: Element

      include Identifiable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      include Traits.Comparable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
    end

    module type S2 = sig
      type ('a, 'b) t

      module A: Element
      module B: Element

      include Identifiable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      include Traits.Comparable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
    end

    module type S3 = sig
      type ('a, 'b, 'c) t

      module A: Element
      module B: Element
      module C: Element

      include Identifiable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      include Traits.Comparable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t

      module A: Element
      module B: Element
      module C: Element
      module D: Element

      include Identifiable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      include Traits.Comparable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t

      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      include Identifiable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      include Traits.Comparable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
    end
  end

  #define MAKE(N, ARGS) \
  module CONCAT(Make, N)(M: CONCAT(S, N))(E: Examples.CONCAT(S, N) with type ARGS t := ARGS M.t) = struct \
    let test = "Able" >:: [ \
      (let module T = Identifiable.Tests.CONCAT(Make, N)(M)(E) in T.test); \
      (let module T = Traits.Comparable.Tests.CONCAT(Make, N)(M)(E) in T.test); \
    ] \
  end

  MAKE(0, )
  MAKE(1, 'a)
  MAKE(2, ('a, 'b))
  MAKE(3, ('a, 'b, 'c))
  MAKE(4, ('a, 'b, 'c, 'd))
  MAKE(5, ('a, 'b, 'c, 'd, 'e))

  #undef MAKE
end
