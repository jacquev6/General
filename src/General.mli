module Traits: sig
  module Comparable: sig
    include module type of Traits.Comparable
    module Tests: module type of Traits_Tests.Comparable_Tests
  end

  module Equatable: sig
    include module type of Traits.Equatable
    module Tests: module type of Traits_Tests.Equatable_Tests
  end

  module Representable: sig
    include module type of Traits.Representable
    module Tests: module type of Traits_Tests.Representable_Tests
  end

  module Ringoid: sig
    include module type of Traits.Ringoid
    module Tests: module type of Traits_Tests.Ringoid_Tests
  end
end

module Concepts: sig
  module Numbers: sig
    module Number: sig
      include module type of Concepts.Numbers.Number
      module Tests: module type of Concepts_Tests.Numbers_Tests.Number_Tests
    end

    module RealNumber: sig
      include module type of Concepts.Numbers.RealNumber
      module Tests: module type of Concepts_Tests.Numbers_Tests.RealNumber_Tests
    end

    module Integer: sig
      include module type of Concepts.Numbers.Integer
      module Tests: module type of Concepts_Tests.Numbers_Tests.Integer_Tests
    end
  end
end

module Int: Concepts.Numbers.Integer.S0 with type t = int
module Float: Concepts.Numbers.RealNumber.S0 with type t = float

module Compare: module type of Compare with type t = Compare.t

module Testing: sig
  module Test: sig
    type t = Testing.Test.t
  end

  module Result: sig
    type t
    (* @todo Publish this type (so that clients can write reports) *)
  end

  val run: Test.t -> Result.t

  val report_to_console: Result.t -> unit

  val (>::): string -> Test.t list -> Test.t

  val (>:): string -> unit lazy_t -> Test.t

  val (~:): ('a, unit, string, unit lazy_t -> Test.t) Pervasives.format4 -> 'a

  val (~::): ('a, unit, string, Test.t list -> Test.t) Pervasives.format4 -> 'a

  val fail: ('a, unit, string, 'b) Pervasives.format4 -> 'a

  val check: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a -> unit

  val check_string: expected:string -> string -> unit

  val check_bool: expected:bool -> bool -> unit

  val check_int: expected:int -> int -> unit

  val check_true: bool -> unit

  val check_false: bool -> unit
end
