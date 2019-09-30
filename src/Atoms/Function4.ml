module Basic = struct
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

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Function4.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
      open Testing

      let tests = [
        "Function4: flip" >: (lazy (check_string ~expected:"2 7 5 9" ((flip (Format.apply "%d %d %d %d")) 9 5 7 2)));
        "Function4: uncurry" >: (lazy (check_string ~expected:"7 2 4 5" ((uncurry (Format.apply "%d %d %d %d")) (7, 2, 4, 5))));
        "Function4: curry" >: (lazy (check_string ~expected:"7 2 4 5" ((curry (uncurry (Format.apply "%d %d %d %d"))) 7 2 4 5)));
      ]
    end)
  end
end
