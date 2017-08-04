module Pervasives = Pervasives_

module Compare = Implementation.Compare
module Equate = Implementation.Equate

module Traits = Traits
module Concepts = Concepts
module Testing = Testing

module Array = Implementation.Array_
module BigInt = Implementation.BigInt
module Bool = Implementation.Bool
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
module Int = Implementation.Int
module Int32 = Implementation.Int32_
module Int64 = Implementation.Int64_
module Lazy = Implementation.Lazy_
module List = Implementation.List_
module NativeInt = Implementation.NativeInt
module Option = Implementation.Option
module Reference = Implementation.Reference
module String = Implementation.String_
module Tuple2 = Implementation.Tuples.Tuple2
module Tuple3 = Implementation.Tuples.Tuple3
module Tuple4 = Implementation.Tuples.Tuple4
module Tuple5 = Implementation.Tuples.Tuple5
module Unit = Implementation.Unit

module IntReference = Specializations.Reference.Int
module StringList = Specializations.List_.String_

module Standard = struct
  module Testing = Testing

  module Array = Array
  module BigInt = BigInt
  module Bool = Bool
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
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Lazy = Lazy
  module List = List
  module NativeInt = NativeInt
  module Option = Option
  module Reference = Reference
  module String = String
  module Tuple2 = Tuple2
  module Tuple3 = Tuple3
  module Tuple4 = Tuple4
  module Tuple5 = Tuple5
  module Unit = Unit

  module IntReference = IntReference
  module StringList = StringList

  include (
    Pervasives: module type of Pervasives
    with module Array := Array
    and module Char := Char
    and module Format := Format
    and module Int32 := Int32
    and module Int64 := Int64
    and module Lazy := Lazy
    and module List := List
    and module String := String
  )
end

module Abbr = struct
  module Tst = Testing

  module Ar = Array
  module BigInt = BigInt
  module Bo = Bool
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
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Laz = Lazy
  module Li = List
  module NativeInt = NativeInt
  module Opt = Option
  module Ref = Reference
  module Str = String
  module Tu2 = Tuple2
  module Tu3 = Tuple3
  module Tu4 = Tuple4
  module Tu5 = Tuple5
  module Unit = Unit

  module IntRef = IntReference
  module StrLi = StringList

  include (
    Pervasives: module type of Pervasives
    with module Int32 := Int32
    and module Int64 := Int64
  )
end
