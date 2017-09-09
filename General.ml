module Reset = struct
  #include "../../src/Reset/CommonHeader.ml"
  #include "../../src/Reset/DefinitionHeader.ml"

  module ResetPervasives = struct
    #include "../../src/Reset/ResetPervasives.ml"
  end

  module ResetStandardLibrary = struct
    #include "../../src/Reset/ResetStandardLibrary.ml"
  end

  #include "../../src/Reset/Footer.ml"
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

module Ubiquitous = struct
  include Reset.ResetPervasives
  include Reset.ResetStandardLibrary
  include Foundations.PervasivesWhitelist
end

module Pervasives = Ubiquitous

open Ubiquitous

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
