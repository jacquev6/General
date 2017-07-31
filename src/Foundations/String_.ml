type t = string

let repr x =
  Format_.sprintf "%S" x

module O = struct
  include Equate.Poly.O

  let (^) = OCSP.(^)
end

include (Equate.Poly: module type of Equate.Poly with module O := O)
