type t = bool

let of_string = OCSP.bool_of_string
let to_string = OCSP.string_of_bool

let repr = OCSP.string_of_bool

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let not = OCSP.not
  let (&&) = OCSP.(&&)
  let (||) = OCSP.(||)
end

include (Compare.Poly: module type of Compare.Poly with module O:= O)
include (Equate.Poly: module type of Equate.Poly with module O:= O)
