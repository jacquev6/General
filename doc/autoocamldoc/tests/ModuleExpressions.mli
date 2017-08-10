module M: sig end

module Identifier: module type of M

module Functor(A: sig type a end): sig type z end

module AA: sig type a end

module Application: module type of Functor(AA)

module FunctorMulti(A: sig type a end)(B: sig type b end)(C: sig type c end): sig type z end

module BB: sig type b end
module CC: sig type c end

module ApplicationMulti: module type of FunctorMulti(AA)(BB)(CC)

module ApplicationPartial: module type of FunctorMulti(AA)
module ApplicationPartial2: module type of ApplicationPartial(BB)
module ApplicationTotal: module type of ApplicationPartial2(CC)
module ApplicationTotal2: module type of ApplicationPartial(BB)(CC)
