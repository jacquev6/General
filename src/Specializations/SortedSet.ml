open Implementation
module SortedSet = Implementation.SortedSet

module Int = SortedSet.Make(Int)

module Float = SortedSet.Make(Float)

module String_ = SortedSet.Make(String_)

module Char_ = SortedSet.Make(Char_)
