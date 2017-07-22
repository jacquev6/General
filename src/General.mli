module Traits: module type of Traits
module Concepts: module type of Concepts
include module type of BuiltinTypes

module Compare: module type of Compare with type t = Compare.t

include Testing.Testable
