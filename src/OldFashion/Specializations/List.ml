module Int = struct
  include List.Specialize(Int)
  module Equa = List.SpecializeEquatable(Int)
  module Repr = List.SpecializeRepresentable(Int)

  include (Equa: module type of Equa with type t := t)
  include (Repr: module type of Repr with type t := t)
end

module Float = struct
  include List.Specialize(Float)
  module Equa = List.SpecializeEquatable(Float)

  include (Equa: module type of Equa with type t := t)
end

module String = struct
  include List.Specialize(String)
  module Equa = List.SpecializeEquatable(String)

  include (Equa: module type of Equa with type t := t)

  let join = List.join_string_list
end
