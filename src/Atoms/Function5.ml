module Basic = struct
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

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Function1.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
      open Testing

      let tests = [
        "Function5: flip" >: (lazy (check_string ~expected:"2 7 5 9 3" ((flip (Format.apply "%d %d %d %d %d")) 3 9 5 7 2)));
        "Function5: uncurry" >: (lazy (check_string ~expected:"7 2 4 5 3" ((uncurry (Format.apply "%d %d %d %d %d")) (7, 2, 4, 5, 3))));
        "Function5: curry" >: (lazy (check_string ~expected:"7 2 4 5 3" ((curry (uncurry (Format.apply "%d %d %d %d %d"))) 7 2 4 5 3)));
      ]
    end)
  end
end
