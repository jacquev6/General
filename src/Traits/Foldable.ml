(* fold[_short][_right][_i|_acc] *)
(* [try_|]reduce[_short][_right][_i|_acc] *)

module Basic = struct
  #include "../../src/Traits/Foldable.signatures.Basic.ml"
end

#include "../../src/Traits/Foldable.signatures.ml"

module Right = struct
  module Basic = struct
    #include "../../src/Traits/Foldable.signatures.Right.Basic.ml"
  end

  #include "../../src/Traits/Foldable.signatures.Right.ml"
end

module Short = struct
  module Basic = struct
    #include "../../src/Traits/Foldable.signatures.Short.Basic.ml"
  end

  #include "../../src/Traits/Foldable.signatures.Short.ml"

  module Right = struct
    module Basic = struct
      #include "../../src/Traits/Foldable.signatures.Short.Right.Basic.ml"
    end

    #include "../../src/Traits/Foldable.signatures.Short.Right.ml"
  end
end
