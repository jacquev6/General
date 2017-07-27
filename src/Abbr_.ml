open BuiltinTypes_
module Ar = Array_
module Bo = Bool_
module Bytes = Bytes_
module Exn = Exception_
module Fl = Float_
module Frmt = Format_
module Int = Int_
module Int32 = Int32_
module Int64 = Int64_
module Laz = Lazy_
module Li = List_
module NatInt = NativeInt_
module Opt = Option_
module Str = String_
module Unit = Unit_

open StdLibTypes_
module InCh = InChannel_
module OutCh = OutChannel_
module Ref = Reference_

open ExtensionTypes_
module Tu2 = Tuple2_

include (Ubiquitous: module type of Ubiquitous
  with module Bytes := Bytes
  and module Int32 := Int32
  and module Int64 := Int64
)

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
