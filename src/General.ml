module Traits = struct
  module Comparable = struct
    include Traits.Comparable
    module Tests = Traits_Tests.Comparable_Tests
  end

  module Equatable = struct
    include Traits.Equatable
    module Tests = Traits_Tests.Equatable_Tests
  end

  module Representable = struct
    include Traits.Representable
    module Tests = Traits_Tests.Representable_Tests
  end

  module Ringoid = struct
    include Traits.Ringoid
    module Tests = Traits_Tests.Ringoid_Tests
  end
end

module Concepts = struct
  module Number = struct
    include Concepts.Number
    module Tests = Concepts_Tests.Number_Tests
  end

  module RealNumber = struct
    include Concepts.RealNumber
    module Tests = Concepts_Tests.RealNumber_Tests
  end

  module Integer = struct
    include Concepts.Integer
    module Tests = Concepts_Tests.Integer_Tests
  end
end

include GeneralMin
