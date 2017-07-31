module Poly = struct
  let equal = OCSP.(=)
  let different = OCSP.(<>)

  module O = struct
    let (=) = OCSP.(=)
    let (<>) = OCSP.(<>)
  end
end

module Physical = struct
  let equal = OCSP.(==)
  let different = OCSP.(!=)
end
