open BuiltinTypes_
module Array = Array_
module Bool = Bool_
module Bytes = Bytes_
module Exception = Exception_
module Float = Float_
module Format = Format_
module Int = Int_
module Int32 = Int32_
module Int64 = Int64_
module Lazy = Lazy_
module List = List_
module NatInt = NativeInt_
module Option = Option_
module String = String_
module Unit = Unit_

open StdLibTypes_
module InChannel = InChannel_
module OutChannel = OutChannel_
module Reference = Reference_

open ExtensionTypes_
module Tuple2 = Tuple2_

include (Ubiquitous: module type of Ubiquitous
  with module Array := Array
  and module Bytes := Bytes
  and module Format := Format
  and module Int32 := Int32
  and module Int64 := Int64
  and module Lazy := Lazy
  and module List := List
  and module String := String
)
