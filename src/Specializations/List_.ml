open Implementation
module List_ = Implementation.List_

module Int = struct
  include List_.Specialize(Int)
  module Equa = List_.SpecializeEquatable(Int)

  include (Equa: module type of Equa with type t := t)
end

module Float = struct
  include List_.Specialize(Float)
  module Equa = List_.SpecializeEquatable(Float)

  include (Equa: module type of Equa with type t := t)
end

module String_ = struct
  include List_.Specialize(String_)
  module Equa = List_.SpecializeEquatable(String_)

  include (Equa: module type of Equa with type t := t)

  let join = Foundations.List_.join_string_list
end
