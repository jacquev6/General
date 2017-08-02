module Pervasives = Pervasives_

module Compare = Implementation.Compare
module Equate = Implementation.Equate

module Traits = Traits
module Concepts = Concepts
module Testing = Testing

module Array = Implementation.Array_
module Bool = Implementation.Bool
module Char = Implementation.Char_
module Exception = Implementation.Exception
module Exit = Implementation.Exit
module Float = Implementation.Float
module Format = Implementation.Format_
include Implementation.Functions
module Int = Implementation.Int
module Lazy = Implementation.Lazy_
module List = Implementation.List_
module Option = Implementation.Option
module Reference = Implementation.Reference
module String = Implementation.String_
module Tuple2 = Implementation.Tuple2
module Unit = Implementation.Unit

module IntReference = Specializations.Reference.Int
module StringList = Specializations.List_.String_

module Standard = struct
  module Testing = Testing

  module Array = Array
  module Bool = Bool
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
  module Lazy = Lazy
  module List = List
  module Option = Option
  module Reference = Reference
  module String = String
  module Tuple2 = Tuple2
  module Unit = Unit

  module IntReference = IntReference
  module StringList = StringList

  include (
    Pervasives: module type of Pervasives
    with module Array := Array
    and module Char := Char
    and module Format := Format
    and module Lazy := Lazy
    and module List := List
    and module String := String
  )
end

module Abbr = struct
  module Tst = Testing

  module Ar = Array
  module Bo = Bool
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
  module Laz = Lazy
  module Li = List
  module Opt = Option
  module Ref = Reference
  module Str = String
  module Tu2 = Tuple2
  module Unit = Unit

  module IntRef = IntReference
  module StrLi = StringList

  include Pervasives
end
