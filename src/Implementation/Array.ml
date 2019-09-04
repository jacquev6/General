type 'a t = 'a array

module OCSA = OCamlStandard.Array


let empty = [||]

let singleton x = [|x|]

let repeat x ~size = OCSA.make size x

let of_list = OCSA.of_list

let to_list = OCSA.to_list

(* @todo Should we copy arrays here? *)
let of_array = Functions.Function1.identity

let to_array = Functions.Function1.identity

let get = OCSA.get

let set = OCSA.set

let size = OCSA.length
