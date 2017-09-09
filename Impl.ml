module Reset = struct
  module CommonHeader = struct
    #include "../../src/Reset/CommonHeader.ml"
  end

  module DefinitionHeader = struct
    #include "../../src/Reset/DefinitionHeader.ml"
  end

  module ResetPervasives = struct
    #include "../../src/Reset/ResetPervasives.ml"
  end

  module ResetStandardLibrary = struct
    #include "../../src/Reset/ResetStandardLibrary.ml"
  end

  module Footer = struct
    #include "../../src/Reset/Footer.ml"
  end
end

open Reset.ResetPervasives
open Reset.ResetStandardLibrary

module OCSP = OCamlStandard.Pervasives

module Equate = struct
  #include "../../src/Equate.ml"
end

module Compare = struct
  #include "../../src/Compare.ml"
end

module Shorten = struct
  #include "../../src/Shorten.ml"
end

module Foundations = struct
  module Format_ = struct
    #include "../../src/Foundations/Format_.ml"
  end

  module Lazy_ = struct
    #include "../../src/Foundations/Lazy_.ml"
  end

  module Exception = struct
    #include "../../src/Foundations/Exception.ml"
  end

  module Functions = struct
    #include "../../src/Foundations/Functions.ml"
  end

  module Int = struct
    #include "../../src/Foundations/Int.ml"
  end

  module Bool = struct
    #include "../../src/Foundations/Bool.ml"
  end

  module Option = struct
    #include "../../src/Foundations/Option.ml"
  end

  module List_ = struct
    #include "../../src/Foundations/List_.ml"
  end

  module CallStack = struct
    #include "../../src/Foundations/CallStack.ml"
  end

  module Float = struct
    #include "../../src/Foundations/Float.ml"
  end

  module Reference = struct
    #include "../../src/Foundations/Reference.ml"
  end

  module String_ = struct
    #include "../../src/Foundations/String_.ml"
  end

  module IntRange = struct
    #include "../../src/Foundations/IntRange.ml"
  end

  module Tuples = struct
    #include "../../src/Foundations/Tuples.ml"
  end

  module Exit = struct
    #include "../../src/Foundations/Exit.ml"
  end

  module Stream_ = struct
    #include "../../src/Foundations/Stream_.cppo.ml"
  end

  module Unit = struct
    #include "../../src/Foundations/Unit.ml"
  end

  module PervasivesWhitelist = struct
    #include "../../src/Foundations/PervasivesWhitelist.ml"
  end
end

open Foundations

module Pervasives = struct
  include Reset.ResetPervasives
  include Reset.ResetStandardLibrary
  include Foundations.PervasivesWhitelist
end

open Pervasives

module Testing = struct
  #include "../../src/Testing.cppo.ml"
end

module Traits = struct
  module Representable = struct
    #include "../../src/Traits/Representable.ml"
  end

  module Equatable = struct
    #include "../../src/Traits/Equatable.ml"
  end

  module Comparable = struct
    #include "../../src/Traits/Comparable.ml"
  end

  module Displayable = struct
    #include "../../src/Traits/Displayable.ml"
  end

  module Parsable = struct
    #include "../../src/Traits/Parsable.ml"
  end

  module PredSucc = struct
    #include "../../src/Traits/PredSucc.ml"
  end

  module Ringoid = struct
    #include "../../src/Traits/Ringoid.ml"
  end

  module FilterMapable = struct
    #include "../../src/Traits/FilterMapable.ml"
  end

  module Foldable = struct
    #include "../../src/Traits/Foldable.ml"
  end

  module Scanable = struct
    #include "../../src/Traits/Scanable.ml"
  end
end

module Concepts = struct
  module Identifiable = struct
    #include "../../src/Concepts/Identifiable.ml"
  end

  module Able = struct
    #include "../../src/Concepts/Able.ml"
  end

  module Number = struct
    #include "../../src/Concepts/Number.ml"
  end

  module RealNumber = struct
    #include "../../src/Concepts/RealNumber.ml"
  end

  module Integer = struct
    #include "../../src/Concepts/Integer.ml"
  end
end

module Implementation = struct
  module Array_ = struct
    #include "../../src/Implementation/Array_.ml"
  end

  module Exception = struct
    #include "../../src/Implementation/Exception.ml"
  end

  module Format_ = struct
    #include "../../src/Implementation/Format_.ml"
  end

  module StandardInt = struct
    #include "../../src/Implementation/StandardInt.ml"
  end

  module Int32_ = struct
    #include "../../src/Implementation/Int32_.cppo.ml"
  end

  module Int64_ = struct
    #include "../../src/Implementation/Int64_.cppo.ml"
  end

  module Float = struct
    #include "../../src/Implementation/Float.ml"
  end

  module BigInt = struct
    #include "../../src/Implementation/BigInt.ml"
  end

  module Bool = struct
    #include "../../src/Implementation/Bool.ml"
  end

  module Bytes_ = struct
    #include "../../src/Implementation/Bytes_.ml"
  end

  module Int = struct
    #include "../../src/Implementation/Int.ml"
  end

  module List_ = struct
    #include "../../src/Implementation/List_.ml"
  end

  module CallStack = struct
    #include "../../src/Implementation/CallStack.ml"
  end

  module Char_ = struct
    #include "../../src/Implementation/Char_.ml"
  end

  module Exit = struct
    #include "../../src/Implementation/Exit.ml"
  end

  module Functions = struct
    #include "../../src/Implementation/Functions.ml"
  end

  module InChannel = struct
    #include "../../src/Implementation/InChannel.ml"
  end

  module InFile = struct
    #include "../../src/Implementation/InFile.ml"
  end

  module IntRange = struct
    #include "../../src/Implementation/IntRange.ml"
  end

  module Lazy_ = struct
    #include "../../src/Implementation/Lazy_.ml"
  end

  module NativeInt_ = struct
    #include "../../src/Implementation/NativeInt_.cppo.ml"
  end

  module Option = struct
    #include "../../src/Implementation/Option.ml"
  end

  module OutChannel = struct
    #include "../../src/Implementation/OutChannel.ml"
  end

  module OutFile = struct
    #include "../../src/Implementation/OutFile.ml"
  end

  module Tuples = struct
    #include "../../src/Implementation/Tuples.cppo.ml"
  end

  module RedBlackTree = struct
    #include "../../src/Implementation/RedBlackTree.cppo.ml"
  end

  module Reference = struct
    #include "../../src/Implementation/Reference.ml"
  end

  module SortedMap = struct
    #include "../../src/Implementation/SortedMap.ml"
  end

  module SortedSet = struct
    #include "../../src/Implementation/SortedSet.ml"
  end

  module StandardOutChannel = struct
    #include "../../src/Implementation/StandardOutChannel.ml"
  end

  module StdErr = struct
    #include "../../src/Implementation/StdErr.ml"
  end

  module StdIn = struct
    #include "../../src/Implementation/StdIn.ml"
  end

  module StdOut = struct
    #include "../../src/Implementation/StdOut.ml"
  end

  module Stream_ = struct
    #include "../../src/Implementation/Stream_.ml"
  end

  module String_ = struct
    #include "../../src/Implementation/String_.ml"
  end

  module TestingTests = struct
    #include "../../src/Implementation/TestingTests.ml"
  end

  module Unit = struct
    #include "../../src/Implementation/Unit.ml"
  end
end

module Specializations = struct
  module List_ = struct
    #include "../../src/Specializations/List_.ml"
  end

  module Option = struct
    #include "../../src/Specializations/Option.ml"
  end

  module Reference = struct
    #include "../../src/Specializations/Reference.ml"
  end

  module SortedMap = struct
    #include "../../src/Specializations/SortedMap.ml"
  end

  module SortedSet = struct
    #include "../../src/Specializations/SortedSet.ml"
  end
end
