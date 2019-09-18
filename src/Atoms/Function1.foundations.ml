type ('a, 'z) t = 'a -> 'z

let identity x =
  x

let apply f x =
  f x

let rev_apply x f =
  f x

let compose f g =
  fun x -> f (g x)

module O = struct
  let (@@) = apply
  let (|>) = rev_apply
  let (%) = compose
end
