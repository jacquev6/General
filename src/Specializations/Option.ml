open Implementation
module Option = Implementation.Option

module Int = struct
  include Option.Specialize(Int)
end

module Float = struct
  include Option.Specialize(Float)
end

module String_ = struct
  include Option.Specialize(String_)
end
