module Basic = struct
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

module Extended(Facets: Facets) = struct
  include Basic

  #ifdef TESTING_GENERAL
  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Function3.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
      open Testing

      let tests = [
        "Function3: flip" >: (lazy (check_string ~expected:"2 7 5" ((flip (Format.apply "%d %d %d")) 5 7 2)));
        "Function3: uncurry" >: (lazy (check_string ~expected:"7 2 4" ((uncurry (Format.apply "%d %d %d")) (7, 2, 4))));
        "Function3: curry" >: (lazy (check_string ~expected:"7 2 4" ((curry (uncurry (Format.apply "%d %d %d"))) 7 2 4)));
      ]
    end)
  end
  #endif
end
