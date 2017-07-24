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
  module Numbers = struct
    module Number = struct
      include Concepts.Numbers.Number
      module Tests = Concepts_Tests.Numbers_Tests.Number_Tests
    end

    module RealNumber = struct
      include Concepts.Numbers.RealNumber
      module Tests = Concepts_Tests.Numbers_Tests.RealNumber_Tests
    end

    module Integer = struct
      include Concepts.Numbers.Integer
      module Tests = Concepts_Tests.Numbers_Tests.Integer_Tests
    end
  end
end

include GeneralMin
