include BuiltinTypes_

module Abbr = struct
  include Ubiquitous

  open BuiltinTypes_
  module Int = Int_
  module Fl = Float_
  module Li = List_
  module Tu2 = Tuple2_

  module Cmp = Compare
  module Tst = Testing

  let (@) = Li.append

  (* @todo Function.apply' *)
  let (|>) v f =
    f v

  (* @todo Function.apply *)
  let (@@) f v =
    f v
end

module Compare = Compare

module Testing = Testing
