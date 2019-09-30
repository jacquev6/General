module Basic = struct
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
    let ( @@ ) = apply
    let ( |> ) = rev_apply
    let ( % ) = compose
  end
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
        "Function1: identity" >: (lazy (check_string ~expected:"42" (identity "42")));
        "Function1: apply" >: (lazy (check_string ~expected:"x42x" (apply (Format.apply "x%dx") 42)));
        "Function1: rev_apply" >: (lazy (check_string ~expected:"y42y" (rev_apply 42 (Format.apply "y%dy"))));
        "Function1: compose" >: (lazy (check_string ~expected:"xy42yx" ((compose (Format.apply "x%sx") (Format.apply "y%dy")) 42)));
      ]
    end)
  end
end
