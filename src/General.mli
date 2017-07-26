module Traits: module type of Traits

module Concepts: module type of Concepts

module Bool: module type of BuiltinTypes_.Bool_
module Exception: module type of BuiltinTypes_.Exception_
module Float: module type of BuiltinTypes_.Float_
module Int: module type of BuiltinTypes_.Int_
module Option: module type of BuiltinTypes_.Option_
module String: module type of BuiltinTypes_.String_

module Abbr: module type of General_.Abbr

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

  val (~:): ('a, unit, string, unit lazy_t -> Test.t) OCamlStandard.Pervasives.format4 -> 'a

  val (~::): ('a, unit, string, Test.t list -> Test.t) OCamlStandard.Pervasives.format4 -> 'a

  val fail: ('a, unit, string, 'b) OCamlStandard.Pervasives.format4 -> 'a

  val check: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a -> unit

  val check_string: expected:string -> string -> unit

  val check_bool: expected:bool -> bool -> unit

  val check_int: expected:int -> int -> unit

  val check_true: bool -> unit

  val check_false: bool -> unit
end
