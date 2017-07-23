(* Without this operator defined and opened, with bisect_ppx, we get the following error:
File "_none_", line 1:
Error: Unbound value <
*)

let (<) = Pervasives.(<)
