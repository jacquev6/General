type 'a t = 'a lazy_t

module OCSL = OCamlStandard.Lazy

let value = OCSL.force
