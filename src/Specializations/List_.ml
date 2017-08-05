open Implementation
module List_ = Implementation.List_

module Int = struct
  include List_.Specialize(Int)
end

module Float = struct
  include List_.Specialize(Float)
end

module String_ = struct
  include List_.Specialize(String_)

  let concat ?(sep="") xs =
    xs
    |> List_.try_reduce ~f:(fun a b -> a ^ sep ^ b)
    |> Option.value_def ~def:""
end
