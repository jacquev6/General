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

  (** Doc for Module *)
  module Module: sig
    (** Doc for t *)
    type t
    (** Doc' for t *)
  end [@@autodoc.hide]
  (** Doc' for Module *)

  (** Doc for ModuleTypeOf *)
  module type ModuleTypeOf = module type of Module
  (** Doc' for ModuleTypeOf *)

  (** Doc for ForWithType *)
  module type ForWithType = sig
    (** Doc for t0 *)
    type t0
    (** Doc' for t0 *)

    (** Doc for v0 *)
    val v0: t0
    (** Doc' for v0 *)

    (** Doc for t1 *)
    type 'a t1
    (** Doc' for t1 *)

    (** Doc for v1 *)
    val v1: int t1
    (** Doc' for v1 *)

    (** Doc for t2 *)
    type ('a, 'b) t2
    (** Doc' for t2 *)

    (** Doc for v2 *)
    val v2: (int, float) t2
    (** Doc' for v2 *)
  end [@@autodoc.hide]
  (** Doc' for ForWithType *)

  (** Doc for WithType *)
  module type WithType = ForWithType with type t0 = int and type 'a t1 = 'a list and type ('a, 'b) t2 = ('a, 'b) result
  (** Doc' for WithType *)

  (** Doc for WithTypeSubst *)
  module type WithTypeSubst = ForWithType with type t0 := int and type 'a t1 := 'a list and type ('a, 'b) t2 := ('a, 'b) result
  (** Doc' for WithTypeSubst *)

  (** Doc for ForWithModule *)
  module type ForWithModule = sig
    (** Doc of M *)
    module M: sig
      (** Doc of t *)
      type t
      (** Doc' of t *)
    end
    (** Doc' of M *)

    (** Doc for v *)
    val v: M.t
    (** Doc' for v *)
  end [@@autodoc.hide]
  (** Doc' for ForWithModule *)

  (** Doc for MyM *)
  module MyM: sig
    (** Doc for t=int  *)
    type t = int
    (** Doc' for t=int  *)
  end [@@autodoc.hide]
  (** Doc' for MyM *)

  (** Doc for WithModule *)
  module type WithModule = ForWithModule with module M = MyM
  (** Doc' for WithModule *)

  (** Doc for WithModuleSubst *)
  module type WithModuleSubst = ForWithModule with module M := MyM
  (** Doc' for WithModuleSubst *)
end

include MT
