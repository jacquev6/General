type t = OCamlStandard.Pervasives.out_channel

let seek x ~pos =
  OCamlStandard.Pervasives.LargeFile.seek_out x pos

let pos = OCamlStandard.Pervasives.LargeFile.pos_out

let size = OCamlStandard.Pervasives.LargeFile.out_channel_length

let channel = identity

let with_file s ~f =
  let file = OCamlStandard.Pervasives.open_out s in
  try
    let r = f file in
    OCamlStandard.Pervasives.close_out file;
    r
  with
    | ex -> OCamlStandard.Pervasives.close_out file; Exception.raise ex

let with_channel s ~f =
  with_file s ~f:(f % channel)
