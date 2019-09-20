module Reset = struct
  #define SIGNATURE 0
  #include "Reset/ResetPervasives.ml"
  #include "Reset/ResetStandardLibrary.ml"
  #undef SIGNATURE
end

open Reset

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
  module Format = struct
    #include "OldFashion/Foundations/Format.ml"
  end

  module Lazy = struct
    #include "Wrappers/Lazy.foundations.ml"
  end

  module Exception = struct
    #include "Atoms/Exception.foundations.ml"
  end

  module Function1 = struct
    #include "Atoms/Function1.foundations.ml"
  end

  module Int = struct
    #include "Atoms/Int.foundations.ml"
  end

  module Bool = struct
    #include "Atoms/Bool.foundations.ml"
  end

  module Option = struct
    #include "Wrappers/Option.foundations.ml"
  end

  module List = struct
    #include "OldFashion/Foundations/List.ml"
  end

  module CallStack = struct
    #include "Atoms/CallStack.foundations.ml"
  end

  module Float = struct
    #include "Atoms/Float.foundations.ml"
  end

  module Reference = struct
    #include "Wrappers/Reference.foundations.ml"
  end

  module String = struct
    #include "Atoms/String.foundations.ml"
  end

  module IntRange = struct
    #include "OldFashion/Foundations/IntRange.ml"
  end

  module Tuple2 = struct
    #include "Wrappers/Tuple2.foundations.ml"
  end

  module Tuple3 = struct
    #include "Wrappers/Tuple3.foundations.ml"
  end

  module Tuple4 = struct
    #include "Wrappers/Tuple4.foundations.ml"
  end

  module Tuple5 = struct
    #include "Wrappers/Tuple5.foundations.ml"
  end

  module Exit = struct
    #include "Atoms/Exit.foundations.ml"
  end

  module Stream = struct
    #include "OldFashion/Foundations/Stream.ml"
  end

  module Unit = struct
    #include "Atoms/Unit.foundations.ml"
  end

  module PervasivesWhitelist = struct
    #include "Reset/PervasivesWhitelist.ml"
  end
end

module Ubiquitous = struct
  include Reset
  include Foundations.PervasivesWhitelist
end

module OCamlStandard = Ubiquitous.OCamlStandard

open Ubiquitous

open Foundations

module Test = struct
  #include "Testing/Test.ml"
end

module Testing = struct
  #include "Testing/Testing.ml"
end

module Facets = struct
  module Representable = struct
    #include "Facets/Representable.ml"
  end

  module Equatable = struct
    #include "Facets/Equatable.ml"
  end

  module Comparable = struct
    #include "Facets/Comparable.ml"
  end

  module Displayable = struct
    #include "Facets/Displayable.ml"
  end

  module Parsable = struct
    #include "Facets/Parsable.ml"
  end

  module PredSucc = struct
    #include "Facets/PredSucc.ml"
  end

  module OfInt = struct
    #include "Facets/OfInt.ml"
  end

  module ToInt = struct
    #include "Facets/ToInt.ml"
  end

  module OfFloat = struct
    #include "Facets/OfFloat.ml"
  end

  module ToFloat = struct
    #include "Facets/ToFloat.ml"
  end

  module Ringoid = struct
    #include "Facets/Ringoid.ml"
  end

  module Bounded = struct
    #include "Facets/Bounded.ml"
  end

  module Bitwise = struct
    #include "Facets/Bitwise.ml"
  end

  module FilterMapable = struct
    #include "OldFashion/Facets/FilterMapable.ml"
  end

  module Foldable = struct
    #include "OldFashion/Facets/Foldable.ml"
  end

  module Scanable = struct
    #include "OldFashion/Facets/Scanable.ml"
  end

  module Identifiable = struct
    #include "Facets/Identifiable.ml"
  end

  module Able = struct
    #include "Facets/Able.ml"
  end

  module Stringable = struct
    #include "Facets/Stringable.ml"
  end

  module OfStandardNumber = struct
    #include "Facets/OfStandardNumber.ml"
  end

  module Number = struct
    #include "Facets/Number.ml"
  end

  module ToStandardNumber = struct
    #include "Facets/ToStandardNumber.ml"
  end

  module RealNumber = struct
    #include "Facets/RealNumber.ml"
  end

  module Integer = struct
    #include "Facets/Integer.ml"
  end

  module FixedWidthInteger = struct
    #include "Facets/FixedWidthInteger.ml"
  end
end

module Array = struct
  #include "OldFashion/Implementation/Array.ml"
end

module Exception = struct
  #include "Atoms/Exception.ml"
end

module Format = struct
  #include "OldFashion/Implementation/Format.ml"
end

module StandardInt = struct
  #include "Atoms/StandardInt.ml"
end

module Int32 = struct
  #include "Atoms/Int32.ml"
end

module Int64 = struct
  #include "Atoms/Int64.ml"
end

module Float = struct
  #include "Atoms/Float.ml"
end

module BigInt = struct
  #include "Atoms/BigInt.ml"
end

module Bool = struct
  #include "Atoms/Bool.ml"
end

module Bytes = struct
  #include "Atoms/Bytes.ml"
end

module Int = struct
  #include "Atoms/Int.ml"
end

module List = struct
  #include "OldFashion/Implementation/List.ml"
end

module CallStack = struct
  #include "Atoms/CallStack.ml"
end

module Char = struct
  #include "Atoms/Char.ml"
end

module Exit = struct
  #include "Atoms/Exit.ml"
end

module Function1 = struct
  #include "Atoms/Function1.ml"
end

module Function2 = struct
  #include "Atoms/Function2.ml"
end

module Function3 = struct
  #include "Atoms/Function3.ml"
end

module Function4 = struct
  #include "Atoms/Function4.ml"
end

module Function5 = struct
  #include "Atoms/Function5.ml"
end

module InChannel = struct
  #include "OldFashion/Implementation/InChannel.ml"
end

module InFile = struct
  #include "OldFashion/Implementation/InFile.ml"
end

module IntRange = struct
  #include "OldFashion/Implementation/IntRange.ml"
end

module Lazy = struct
  #include "Wrappers/Lazy.ml"
end

module NativeInt = struct
  #include "Atoms/NativeInt.ml"
end

module Option = struct
  #include "Wrappers/Option.ml"
end

module OutChannel = struct
  #include "OldFashion/Implementation/OutChannel.ml"
end

module OutFile = struct
  #include "OldFashion/Implementation/OutFile.ml"
end

module Tuple2 = struct
  #include "Wrappers/Tuple2.ml"
end

module Tuple3 = struct
  #include "Wrappers/Tuple3.ml"
end

module Tuple4 = struct
  #include "Wrappers/Tuple4.ml"
end

module Tuple5 = struct
  #include "Wrappers/Tuple5.ml"
end

module RedBlackTree = struct
  #include "OldFashion/Implementation/RedBlackTree.ml"
end

module BinaryHeap = struct
  #include "OldFashion/Implementation/BinaryHeap.ml"
end

module PriorityQueue = struct
  #include "OldFashion/Implementation/PriorityQueue.ml"
end

module Reference = struct
  #include "Wrappers/Reference.ml"
end

module SortedMap = struct
  #include "OldFashion/Implementation/SortedMap.ml"
end

module SortedSet = struct
  #include "OldFashion/Implementation/SortedSet.ml"
end

module Heap = struct
  #include "OldFashion/Implementation/Heap.ml"
end

module StandardOutChannel = struct
  #include "OldFashion/Implementation/StandardOutChannel.ml"
end

module StdErr = struct
  #include "OldFashion/Implementation/StdErr.ml"
end

module StdIn = struct
  #include "OldFashion/Implementation/StdIn.ml"
end

module StdOut = struct
  #include "OldFashion/Implementation/StdOut.ml"
end

module Stream = struct
  #include "OldFashion/Implementation/Stream.ml"
end

module String = struct
  #include "Atoms/String.ml"
end

module TestingTests = struct
  #include "Testing/Tests.ml"
end

module Unit = struct
  #include "Atoms/Unit.ml"
end

module Specializations = struct
  module List = struct
    #include "OldFashion/Specializations/List.ml"
  end

  module Option = struct
    #include "OldFashion/Specializations/Option.ml"
  end

  module Reference = struct
    #include "OldFashion/Specializations/Reference.ml"
  end

  module SortedMap = struct
    #include "OldFashion/Specializations/SortedMap.ml"
  end

  module SortedSet = struct
    #include "OldFashion/Specializations/SortedSet.ml"
  end
end

module FloatOption = Specializations.Option.Float
module IntOption = Specializations.Option.Int
module StringOption = Specializations.Option.String

module FloatReference = Specializations.Reference.Float
module IntReference = Specializations.Reference.Int
module StringReference = Specializations.Reference.String

module FloatList = Specializations.List.Float
module IntList = Specializations.List.Int
module StringList = Specializations.List.String

module CharSortedSet = Specializations.SortedSet.Char
module FloatSortedSet = Specializations.SortedSet.Float
module IntSortedSet = Specializations.SortedSet.Int
module StringSortedSet = Specializations.SortedSet.String

module CharSortedMap = Specializations.SortedMap.Char
module FloatSortedMap = Specializations.SortedMap.Float
module IntSortedMap = Specializations.SortedMap.Int
module StringSortedMap = Specializations.SortedMap.String

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
  module Heap = Heap
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
  module PriorityQueue = PriorityQueue
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
    Ubiquitous: module type of Ubiquitous[@remove_aliases]
    with module Array := Array
    and module Bytes := Bytes
    and module Char := Char
    and module Float := Float
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
  module Heap = Heap
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
  module PriQu = PriorityQueue
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
    Ubiquitous: module type of Ubiquitous[@remove_aliases]
    with module Int32 := Int32
    and module Int64 := Int64
  )
end

module Tests = struct
  open Testing

  let test = "General" >:: [
    BigInt.Tests.test;
    BinaryHeap.Tests.test;
    Bool.Tests.test;
    Bytes.Tests.test;
    CallStack.Tests.test;
    Char.Tests.test;
    Exception.Tests.test;
    Exit.Tests.test;
    Float.Tests.test;
    Function1.Tests.test;
    Function2.Tests.test;
    Function3.Tests.test;
    Function4.Tests.test;
    Function5.Tests.test;
    Int.Tests.test;
    Int32.Tests.test;
    Int64.Tests.test;
    Lazy.Tests.test;
    List.Tests.test;
    NativeInt.Tests.test;
    Option.Tests.test;
    RedBlackTree.Tests.test;
    Reference.Tests.test;
    Stream.Tests.test;
    String.Tests.test;
    Tuple2.Tests.test;
    Tuple3.Tests.test;
    Tuple4.Tests.test;
    Tuple5.Tests.test;
    Unit.Tests.test;

    IntRange.Tests.test;

    TestingTests.Tests.test;

    "Syntactic sugar" >:: [
      "Standard" >:: Standard.[
        "array" >:: [
          "get" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 a.(0)));
          "set" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 (Array.get a 0); a.(0) <- 37; check_int ~expected:37 (Array.get a 0)));
        ];
        (* @todo Use check_char *)
        "string" >:: [
          "get" >: (let a: string = "a" in lazy (Char.(check ~repr ~equal ~expected:'a' a.[0])));
          #if OCAML_VERSION < (4, 6, 0)
          (* @todo Fix that test in node.js *)
          (* "set" >: (let a: string = "a" in lazy (Char.(check ~repr ~equal ~expected:'a' (String.get a 0)); a.[0] <- 'z'; Char.(check ~repr ~equal ~expected:'z' (String.get a 0)))); *)
          #endif
        ];
        "bytes" >:: [
          "set" >: (let a: bytes = Bytes.of_string "a" in lazy (Char.(check ~repr ~equal ~expected:'a' (Bytes.get a 0)); a.[0] <- 'z'; Char.(check ~repr ~equal ~expected:'z' (Bytes.get a 0))));
        ];
      ];
      "Abbr" >:: Abbr.[
        "array" >:: [
          "get" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 a.(0)));
          "set" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 (Ar.get a 0); a.(0) <- 37; check_int ~expected:37 (Ar.get a 0)));
        ];
        (* @todo Use check_char *)
        "string" >:: [
          "get" >: (let a: string = "a" in lazy (Ch.(check ~repr ~equal ~expected:'a' a.[0])));
          #if OCAML_VERSION < (4, 6, 0)
          (* "set" >: (let a: string = "a" in lazy (Ch.(check ~repr ~equal ~expected:'a' (Str.get a 0)); a.[0] <- 'z'; Ch.(check ~repr ~equal ~expected:'z' (Str.get a 0)))); *)
          #endif
        ];
        "bytes" >:: [
          "set" >: (let a: bytes = By.of_string "a" in lazy (Ch.(check ~repr ~equal ~expected:'a' (By.get a 0)); a.[0] <- 'z'; Ch.(check ~repr ~equal ~expected:'z' (By.get a 0))));
        ];
      ];
    ];
  ]
end
