include Foundations.ResetPervasives
include Foundations.ResetStandardLibrary

(* Whitelist of Pervasives *)

include Foundations.Bool.O
include Foundations.Float.O_dot
include Foundations.Function.O
include Foundations.Int.O
include Foundations.List_.O
include Foundations.String_.O

include Foundations.Equate.Poly.O
include Foundations.Compare.Poly.O

let ignore = Foundations.Unit.ignore
