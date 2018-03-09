module OCSP = OCamlStandard.Pervasives
module OCSPr = OCamlStandard.Printf

type t = OCSP.out_channel

(* @todo Add optional ?flush parameter to flush the channel after the print *)
let print channel format =
  OCSPr.fprintf channel format

let output = OCSP.output_bytes

let flush = OCSP.flush
