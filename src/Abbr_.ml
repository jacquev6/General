include Ubiquitous

open BuiltinTypes_
module Bo = Bool_
module Exn = Exception_
module Fl = Float_
module Int = Int_
module Li = List_
module Opt = Option_
module Ref = Reference_
module Str = String_
module Tu2 = Tuple2_

(* @todo Find suitable homes for these values *)
(* @todo Implement operators as 'O' modules and open them here *)
let (@) = Li.append
let (^) = OCamlStandard.Pervasives.(^)
let (=) = OCamlStandard.Pervasives.(=)
let (<>) = OCamlStandard.Pervasives.(<>)
let (|>) = OCamlStandard.Pervasives.(|>)
let exit = OCamlStandard.Pervasives.exit
let ignore = OCamlStandard.Pervasives.ignore
let not = OCamlStandard.Pervasives.not
let (||) = OCamlStandard.Pervasives.(||)
