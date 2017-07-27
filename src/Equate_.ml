open OCamlStandard.Pervasives

module Poly = struct
  let equal x y =
    x = y

  let different x y =
    x <> y

  module O = struct
    let (=) x y =
      x = y

    let (<>) x y =
      x <> y
  end
end

module Physical = struct
  let equal x y =
    x == y

  let different x y =
    x != y
end
