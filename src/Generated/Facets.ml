module Representable = struct
  include Facets_alpha.Representable
  module Tests = Tests_beta(Testing)
end

module EquatableBasic = struct
  include Facets_alpha.EquatableBasic
  module Tests = Tests_beta(Testing)
end

module Equatable = struct
  include Facets_alpha.Equatable
  module Tests = Tests_beta(Testing)
end

module Displayable = struct
  include Facets_alpha.Displayable
  module Tests = Tests_beta(Testing)
end

module Parsable = struct
  include Facets_alpha.Parsable
  module Tests = Tests_beta(Testing)
end

module ComparableBasic = struct
  include Facets_alpha.ComparableBasic
  module Tests = Tests_beta(Testing)
end

module Comparable = struct
  include Facets_alpha.Comparable
  module Tests = Tests_beta(Testing)
end

module RingoidBasic = struct
  include Facets_alpha.RingoidBasic
  module Tests = Tests_beta(Testing)
end

module Ringoid = struct
  include Facets_alpha.Ringoid
  module Tests = Tests_beta(Testing)
end

module OfInt = struct
  include Facets_alpha.OfInt
  module Tests = Tests_beta(Testing)
end

module ToInt = struct
  include Facets_alpha.ToInt
  module Tests = Tests_beta(Testing)
end

module OfFloat = struct
  include Facets_alpha.OfFloat
  module Tests = Tests_beta(Testing)
end

module ToFloat = struct
  include Facets_alpha.ToFloat
  module Tests = Tests_beta(Testing)
end

module PredSucc = struct
  include Facets_alpha.PredSucc
  module Tests = Tests_beta(Testing)
end

module Bounded = struct
  include Facets_alpha.Bounded
  module Tests = Tests_beta(Testing)
end

module Bitwise = struct
  include Facets_alpha.Bitwise
  module Tests = Tests_beta(Testing)
end

module Identifiable = struct
  include Facets_alpha.Identifiable
  module Tests = Tests_beta(Testing)
end

module Able = struct
  include Facets_alpha.Able
  module Tests = Tests_beta(Testing)
end

module Stringable = struct
  include Facets_alpha.Stringable
  module Tests = Tests_beta(Testing)
end

module OfStandardNumber = struct
  include Facets_alpha.OfStandardNumber
  module Tests = Tests_beta(Testing)
end

module Number = struct
  include Facets_alpha.Number
  module Tests = Tests_beta(Testing)
end

module ToStandardNumber = struct
  include Facets_alpha.ToStandardNumber
  module Tests = Tests_beta(Testing)
end

module RealNumber = struct
  include Facets_alpha.RealNumber
  module Tests = Tests_beta(Testing)
end

module Integer = struct
  include Facets_alpha.Integer
  module Tests = Tests_beta(Testing)
end

module FixedWidthInteger = struct
  include Facets_alpha.FixedWidthInteger
  module Tests = Tests_beta(Testing)
end
