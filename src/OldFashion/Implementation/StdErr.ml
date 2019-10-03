include StandardOutChannel.Make(struct
  let channel = OCamlStandard.Pervasives.stderr
  let flush = true
end)
