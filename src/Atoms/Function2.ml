module Basic = struct
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

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Function2.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
      open Testing

      let tests = [
        "Function2: flip" >: (lazy (check_string ~expected:"2 7." ((flip (Format.apply "%d %F")) 7. 2)));
        "Function2: uncurry" >: (lazy (check_string ~expected:"7 2." ((uncurry (Format.apply "%d %F")) (7, 2.))));
        "Function2: curry" >: (lazy (check_string ~expected:"7 2." ((curry (uncurry (Format.apply "%d %F"))) 7 2.)));
      ]
    end)
  end
end
