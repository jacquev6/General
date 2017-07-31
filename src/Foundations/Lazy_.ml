type 'a t = 'a lazy_t

module OCSL = OCamlStandard.Lazy

let force = OCSL.force
