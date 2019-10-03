module Poly = struct
  let equal = OCamlStandard.Pervasives.( = )
  let different = OCamlStandard.Pervasives.( <> )

  module O = struct
    let ( = ) = OCamlStandard.Pervasives.( = )
    let ( <> ) = OCamlStandard.Pervasives.( <> )
  end
end

module Phys = struct
  let equal = OCamlStandard.Pervasives.( == )
  let different = OCamlStandard.Pervasives.( != )
end
