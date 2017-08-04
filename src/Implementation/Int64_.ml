module OCSI = OCamlStandard.Int64

module Self = struct
  type t = int64

  let of_float = OCSI.of_float
end

include Self
