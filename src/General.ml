module Traits = Traits

module Concepts = Concepts

include BuiltinTypes

module Compare = Compare

module Testing = Testing

let test = Testing.("General" >:: [
  Float.test;
  Int.test;
])
