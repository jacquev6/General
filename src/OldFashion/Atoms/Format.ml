type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) OCamlStandard.Pervasives.format6

let with_result format ~f =
  OCamlStandard.Printf.ksprintf f format

let apply format =
  OCamlStandard.Printf.sprintf format

let of_string = OCamlStandard.Pervasives.format_of_string
let to_string = OCamlStandard.Pervasives.string_of_format
let concat = OCamlStandard.Pervasives.(^^)

let with_scan_result format ~f s =
  OCamlStandard.Scanf.sscanf s format f
