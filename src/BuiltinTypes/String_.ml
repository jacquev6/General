module SelfA = struct
  type t = string

  let equal x y =
    OCamlStandard.Pervasives.(=) x y

  let repr x =
    OCamlStandard.Printf.sprintf "%S" x
end

module SelfB = struct
  include Traits_.Equatable_.Different.Make0(SelfA)
  include SelfA
end

include SelfB

module O = struct
  include Traits_.Equatable_.Operators.Make0(SelfB)
end
