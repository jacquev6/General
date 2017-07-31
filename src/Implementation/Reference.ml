module OCSP = OCamlStandard.Pervasives

type 'a t = 'a OCSP.ref = {
  mutable contents: 'a;
}

let of_contents = OCSP.ref
let contents = OCSP.(!)
let assign = OCSP.(:=)

module O = struct
  let (!) = OCSP.(!)
  let (:=) = OCSP.(:=)
end
