type 'a t = 'a OCamlStandard.Pervasives.ref = {
  mutable contents: 'a;
}

let of_contents contents =
  {contents}

let contents {contents} =
  contents

let assign x y =
  x.contents <- y

module O = struct
  let (!) x =
    contents x

  let (:=) x y =
    assign x y
end
