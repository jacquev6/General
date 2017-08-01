type t = string

let repr x =
  Format_.sprintf "%S" x

let to_string = Function.identity
let of_string = Function.identity

let get = OCamlStandard.String.get

let concat = OCSP.(^)

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let (^) = OCSP.(^)
end

include (Compare.Poly: module type of Compare.Poly with module O := O)
include (Equate.Poly: module type of Equate.Poly with module O := O)
