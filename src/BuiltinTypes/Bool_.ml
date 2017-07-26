include Traits_.Equatable_.Make0(struct
  type t = bool

  let equal x y =
    OCamlStandard.Pervasives.(=) x y
end)

let repr x =
  OCamlStandard.Pervasives.string_of_bool x
