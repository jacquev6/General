module Tree = RedBlackTree

module Poly = struct
  let cmp = Compare.Poly.compare
  let cmp_k = cmp

  type 'a t = 'a Tree.t

  let empty = Tree.empty

  let add t ~v =
    Tree.add t ~cmp v

  let replace t ~v =
    Tree.replace t ~cmp v

  let remove t ~v =
    Tree.remove t ~cmp ~cmp_k v

  let contains t ~v =
    Tree.try_get t ~cmp ~cmp_k v
    |> Option.is_some
end

module Make(E: Traits.Comparable.Basic.S0) = struct
  let cmp = E.compare
  let cmp_k = cmp

  (* @toto Forbid using Poly.equal and Poly.compare *)
  type t = E.t Tree.t

  let empty = Tree.empty

  let add t ~v =
    Tree.add t ~cmp v

  let replace t ~v =
    Tree.replace t ~cmp v

  let remove t ~v =
    Tree.remove t ~cmp ~cmp_k v

  let contains t ~v =
    Tree.try_get t ~cmp ~cmp_k v
    |> Option.is_some
end
