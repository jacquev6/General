include Traits_.Equatable_.Make0(struct
  type t = string

  let equal x y =
    OCamlStandard.Pervasives.(=) x y
end)

let repr x =
  OCamlStandard.Printf.sprintf "%S" x
