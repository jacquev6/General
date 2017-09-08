include Impl

module Shorten = Implementation.Shorten
module Compare = Implementation.Compare
module Equate = Implementation.Equate

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
    Pervasives: module type of Pervasives
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
    Pervasives: module type of Pervasives
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
