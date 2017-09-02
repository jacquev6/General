open Implementation
module SortedMap = Implementation.SortedMap

module Int = SortedMap.Make(Int)

module Float = SortedMap.Make(Float)

module String_ = SortedMap.Make(String_)

module Char_ = SortedMap.Make(Char_)
