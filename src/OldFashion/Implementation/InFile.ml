type t = OCamlStandard.Pervasives.in_channel

let seek x ~pos =
  OCamlStandard.Pervasives.LargeFile.seek_in x pos

let pos = OCamlStandard.Pervasives.LargeFile.pos_in

let size = OCamlStandard.Pervasives.LargeFile.in_channel_length

let channel = identity

let with_file s ~f =
  let file = OCamlStandard.Pervasives.open_in s in
  try
    let r = f file in
    OCamlStandard.Pervasives.close_in file;
    r
  with
    | ex -> OCamlStandard.Pervasives.close_in file; Exception.raise ex

let with_channel s ~f =
  with_file s ~f:(f % channel)
