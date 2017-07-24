module Traits = struct
  module Comparable = Traits.Comparable
  module Equatable = Traits.Equatable
  module Representable = Traits.Representable
  module Ringoid = Traits.Ringoid
end

module Concepts = struct
  module Number = Concepts.Number
  module RealNumber = Concepts.RealNumber
  module Integer = Concepts.Integer
end

include GeneralMin
