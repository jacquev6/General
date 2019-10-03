type 'a t = 'a array

let empty = [||]

let singleton x = [|x|]

let repeat x ~size = OCamlStandard.Array.make size x

let of_list = OCamlStandard.Array.of_list

let to_list = OCamlStandard.Array.to_list

(* @todo Should we copy arrays here? *)
let of_array = Function1.identity

let to_array = Function1.identity

let get = OCamlStandard.Array.get

let set = OCamlStandard.Array.set

let size = OCamlStandard.Array.length
