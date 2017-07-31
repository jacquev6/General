(* @todo Pick everything from Implementation.
Foundations modules should all be replicated in Implementation, if only for tests. *)

module Compare = Foundations.Compare

module Equate = Foundations.Equate

module Traits = Traits

module Concepts = Concepts

module Exception = Implementation.Exception
module Exit = Implementation.Exit

module Bool = Implementation.Bool
module Int = Implementation.Int
module Float = Implementation.Float

module Format = Foundations.Format_

module Testing = Testing

module Pervasives = Pervasives_

module Std = struct
  module Bool = Bool
  module Exception = Exception
  module Exit = Exit
  module Float = Float
  module Format = Format
  module Int = Int

  include (Pervasives: module type of Pervasives
  with module Format := Format
  )
end

module Abbr = struct
  module Bo = Bool
  module Exit = Exit
  module Exn = Exception
  module Fl = Float
  module Frmt = Format
  module Int = Int

  include Pervasives
end
