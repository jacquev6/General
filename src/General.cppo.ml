module Reset = struct
  #include "Reset/CommonHeader.ml"
  #include "Reset/DefinitionHeader.ml"

  module ResetPervasives = struct
    #include "Reset/ResetPervasives.ml"
  end

  module ResetStandardLibrary = struct
    #include "Reset/ResetStandardLibrary.ml"
  end

  #include "Reset/Footer.ml"
end

open Reset.ResetPervasives
open Reset.ResetStandardLibrary

module OCSP = OCamlStandard.Pervasives

module Equate = struct
  #include "Equate.ml"
end

module Compare = struct
  #include "Compare.ml"
end

module Shorten = struct
  #include "Shorten.ml"
end

module Foundations = struct
  module Format_ = struct
    #include "Foundations/Format_.ml"
  end

  module Lazy_ = struct
    #include "Foundations/Lazy_.ml"
  end

  module Exception = struct
    #include "Foundations/Exception.ml"
  end

  module Functions = struct
    #include "Foundations/Functions.ml"
  end

  module Int = struct
    #include "Foundations/Int.ml"
  end

  module Bool = struct
    #include "Foundations/Bool.ml"
  end

  module Option = struct
    #include "Foundations/Option.ml"
  end

  module List_ = struct
    #include "Foundations/List_.ml"
  end

  module CallStack = struct
    #include "Foundations/CallStack.ml"
  end

  module Float = struct
    #include "Foundations/Float.ml"
  end

  module Reference = struct
    #include "Foundations/Reference.ml"
  end

  module String_ = struct
    #include "Foundations/String_.ml"
  end

  module IntRange = struct
    #include "Foundations/IntRange.ml"
  end

  module Tuples = struct
    #include "Foundations/Tuples.ml"
  end

  module Exit = struct
    #include "Foundations/Exit.ml"
  end

  module Stream_ = struct
    #include "Foundations/Stream_.ml"
  end

  module Unit = struct
    #include "Foundations/Unit.ml"
  end

  module PervasivesWhitelist = struct
    #include "Foundations/PervasivesWhitelist.ml"
  end
end

open Foundations

module Ubiquitous = struct
  include Reset.ResetPervasives
  include Reset.ResetStandardLibrary
  include Foundations.PervasivesWhitelist
end

module Pervasives = Ubiquitous

open Ubiquitous

module Testing = struct
  #include "Testing.ml"
end

module Traits = struct
  module Representable = struct
    #include "Traits/Representable.ml"
  end

  module Equatable = struct
    #include "Traits/Equatable.ml"
  end

  module Comparable = struct
    #include "Traits/Comparable.ml"
  end

  module Displayable = struct
    #include "Traits/Displayable.ml"
  end

  module Parsable = struct
    #include "Traits/Parsable.ml"
  end

  module PredSucc = struct
    #include "Traits/PredSucc.ml"
  end

  module Ringoid = struct
    #include "Traits/Ringoid.ml"
  end

  module FilterMapable = struct
    #include "Traits/FilterMapable.ml"
  end

  module Foldable = struct
    #include "Traits/Foldable.ml"
  end

  module Scanable = struct
    #include "Traits/Scanable.ml"
  end
end

module Concepts = struct
  module Identifiable = struct
    #include "Concepts/Identifiable.ml"
  end

  module Able = struct
    #include "Concepts/Able.ml"
  end

  module Number = struct
    #include "Concepts/Number.ml"
  end

  module RealNumber = struct
    #include "Concepts/RealNumber.ml"
  end

  module Integer = struct
    #include "Concepts/Integer.ml"
  end
end

module Implementation = struct
  module Array_ = struct
    #include "Implementation/Array_.ml"
  end

  module Exception = struct
    #include "Implementation/Exception.ml"
  end

  module Format_ = struct
    #include "Implementation/Format_.ml"
  end

  module StandardInt = struct
    #include "Implementation/StandardInt.ml"
  end

  module Int32_ = struct
    #include "Implementation/Int32_.ml"
  end

  module Int64_ = struct
    #include "Implementation/Int64_.ml"
  end

  module Float = struct
    #include "Implementation/Float.ml"
  end

  module BigInt = struct
    #include "Implementation/BigInt.ml"
  end

  module Bool = struct
    #include "Implementation/Bool.ml"
  end

  module Bytes_ = struct
    #include "Implementation/Bytes_.ml"
  end

  module Int = struct
    #include "Implementation/Int.ml"
  end

  module List_ = struct
    #include "Implementation/List_.ml"
  end

  module CallStack = struct
    #include "Implementation/CallStack.ml"
  end

  module Char_ = struct
    #include "Implementation/Char_.ml"
  end

  module Exit = struct
    #include "Implementation/Exit.ml"
  end

  module Functions = struct
    #include "Implementation/Functions.ml"
  end

  module InChannel = struct
    #include "Implementation/InChannel.ml"
  end

  module InFile = struct
    #include "Implementation/InFile.ml"
  end

  module IntRange = struct
    #include "Implementation/IntRange.ml"
  end

  module Lazy_ = struct
    #include "Implementation/Lazy_.ml"
  end

  module NativeInt_ = struct
    #include "Implementation/NativeInt_.ml"
  end

  module Option = struct
    #include "Implementation/Option.ml"
  end

  module OutChannel = struct
    #include "Implementation/OutChannel.ml"
  end

  module OutFile = struct
    #include "Implementation/OutFile.ml"
  end

  module Tuples = struct
    #include "Implementation/Tuples.ml"
  end

  module RedBlackTree = struct
    #include "Implementation/RedBlackTree.ml"
  end

  module Reference = struct
    #include "Implementation/Reference.ml"
  end

  module SortedMap = struct
    #include "Implementation/SortedMap.ml"
  end

  module SortedSet = struct
    #include "Implementation/SortedSet.ml"
  end

  module StandardOutChannel = struct
    #include "Implementation/StandardOutChannel.ml"
  end

  module StdErr = struct
    #include "Implementation/StdErr.ml"
  end

  module StdIn = struct
    #include "Implementation/StdIn.ml"
  end

  module StdOut = struct
    #include "Implementation/StdOut.ml"
  end

  module Stream_ = struct
    #include "Implementation/Stream_.ml"
  end

  module String_ = struct
    #include "Implementation/String_.ml"
  end

  module TestingTests = struct
    #include "Implementation/TestingTests.ml"
  end

  module Unit = struct
    #include "Implementation/Unit.ml"
  end
end

module Specializations = struct
  module List_ = struct
    #include "Specializations/List_.ml"
  end

  module Option = struct
    #include "Specializations/Option.ml"
  end

  module Reference = struct
    #include "Specializations/Reference.ml"
  end

  module SortedMap = struct
    #include "Specializations/SortedMap.ml"
  end

  module SortedSet = struct
    #include "Specializations/SortedSet.ml"
  end
end

module Array = Implementation.Array_
module BigInt = Implementation.BigInt
module Bool = Implementation.Bool
module Bytes = Implementation.Bytes_
module CallStack = Implementation.CallStack
module Char = Implementation.Char_
module Exception = Implementation.Exception
module Exit = Implementation.Exit
module Float = Implementation.Float
module Format = Implementation.Format_
module Function1 = Implementation.Functions.Function1
module Function2 = Implementation.Functions.Function2
module Function3 = Implementation.Functions.Function3
module Function4 = Implementation.Functions.Function4
module Function5 = Implementation.Functions.Function5
module InChannel = Implementation.InChannel
module InFile = Implementation.InFile
module Int = Implementation.Int
module Int32 = Implementation.Int32_
module Int64 = Implementation.Int64_
module Lazy = Implementation.Lazy_
module List = Implementation.List_
module NativeInt = Implementation.NativeInt_
module Option = Implementation.Option
module OutChannel = Implementation.OutChannel
module OutFile = Implementation.OutFile
module Reference = Implementation.Reference
module SortedMap = Implementation.SortedMap
module SortedSet = Implementation.SortedSet
module StdErr = Implementation.StdErr
module StdIn = Implementation.StdIn
module StdOut = Implementation.StdOut
module Stream = Implementation.Stream_
module String = Implementation.String_
module Tuple2 = Implementation.Tuples.Tuple2
module Tuple3 = Implementation.Tuples.Tuple3
module Tuple4 = Implementation.Tuples.Tuple4
module Tuple5 = Implementation.Tuples.Tuple5
module Unit = Implementation.Unit

module IntRange = Implementation.IntRange

module FloatOption = Specializations.Option.Float
module IntOption = Specializations.Option.Int
module StringOption = Specializations.Option.String_

module FloatReference = Specializations.Reference.Float
module IntReference = Specializations.Reference.Int
module StringReference = Specializations.Reference.String_

module FloatList = Specializations.List_.Float
module IntList = Specializations.List_.Int
module StringList = Specializations.List_.String_

module CharSortedSet = Specializations.SortedSet.Char_
module FloatSortedSet = Specializations.SortedSet.Float
module IntSortedSet = Specializations.SortedSet.Int
module StringSortedSet = Specializations.SortedSet.String_

module CharSortedMap = Specializations.SortedMap.Char_
module FloatSortedMap = Specializations.SortedMap.Float
module IntSortedMap = Specializations.SortedMap.Int
module StringSortedMap = Specializations.SortedMap.String_

module Standard = struct
  module Testing = Testing

  module Array = Array
  module BigInt = BigInt
  module Bool = Bool
  module Bytes = Bytes
  module CallStack = CallStack
  module Char = Char
  module Exception = Exception
  module Exit = Exit
  module Float = Float
  module Format = Format
  module Function1 = Function1
  module Function2 = Function2
  module Function3 = Function3
  module Function4 = Function4
  module Function5 = Function5
  module InChannel = InChannel
  module InFile = InFile
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Lazy = Lazy
  module List = List
  module NativeInt = NativeInt
  module Option = Option
  module OutChannel = OutChannel
  module OutFile = OutFile
  module Reference = Reference
  module SortedMap = SortedMap
  module SortedSet = SortedSet
  module StdErr = StdErr
  module StdIn = StdIn
  module StdOut = StdOut
  module Stream = Stream
  module String = String
  module Tuple2 = Tuple2
  module Tuple3 = Tuple3
  module Tuple4 = Tuple4
  module Tuple5 = Tuple5
  module Unit = Unit

  module IntRange = IntRange

  module FloatOption = FloatOption
  module IntOption = IntOption
  module StringOption = StringOption

  module FloatReference = FloatReference
  module IntReference = IntReference
  module StringReference = StringReference

  module FloatList = FloatList
  module IntList = IntList
  module StringList = StringList

  module CharSortedSet = CharSortedSet
  module FloatSortedSet = FloatSortedSet
  module IntSortedSet = IntSortedSet
  module StringSortedSet = StringSortedSet

  module CharSortedMap = CharSortedMap
  module FloatSortedMap = FloatSortedMap
  module IntSortedMap = IntSortedMap
  module StringSortedMap = StringSortedMap

  include (
    Ubiquitous: module type of Ubiquitous
    with module Array := Array
    and module Bytes := Bytes
    and module Char := Char
    and module Format := Format
    and module Int32 := Int32
    and module Int64 := Int64
    and module Lazy := Lazy
    and module List := List
    and module Stream := Stream
    and module String := String
  )
end

module Abbr = struct
  module Tst = Testing

  module Ar = Array
  module BigInt = BigInt
  module Bo = Bool
  module By = Bytes
  module CallStack = CallStack
  module Ch = Char
  module Exit = Exit
  module Exn = Exception
  module Fl = Float
  module Frmt = Format
  module Fun1 = Function1
  module Fun2 = Function2
  module Fun3 = Function3
  module Fun4 = Function4
  module Fun5 = Function5
  module InCh = InChannel
  module InFile = InFile
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Laz = Lazy
  module Li = List
  module NativeInt = NativeInt
  module Opt = Option
  module OutCh = OutChannel
  module OutFile = OutFile
  module Ref = Reference
  module SoMap = SortedMap
  module SoSet = SortedSet
  module StdErr = StdErr
  module StdIn = StdIn
  module StdOut = StdOut
  module Str = String
  module Strm = Stream
  module Tu2 = Tuple2
  module Tu3 = Tuple3
  module Tu4 = Tuple4
  module Tu5 = Tuple5
  module Unit = Unit

  module IntRa = IntRange

  module FlOpt = FloatOption
  module IntOpt = IntOption
  module StrOpt = StringOption

  module FlRef = FloatReference
  module IntRef = IntReference
  module StrRef = StringReference

  module FlLi = FloatList
  module IntLi = IntList
  module StrLi = StringList

  module ChSoSet = CharSortedSet
  module FlSoSet = FloatSortedSet
  module IntSoSet = IntSortedSet
  module StrSoSet = StringSortedSet

  module ChSoMap = CharSortedMap
  module FlSoMap = FloatSortedMap
  module IntSoMap = IntSortedMap
  module StrSoMap = StringSortedMap

  include (
    Ubiquitous: module type of Ubiquitous
    with module Int32 := Int32
    and module Int64 := Int64
  )
end

module Tests = struct
  open Testing

  let test = "General" >:: Implementation.[
    BigInt.Tests.test;
    Bool.Tests.test;
    CallStack.Tests.test;
    Exception.Tests.test;
    Float.Tests.test;
    Functions.Tests.test;
    Int.Tests.test;
    Int32_.Tests.test;
    Int64_.Tests.test;
    Lazy_.Tests.test;
    List_.Tests.test;
    NativeInt_.Tests.test;
    Option.Tests.test;
    RedBlackTree.Tests.test;
    Stream_.Tests.test;
    String_.Tests.test;
    Tuples.Tests.test;

    IntRange.Tests.test;

    TestingTests.Tests.test;
  ]
end
