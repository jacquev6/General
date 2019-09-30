include StandardOutChannel.Make(struct
  let channel = OCamlStandard.Pervasives.stdout
  let flush = false
end)
