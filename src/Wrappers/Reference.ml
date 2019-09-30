module Basic = struct
  type 'a t = 'a OCamlStandard.Pervasives.ref = {
    mutable contents: 'a;
  }

  let of_contents = OCamlStandard.Pervasives.ref
  let contents = OCamlStandard.Pervasives.( ! )
  let assign = OCamlStandard.Pervasives.( := )

  module O = struct
    let ref = OCamlStandard.Pervasives.ref
    let ( ! ) = OCamlStandard.Pervasives.( ! )
    let ( := ) = OCamlStandard.Pervasives.( := )
  end
end

module Extended(Facets: Facets) = struct
  module Self = struct
    include Basic

    module SpecializeOperators(A: sig type t end) = struct
      type t = A.t Basic.t

      include Basic.O
    end

    module Specialize(A: sig type t end) = struct
      type t = A.t Basic.t

      include (Basic: module type of Basic with type 'a t := 'a Basic.t)
    end

    module SpecializePredSucc(A: Facets.PredSucc.S0) = struct
      open Basic.O

      type t = A.t Basic.t

      let increment r =
        r := A.succ !r

      let decrement r =
        r := A.pred !r
    end

    module SpecializeRingoidOperators(A: Facets.RingoidBasic.S0) = struct
      open Basic.O

      type t = A.t Basic.t

      (* @todo Should/could we use :+= ? This would mimick C's = and += as := and :+= *)
      let ( =+ ) r v =
        r := A.add !r v

      let ( =- ) r v =
        r := A.subtract !r v

      let ( =* ) r v =
        r := A.multiply !r v

      let ( =/ ) r v =
        r := A.divide !r v
    end

    module SpecializeRingoid(A: Facets.RingoidBasic.S0) = struct
      type t = A.t Basic.t

      module O = (SpecializeRingoidOperators(A): module type of SpecializeRingoidOperators(A) with type t := t)
    end
  end

  include Self

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Wrappers/Reference.ml"

    include Tests_.Make(Self)(struct
    end)(struct
      let tests = []
    end)
  end
end
