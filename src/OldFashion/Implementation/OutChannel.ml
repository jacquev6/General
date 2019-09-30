type t = OCamlStandard.Pervasives.out_channel

let flush = OCamlStandard.Pervasives.flush

let print ?flush:(do_flush=false) channel format =
  OCamlStandard.Printf.kfprintf
    (fun channel -> if do_flush then flush channel)
    channel
    format

let output = OCamlStandard.Pervasives.output_bytes
