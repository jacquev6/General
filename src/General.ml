module Traits = Traits
module Concepts = Concepts
include BuiltinTypes
module Compare = Compare

open Testing

let test = "General" >::: [
  Int.test;
]
