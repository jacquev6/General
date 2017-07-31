let identity x = x

let rev_apply x f = f x

let apply f x = f x

module O = struct
  let (|>) = rev_apply
  let (@@) = apply
end
