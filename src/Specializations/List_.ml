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

  let concat = Foundations.List_.concat_string_list
end