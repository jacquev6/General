#include "../Generated/Atoms/Function4.ml"

module Self = struct
  type ('a, 'b, 'c, 'd, 'z) t = 'a -> 'b -> 'c -> 'd -> 'z

  let flip f =
    fun x y z u ->
      f u z y x

  let curry f =
    fun x y z u ->
      f (x, y, z, u)

  let uncurry f =
    fun (x, y, z, u) ->
      f x y z u
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
end)(struct
  open Testing

  let tests = [
    "flip" >: (lazy (check_string ~expected:"2 7 5 9" ((flip (Format.apply "%d %d %d %d")) 9 5 7 2)));
    "curry" >: (lazy (check_int ~expected:6 ((curry (fun (x, y, z, u) -> x - y * z + u)) 7 2 3 5)));
    "uncurry" >: (lazy (check_string ~expected:"7 2 4 5" ((uncurry (Format.apply "%d %d %d %d")) (7, 2, 4, 5))));
  ]
end)
*)
