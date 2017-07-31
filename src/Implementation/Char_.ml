module OCSP = OCamlStandard.Pervasives

type t = char

let of_int = OCSP.char_of_int
let to_int = OCSP.int_of_char
