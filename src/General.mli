(* Basics *)

module Pervasives: sig
  include module type of Foundations.ResetPervasives
  include module type of Foundations.ResetStandardLibrary

  val not: bool -> bool
  val (&&): bool -> bool -> bool
  val (||): bool -> bool -> bool
  val xor: bool -> bool -> bool

  val (~-.): float -> float
  val (~+.): float -> float
  val (+.): float -> float -> float
  val (-.): float -> float -> float
  val ( *. ): float -> float -> float
  val (/.): float -> float -> float
  val ( ** ): float -> float -> float

  val (@@): ('a -> 'b) -> 'a -> 'b
  val (|>): 'a -> ('a -> 'b) -> 'b
  val (%): ('a -> 'b) -> ('c -> 'a) -> ('c -> 'b)

  val (~-): int -> int
  val (~+): int -> int
  val (+): int -> int -> int
  val (-): int -> int -> int
  val ( * ): int -> int -> int
  val (/): int -> int -> int
  val (mod): int -> int -> int

  val (@): 'a list -> 'a list -> 'a list

  val (^): string -> string -> string

  val ref: 'a -> 'a OCamlStandard.Pervasives.ref
  val (:=): 'a OCamlStandard.Pervasives.ref -> 'a -> unit
  val (!): 'a OCamlStandard.Pervasives.ref -> 'a

  val (=): 'a -> 'a -> bool
  val (<>): 'a -> 'a -> bool

  val (<): 'a -> 'a -> bool
  val (<=): 'a -> 'a -> bool
  val (>=): 'a -> 'a -> bool
  val (>): 'a -> 'a -> bool

  val ignore: 'a -> unit

  val identity: 'a -> 'a
end

module Compare: sig
  type t = LT | EQ | GT

  module Poly: sig include Traits.Comparable.SP end
end

module Equate: sig
  module Poly: sig include Traits.Equatable.SP end

  module Physical: Traits.Equatable.SP with module O := Poly.O (* SP without module O. Should we create a sig in the trait for that? *)
end

module Traits: module type of Traits
(* @todo Traits.Hashable with val hash: t -> int, Poly using Hashtbl.hash *)
(* @todo Traits for FilterMapable, ToStd (map_to_list, filter_to_array, filter_map_to_array_i) and ToSelf (map, filter_i, filter_map_i) *)
(* @todo Traits for Foldable, Left and Right, with short-circuit
Extensions include count[_i], iter[_i], for_all[_i], ther_exists[_i], [try_]find[_map][_i], [try_]reduce[_short][_right][_i] *)
(* @todo Traits for head and tail (Headable.Left?), and init and last (Headable.Right?) *)
(* @todo Traits for Scanable (Left and Right), ToStd and ToSelf, with short-circuit *)

(* Typology of iterations other collection:
- is there an accumulator (fold vs map)
- is it short circuit (exists/fold_short/find vs fold/map)
- does it produce a list (map) or a scalar (find/fold) or nothing (iter)
- from a list (map) or from a scalar (unfold/until_none/until_fixed)? (until_none i: [f i; f f i; f f f i; ... until f returns None]; until_fixed: until f f f i = f f i)
- other criteria?
and we need a generic function in each category. *)

module Concepts: module type of Concepts
(* @todo Concepts.Identifiable with traits Representable, Equatable, Hashable *)
(* @todo Concepts.Able with Identifiable plus trait Comparable *)
(* @todo Concepts for iterables and collections. Something like Collection, Container, MonoBag, MultiBag, LinearContainer *)

(* Technical, utility modules *)

module Exception: sig
  type t = exn

  include Traits.Equatable.S0 with type t := t

  (* Aliases for all predefined exceptions
  https://caml.inria.fr/pub/docs/manual-ocaml-4.05/core.html#sec527 *)
  exception MatchFailure of (string * int * int)
  exception AssertFailure of (string * int * int)
  exception InvalidArgument of string
  exception Failure of string
  exception NotFound
  exception OutOfMemory
  exception StackOverflow
  exception SysError of string
  exception EndOfFile
  exception DivisionByZero
  exception SysBlockedIO
  exception UndefinedRecursiveModule of (string * int * int)

  (* Aliases for all exceptions in Pervasives
  https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libref/Pervasives.html *)
  exception Exit

  val raise: t -> 'a

  val raise_without_backtrace: t -> 'a

  val invalid_argument: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val failure: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a
end

module Exit: sig
  type t =
    | Success
    | Failure of int

  val of_int: int -> t

  val exit: t -> unit

  val at_exit: (unit -> unit) -> unit
end

(* Functions *)

module Function1: sig
  type ('a, 'z) t = 'a -> 'z

  val identity: ('a, 'a) t

  val apply: ('a, 'z) t -> 'a -> 'z
  val rev_apply: 'a -> ('a, 'z) t -> 'z
  val compose: ('a, 'b) t -> ('c, 'a) t -> ('c, 'b) t

  module O: sig
    val (@@): ('a, 'z) t -> 'a -> 'z
    val (|>): 'a -> ('a, 'z) t -> 'z
    val (%): ('a, 'b) t -> ('c, 'a) t -> ('c, 'b) t
  end
end

module Function2: sig
  type ('a, 'b, 'z) t = 'a -> 'b -> 'z

  val flip: ('a, 'b, 'z) t -> ('b, 'a, 'z) t

  val curry: ('a * 'b, 'z) Function1.t -> ('a, 'b, 'z) t
  val uncurry: ('a, 'b, 'z) t -> ('a * 'b, 'z) Function1.t
end

module Function3: sig
  type ('a, 'b, 'c, 'z) t = 'a -> 'b -> 'c -> 'z

  val flip: ('a, 'b, 'c, 'z) t -> ('c, 'b, 'a, 'z) t

  val curry: ('a * 'b * 'c, 'z) Function1.t -> ('a, 'b, 'c, 'z) t
  val uncurry: ('a, 'b, 'c, 'z) t -> ('a * 'b * 'c, 'z) Function1.t
end

module Function4: sig
  type ('a, 'b, 'c, 'd, 'z) t = 'a -> 'b -> 'c -> 'd -> 'z

  val flip: ('a, 'b, 'c, 'd, 'z) t -> ('d, 'c, 'b, 'a, 'z) t

  val curry: ('a * 'b * 'c * 'd, 'z) Function1.t -> ('a, 'b, 'c, 'd, 'z) t
  val uncurry: ('a, 'b, 'c, 'd, 'z) t -> ('a * 'b * 'c * 'd, 'z) Function1.t
end

module Function5: sig
  type ('a, 'b, 'c, 'd, 'e, 'z) t = 'a -> 'b -> 'c -> 'd -> 'e -> 'z

  val flip: ('a, 'b, 'c, 'd, 'e, 'z) t -> ('e, 'd, 'c, 'b, 'a, 'z) t

  val curry: ('a * 'b * 'c * 'd * 'e, 'z) Function1.t -> ('a, 'b, 'c, 'd, 'e, 'z) t
  val uncurry: ('a, 'b, 'c, 'd, 'e, 'z) t -> ('a * 'b * 'c * 'd * 'e, 'z) Function1.t
end

(* @todo Predicate1,2,3,etc. (or BoolFunction1,2,3, more consistent with other specializations) with composition of predicates (not, and, or, xor) *)

(* Atomic values *)

module Unit: sig
  type t = unit

  val ignore: 'a -> t
end

module Bool: sig
  type t = bool

  module O: sig
    include Traits.Comparable.Operators.S0 with type t := t
    include Traits.Equatable.Operators.S0 with type t := t

    val not: t -> t
    val (&&): t -> t -> t (* Lazy *)
    val (||): t -> t -> t (* Lazy *)
    val xor: t -> t -> t
  end

  include Traits.Comparable.S0 with type t := t and module O := O
  include Traits.Displayable.S0 with type t := t
  include Traits.Equatable.S0 with type t := t and module O := O
  include Traits.Parsable.S0 with type t := t
  include Traits.Representable.S0 with type t := t

  val not: t -> t
  val and_: t -> t -> t (* Not lazy *)
  val or_: t -> t -> t (* Not lazy *)
  val xor: t -> t -> t
end

module Char: sig
  type t = char

  val of_int: int -> t
  val to_int: t -> int
end

module Int: sig
  type t = int

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t

  module Bitwise: sig
    val logical_and: t -> t -> t
    val logical_or: t -> t -> t
    val logical_xor: t -> t -> t
    val logical_not: t -> t
    val logical_shift_left: t -> shift:t -> t
    val logical_shift_right: t -> shift:t -> t
    val arithmetic_shift_right: t -> shift:t -> t
  end
end

module Float: sig
  type t = float

  include Concepts.RealNumber.S0 with type t := t

  val epsilon: t
  val smallest: t
  val greatest: t
  val infinity: t
  val negative_infinity: t
  val not_a_number: t
  val pi: float
  val e: float

  val of_parts: significand:float -> exponent:int -> t
  val to_parts: t -> float * int
  val to_fractional_and_integral: t -> float * float

  val sqrt: float -> float

  val exp: float -> float
  val log: float -> float
  val log10: float -> float
  val expm1: float -> float
  val log1p: float -> float

  val cos: float -> float
  val sin: float -> float
  val tan: float -> float
  val acos: float -> float
  val asin: float -> float
  val atan: float -> float
  val atan2: y:float -> x:float -> float
  val hypot: float -> float -> float
  val cosh: float -> float
  val sinh: float -> float
  val tanh: float -> float

  val ceil: float -> float
  val floor: float -> float
  val copy_sign: t -> sign:t -> t

  module Class: sig
    type t =
      | Normal
      | SubNormal
      | Zero
      | Infinite
      | NotANumber

    include Traits.Representable.S0 with type t := t

    val of_float: float -> t
  end
end

module String: sig
  type t = string

  val get: t -> int -> char

  module O: sig
    include Traits.Comparable.Operators.S0 with type t := t
    include Traits.Equatable.Operators.S0 with type t := t
    val (^): t -> t -> t
  end

  include Traits.Representable.S0 with type t := t
  include Traits.Displayable.S0 with type t := t
  include Traits.Comparable.S0 with type t := t and module O := O
  include Traits.Equatable.S0 with type t := t and module O := O

  val concat: t -> t -> t

  (* val try_substring: t -> pos:int -> len:int -> t option *)
  val substring: t -> pos:int -> len:int -> t
  (* val try_prefix: t -> len:int -> t option *)
  val prefix: t -> len:int -> t
  (* val try_suffix: t -> len:int -> t option *)
  val suffix: t -> len:int -> t

  val has_prefix: t -> pre:t -> bool
  val try_drop_prefix: t -> pre:t -> t option
  val drop_prefix: t -> pre:t -> t
  val has_suffix: t -> suf:t -> bool
  val try_drop_suffix: t -> suf:t -> t option
  val drop_suffix: t -> suf:t -> t

  val split: t -> sep:t -> t list
end

(* @todo Int32, Int64, NativeInt, BigInt, Rational, Complex, Quaternion, Matrix *)

(* Fixed-size containers *)

module Option: sig
  type 'a t = 'a option

  include Traits.Comparable.S1 with type 'a t := 'a t
  include Traits.Equatable.S1 with type 'a t := 'a t
  include Traits.Representable.S1 with type 'a t := 'a t

  (* @todo OptionPair.to_pair_option (Some a, Some b) -> Some (a, b) | _ -> None *)
  (* @todo OptionList.first_some *)
  (* @todo OptionList.filter_some *)

  (* @todo coalesce[_def] (with an (|||) operator?) *)

  val some_if: bool -> 'a lazy_t -> 'a t
  val some_if': bool -> 'a -> 'a t

  val is_some: 'a t -> bool
  val is_none: 'a t -> bool

  val value_def: 'a t -> def:'a -> 'a
  val value: ?exc:exn -> 'a t -> 'a

  val map: 'a t -> f:('a -> 'b) -> 'b t
  val iter: 'a t -> f:('a -> unit) -> unit
  val filter: 'a t -> f:('a -> bool) -> 'a t
  val filter_map: 'a t -> f:('a -> 'b option) -> 'b t

  val value_map: 'a t -> def:'b -> f:('a -> 'b) -> 'b
end

module Lazy: sig
  type 'a t = 'a lazy_t

  (* @todo LazyPair.to_pair_lazy *)
  (* @todo LazyList.to_list_lazy *)

  val is_value: 'a t -> bool

  val value: 'a t -> 'a

  val map: 'a t -> f:('a -> 'b) -> 'b t
end

module Reference: sig
  type 'a t = 'a Pervasives.OCamlStandard.Pervasives.ref = {mutable contents: 'a}

  val of_contents: 'a -> 'a t
  val contents: 'a t -> 'a
  val assign: 'a t -> 'a -> unit

  module O: sig
    val ref: 'a -> 'a t
    val (!): 'a t -> 'a
    val (:=): 'a t -> 'a -> unit
  end

  module Specialize(E: sig type t end): sig
    type nonrec t = E.t t

    val of_contents: E.t -> t
    val contents: t -> E.t
    val assign: t -> E.t -> unit

    module O: sig
      val ref: E.t -> t
      val (!): t -> E.t
      val (:=): t -> E.t -> unit
    end
  end

  module SpecializePredSucc(E: Traits.PredSucc.S0): sig
    val increment: E.t t -> unit
    val decrement: E.t t -> unit
  end
end

module Tuple2: sig
  type ('a, 'b) t = 'a * 'b

  val get_0: ('a, _) t -> 'a
  val get_1: (_, 'b) t -> 'b
end

(* @todo More TupleN *)
(* @todo Pair, Triplet, etc. (homogeneous tuples)? *)

(* Specializations of fixed-size containers *)

module IntReference: sig
  type t = int Reference.t

  val of_contents: int -> t
  val contents: t -> int
  val assign: t -> int -> unit

  val increment: t -> unit
  val decrement: t -> unit

  module O: sig
    val (!): t -> int
    val (:=): t -> int -> unit
  end
end

(* Collection containers *)

module List: sig
  type 'a t = 'a list

  val empty: 'a t
  val of_list: 'a list -> 'a t
  val to_list: 'a t -> 'a list
  val of_array: 'a array -> 'a t
  val to_array: 'a t -> 'a array

  val size: 'a t -> int

  val cons: 'a -> 'a t -> 'a t
  val head: 'a t -> 'a
  val tail: 'a t -> 'a t
  val try_head: 'a t -> 'a option
  val try_tail: 'a t -> 'a t option

  val reverse: 'a t -> 'a t
  val append: 'a t -> 'a t -> 'a t

  val map: 'a t -> f:('a -> 'b) -> 'b t
  val iter: 'a t -> f:('a -> unit) -> unit
  val fold: 'a t -> init:'b -> f:('b -> 'a -> 'b) -> 'b
  val try_reduce: 'a t -> f:('a -> 'a -> 'a) -> 'a option
  val reduce: 'a t -> f:('a -> 'a -> 'a) -> 'a
  (* val scan: *)

  val concat_map: 'a t -> f:('a -> 'b t) -> 'b t

  val filter: 'a t -> f:('a -> bool) -> 'a t
  val filter_map: 'a t -> f:('a -> 'b option) -> 'b t

  val iter_i: 'a t -> f:(int -> 'a -> unit) -> unit
  val fold_i: 'a t -> init:'b -> f:(int -> 'b -> 'a -> 'b) -> 'b

  module O: sig
    val (@): 'a t -> 'a t -> 'a t
  end

  module Poly: sig
    val contains: 'a t -> 'a -> bool
  end
end

module Array: sig
  type 'a t = 'a array

  (* @todo Implement *)

  val get: 'a t -> int -> 'a
end

(* @todo Range *)
(* @todo SortedList, UniqueList? *)
(* @todo Double-ended queue *)
(* @todo SortedSet, SortedMap, HashSet, HashMap *)
(* [Sorted|Hash]Index (a Map where the keys are computed from the values (think "vertex_by_name")) *)
(* @todo Stream *)

(* Specializations of collection containers *)

(* @todo XxxList where Xxx is a Ringoid, with sum, product *)
(* @todo OptionList (with values, roughly equivalent to filter_map is_some) *)

module StringList: sig
  type t = string list

  val concat: ?sep:string -> t -> string
end

(* Input/output *)

(* @todo StdIn, StdOut, InChannel, OutChannel *)

module Format: sig
  type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6

  (* From Pervasives:
  type ('a, 'b, 'c, 'd) format4 = ('a, 'b, 'c, 'c, 'c, 'd) format6
  type ('a, 'b, 'c) format = ('a, 'b, 'c, 'c, 'c, 'c) format6 *)

  val ksprintf: ('b, unit, string, string, string, 'a) t -> f:(string -> 'a) -> 'b

  val sprintf : ('a, unit, string, string, string, string) t -> 'a

  val printf : ('a, OCamlStandard.Pervasives.out_channel, unit, unit, unit, unit) t -> 'a

  val to_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> string

  val of_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('a, 'b, 'c, 'd, 'e, 'f) t

  val concat: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('f, 'b, 'c, 'e, 'g, 'h) t -> ('a, 'b, 'c, 'd, 'g, 'h) t
end

(* Testing *)

module Testing: sig
  module Result: sig
    (* @todo Publish this type (so that clients can write reports) *)
    type t
  end

  module Test: sig
    type t = Testing.Test.t

    val run: ?record_backtrace:bool -> t -> Result.t
  end

  val command_line_main: argv:string list -> Test.t -> Exit.t

  val (>::): string -> Test.t list -> Test.t

  val (>:): string -> unit lazy_t -> Test.t

  val (~:): ('a, unit, string, string, string, unit lazy_t -> Test.t) CamlinternalFormatBasics.format6 -> 'a

  val (~::): ('a, unit, string, string, string, Test.t list -> Test.t) CamlinternalFormatBasics.format6 -> 'a

  val fail: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val expect_exception: expected:exn -> 'a lazy_t -> unit

  val check: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a -> unit

  val check_poly: repr:('a -> string) -> expected:'a -> 'a -> unit

  val check_string: expected:string -> string -> unit

  val check_bool: expected:bool -> bool -> unit

  val check_true: bool -> unit

  val check_false: bool -> unit

  val check_int: expected:int -> int -> unit

  val check_float_exact: expected:float -> float -> unit

  val check_option: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a option -> 'a option -> unit

  val check_some: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a option -> unit

  val check_none: repr:('a -> string) -> equal:('a -> 'a -> bool) -> 'a option -> unit

  val check_int_option: expected:int option -> int option -> unit

  val check_some_int: expected:int -> int option -> unit

  val check_none_int: int option -> unit

  val check_list: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a list -> 'a list -> unit

  val check_string_list: expected:string list -> string list -> unit

  val check_int_list: expected:int list -> int list -> unit
end

(* Modules to be opened *)

module Standard: sig
  module Testing: module type of Testing

  module Array: module type of Array
  module Bool: module type of Bool
  module Char: module type of Char
  module Exception: module type of Exception
  module Exit: module type of Exit
  module Float: module type of Float
  module Format: module type of Format
  module Function1: module type of Function1
  module Function2: module type of Function2
  module Function3: module type of Function3
  module Function4: module type of Function4
  module Function5: module type of Function5
  module Int: module type of Int
  module Lazy: module type of Lazy
  module List: module type of List
  module Option: module type of Option
  module Reference: module type of Reference
  module String: module type of String
  module Tuple2: module type of Tuple2
  module Unit: module type of Unit

  module IntReference: module type of IntReference
  module StringList: module type of StringList

  include module type of Pervasives
  with module Array := Array
  and module Char := Char
  and module Format := Format
  and module Lazy := Lazy
  and module List := List
  and module String := String
end

module Abbr: sig
  module Tst: module type of Testing

  module Ar: module type of Array
  module Bo: module type of Bool
  module Ch: module type of Char
  module Exit: module type of Exit
  module Exn: module type of Exception
  module Fl: module type of Float
  module Frmt: module type of Format
  module Fun1: module type of Function1
  module Fun2: module type of Function2
  module Fun3: module type of Function3
  module Fun4: module type of Function4
  module Fun5: module type of Function5
  module Int: module type of Int
  module Laz: module type of Lazy
  module Li: module type of List
  module Opt: module type of Option
  module Ref: module type of Reference
  module Str: module type of String
  module Tu2: module type of Tuple2
  module Unit: module type of Unit

  module IntRef: module type of IntReference
  module StrLi: module type of StringList

  include module type of Pervasives
end
