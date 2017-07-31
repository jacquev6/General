(* @todo Pick everything from Implementation.
Foundations modules should all be replicated in Implementation, if only for tests. *)

module Pervasives = Pervasives_

module Compare = Foundations.Compare
module Equate = Foundations.Equate

module Traits = Traits
module Concepts = Concepts
module Testing = Testing

module Bool = Implementation.Bool
module Char = Implementation.Char_
module Exception = Implementation.Exception
module Exit = Implementation.Exit
module Float = Implementation.Float
module Format = Foundations.Format_
module Function = Foundations.Function
module Int = Implementation.Int
module Lazy = Foundations.Lazy_
module Option = Implementation.Option
module Reference = Implementation.Reference
module String = Implementation.String_
module Tuple2 = Foundations.Tuple2
module Unit = Foundations.Unit

module Std = struct
  module Bool = Bool
  module Char = Char
  module Exception = Exception
  module Exit = Exit
  module Float = Float
  module Format = Format
  module Function = Function
  module Int = Int
  module Lazy = Lazy
  module Option = Option
  module Reference = Reference
  module String = String
  module Tuple2 = Tuple2
  module Unit = Unit

  include (
    Pervasives: module type of Pervasives
    with module Char := Char
    and module Format := Format
    and module Lazy := Lazy
    and module String := String
  )
end

module Abbr = struct
  module Bo = Bool
  module Ch = Char
  module Exit = Exit
  module Exn = Exception
  module Fl = Float
  module Frmt = Format
  module Fun = Function
  module Int = Int
  module Laz = Lazy
  module Opt = Option
  module Ref = Reference
  module Str = String
  module Tu2 = Tuple2
  module Unit = Unit

  include Pervasives
end
