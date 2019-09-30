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
    OCSP.exit (to_int status)

    let at_exit = OCSP.at_exit
end

module Extended(Facets: Facets) = struct
  include Basic

  module MakeTests(Testing: Testing) = struct
    #include "../Generated/Atoms/Exit.ml"

    include Tests_.Make(Basic)(struct
    end)(struct
        let tests = []
    end)
  end
end
