module Basic = struct
  type 'a t = 'a OCSP.ref = {
    mutable contents: 'a;
  }

  let of_contents = OCSP.ref
  let contents = OCSP.(!)
  let assign = OCSP.(:=)

  module O = struct
    let ref = OCSP.ref
    let (!) = OCSP.(!)
    let (:=) = OCSP.(:=)
  end
end

module Extended(Facets: Facets) = struct
  module Self = struct
    module Ref = Basic

    include Ref

    module SpecializeOperators(A: sig type t end) = struct
      type t = A.t Ref.t

      include Ref.O
    end

    module Specialize(A: sig type t end) = struct
      type t = A.t Ref.t

      include (Ref: module type of Ref with type 'a t := 'a Ref.t)
    end

    module SpecializePredSucc(A: Facets.PredSucc.S0) = struct
      open Ref.O

      type t = A.t Ref.t

      let increment r =
        r := A.succ !r

      let decrement r =
        r := A.pred !r
    end

    module SpecializeRingoidOperators(A: Facets.RingoidBasic.S0) = struct
      open Ref.O

      type t = A.t Ref.t

      let (=+) r v =
        r := A.add !r v

      let (=-) r v =
        r := A.subtract !r v

      let (=*) r v =
        r := A.multiply !r v

      let (=/) r v =
        r := A.divide !r v
    end

    module SpecializeRingoid(A: Facets.RingoidBasic.S0) = struct
      type t = A.t Ref.t

      module O = (SpecializeRingoidOperators(A): module type of SpecializeRingoidOperators(A) with type t := t)
    end
  end

  include Self

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Wrappers/Reference.ml"

    include Tests_.Make(Self)(struct
    end)(struct
      let tests = []
    end)
  end
end
