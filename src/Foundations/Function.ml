type ('a, 'b) t = 'a -> 'b

let identity x = x

let apply f x = f x

let rev_apply x f = f x

module O = struct
  let (@@) = apply
  let (|>) = rev_apply
end
