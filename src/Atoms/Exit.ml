module Basic = struct
  type t =
    | Success
    | Failure of int

  let of_int = function
    | 0 -> Success
    | n -> Failure n

  let to_int = function
    | Success -> 0
    | Failure n -> n

  let exit status =
    OCamlStandard.Pervasives.exit (to_int status)

  let at_exit = OCamlStandard.Pervasives.at_exit
end

module Extended(Facets: Facets) = struct
  include Basic

  #ifdef TESTING_GENERAL
  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Exit.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
        let tests = []
    end)
  end
  #endif
end
