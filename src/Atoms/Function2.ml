#include "../Generated/Atoms/Function2.ml"

module Self = struct
  type ('a, 'b, 'z) t = 'a -> 'b -> 'z

  let flip f =
    fun x y ->
      f y x

  let curry f =
    fun x y ->
      f (x, y)

  let uncurry f =
    fun (x, y) ->
      f x y
end

include Self

module Tests = Tests_.Make(Self)(struct
end)(struct
  open Testing

  let tests = [
    "flip" >: (lazy (check_int ~expected:128 ((flip Int.exponentiate) 7 2)));
    "curry" >: (lazy (check_int ~expected:5 ((curry (fun (x, y) -> x - y)) 7 2)));
    "uncurry" >: (lazy (check_int ~expected:5 ((uncurry (-)) (7, 2))));
  ]
end)
