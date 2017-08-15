module type MT = sig
  (** Doc for Signature *)
  module type Signature = sig
    open Set

    type t
  end
  (** Doc' for Signature *)

  (** Doc for Alias *)
  module type Alias = Signature
  (** Doc' for Alias *)

  (** Doc for DoubleAlias *)
  module type DoubleAlias = Alias
  (** Doc' for DoubleAlias *)

  (** Doc for Functor *)
  module type Functor = functor (A: sig
    (** Doc for a *)
    type a
    (** Doc' for a *)
  end) -> sig
    (** Doc for t *)
    type t
    (** Doc' for t *)
  end
  (** Doc' for Functor *)

  module type MultiFunctor = functor (A: sig type a end)(B: sig type b end) -> sig
    type t
  end

  (** Doc for FunctorAlias *)
  module type FunctorAlias = Functor
  (** Doc' for FunctorAlias *)

  (** Doc for DoubleFunctorAlias *)
  module type DoubleFunctorAlias = FunctorAlias
  (** Doc' for DoubleFunctorAlias *)

  (** Doc for FunctorWithIdentifierContents *)
  module type FunctorWithIdentifierContents = functor (A: sig type a end) -> Signature
  (** Doc' for FunctorWithIdentifierContents *)

  (** Doc for FunctorWithIdentifierContentsAlias *)
  module type FunctorWithIdentifierContentsAlias = FunctorWithIdentifierContents
  (** Doc' for FunctorWithIdentifierContentsAlias *)

  (** Doc for FunctorWithIdentifierContentsDoubleAlias *)
  module type FunctorWithIdentifierContentsDoubleAlias = FunctorWithIdentifierContentsAlias
  (** Doc' for FunctorWithIdentifierContentsDoubleAlias *)
end

include MT
