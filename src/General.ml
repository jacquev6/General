(* @todo Pick everything from Implementation.
Foundations modules should all be replicated in Implementation, if only for tests. *)

module Traits = Traits

module Concepts = Concepts

module Bool = Implementation.Bool
module Exception = Implementation.Exception
module Exit = Implementation.Exit
module Format = Foundations.Format_
module Float = Implementation.Float
module Int = Implementation.Int

module Std = struct
  module Bool = Bool
  module Exception = Exception
  module Exit = Exit
  module Float = Float
  module Format = Format
  module Int = Int

  include (Pervasives_: module type of Pervasives_
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

  include Pervasives_
end

module Compare = Foundations.Compare

module Equate = Foundations.Equate

module Testing = Testing
