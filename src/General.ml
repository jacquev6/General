module Traits = struct
  module Comparable = Traits_Tests.Comparable_Tests
  module Equatable = Traits_Tests.Equatable_Tests
  module Representable = Traits_Tests.Representable_Tests
  module Ringoid = Traits_Tests.Ringoid_Tests
end

module Concepts = struct
  module Number = Concepts_Tests.Number_Tests
  module RealNumber = Concepts_Tests.RealNumber_Tests
  module Integer = Concepts_Tests.Integer_Tests
end

include GeneralMin
