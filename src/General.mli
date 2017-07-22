module Traits: module type of Traits

module Concepts: module type of Concepts

include module type of BuiltinTypes

module Compare: module type of Compare with type t = Compare.t

module Testing: sig
  module Test: sig
    type t = Testing.Test.t
  end

  module type Testable = sig
    val test: Test.t
  end

  module Result: sig
    type t
  end

  val run: Test.t -> Result.t

  val report_to_console: Result.t -> unit

  val (>:::): string -> Test.t list -> Test.t

  val (>::): string -> (unit -> unit) -> Test.t

  val fail: string -> unit

  val check: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a -> unit

  val check_string: expected:string -> string -> unit

  val check_bool: expected:bool -> bool -> unit

  val check_int: expected:int -> int -> unit

  val check_true: bool -> unit

  val check_false: bool -> unit
end

include Testing.Testable
