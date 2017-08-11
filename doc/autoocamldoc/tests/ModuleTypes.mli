module Signature: sig
end

module Identifier: Set.OrderedType

(* @todo module InlinedIdentifier: Set.OrderedType [@autodoc.inline] *)

(* @todo Inline with two '@' as well: not doing it would be too error-prone.
module InlinedIdentifier: Set.OrderedType [@@autodoc.inline] *)

module Functor(A: sig type a end): sig type z end
module FunctorMulti(A: sig type a end)(B: sig type b end)(C: sig type c end): sig type z end

module TypeOf: module type of Identifier

module WithType: Set.OrderedType with type t = int
module WithTypeSubst: Set.OrderedType with type t := int

module type Null

module type Replacable = sig
  module M: Null
end

module ReplaceM: Null

module Replaced: Replacable with module M = ReplaceM

module Substituted: Replacable with module M := ReplaceM
