#include "../Generated/Atoms/Function3.ml"

module Self = struct
  type ('a, 'b, 'c, 'z) t = 'a -> 'b -> 'c -> 'z

  let flip f =
    fun x y z ->
      f z y x

  let curry f =
    fun x y z ->
      f (x, y, z)

  let uncurry f =
    fun (x, y, z) ->
      f x y z
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
end)(struct
  open Testing

  let tests = [
    "flip" >: (lazy (check_string ~expected:"2 7 5" ((flip (Format.apply "%d %d %d")) 5 7 2)));
    "curry" >: (lazy (check_int ~expected:1 ((curry (fun (x, y, z) -> x - y * z)) 7 2 3)));
    "uncurry" >: (lazy (check_string ~expected:"7 2 4" ((uncurry (Format.apply "%d %d %d")) (7, 2, 4))));
  ]
end)
*)
