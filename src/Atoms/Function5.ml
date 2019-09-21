#include "../Generated/Atoms/Function5.ml"

module Self = struct
  type ('a, 'b, 'c, 'd, 'e, 'z) t = 'a -> 'b -> 'c -> 'd -> 'e -> 'z

  let flip f =
    fun x y z u v ->
      f v u z y x

  let curry f =
    fun x y z u v ->
      f (x, y, z, u, v)

  let uncurry f =
    fun (x, y, z, u, v) ->
      f x y z u v
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
end)(struct
  open Testing

  let tests = [
    "flip" >: (lazy (check_string ~expected:"2 7 5 9 3" ((flip (Format.apply "%d %d %d %d %d")) 3 9 5 7 2)));
    "curry" >: (lazy (check_int ~expected:4 ((curry (fun (x, y, z, u, v) -> x - y * z + u -v)) 7 2 3 5 2)));
    "uncurry" >: (lazy (check_string ~expected:"7 2 4 5 3" ((uncurry (Format.apply "%d %d %d %d %d")) (7, 2, 4, 5, 3))));
  ]
end)
*)
