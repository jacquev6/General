module P = OCamlStandard.Pervasives
module Q = OCamlStandard.Printf

type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6

let ksprintf format ~f =
  Q.ksprintf f format

let sprintf format =
  Q.sprintf format

let printf format =
  Q.printf format

let of_string x =
  P.format_of_string x

let to_string x =
  P.string_of_format x

let concat x y =
  P.(^^) x y
