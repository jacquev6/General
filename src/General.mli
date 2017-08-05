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
(* @todo Concepts for iterables and collections. Something like Collection, Container, MonoBag, MultiBag, LinearContainer *)

(* Technical, utility modules *)

module CallStack: sig
  type t = Pervasives.OCamlStandard.Printexc.raw_backtrace

  include Traits.Displayable.S0 with type t := t
  include Traits.Representable.S0 with type t := t

  val current: ?max_size:int -> unit -> t

  module Location: sig
    type t = Pervasives.OCamlStandard.Printexc.location = {
      filename: string;
      line_number: int;
      start_char: int;
      end_char: int;
    }

    include Concepts.Able.S0 with type t := t
  end

  module Frame: sig
    type t = Pervasives.OCamlStandard.Printexc.backtrace_slot

    val is_raise: t -> bool
    (* @todo val is_inline: t -> bool *)

    val location: t -> Location.t option

    val format: int -> t -> string option
  end

  (* @todo? val size: t -> int *)
  (* @todo? val frame: t -> int -> Frame.t *)
  val frames: t -> Frame.t list
end

module Exception: sig
  type t = exn

  include Concepts.Identifiable.S0 with type t := t
  include Traits.Displayable.S0 with type t := t

  val register_printer: (t -> string option) -> unit

  val record_backtraces: bool -> unit
  val recording_backtraces: unit -> bool
  (* There is no way to get the call stack of a specific exception.
  It's just possible to get the call stack of the most recent exception. *)
  val most_recent_backtrace: unit -> CallStack.t option

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

  val name: exn -> string
end

module Exit: sig
  type t =
    | Success
    | Failure of int

  (* @todo Able *)

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

  (* @todo Able *)

  val ignore: 'a -> t
end

module Bool: sig
  type t = bool

  module O: sig
    include Concepts.Able.Operators.S0 with type t := t

    val not: t -> t
    val (&&): t -> t -> t (* Lazy *)
    val (||): t -> t -> t (* Lazy *)
    val xor: t -> t -> t
  end

  include Concepts.Able.S0 with type t := t and module O := O
  include Traits.Displayable.S0 with type t := t
  include Traits.Parsable.S0 with type t := t

  val not: t -> t
  val and_: t -> t -> t (* Not lazy *)
  val or_: t -> t -> t (* Not lazy *)
  val xor: t -> t -> t
end

module Char: sig
  type t = char

  (* @todo Integer, smallest, greatest *)

  val of_int: int -> t
  val to_int: t -> int
end

module Int: sig
  type t = int

  include Concepts.Integer.S0 with type t := t

  (* @todo Traits.Bounded? Concept.FixedWidthInteger? *)
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

module Int32: sig
  type t = int32

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end

module Int64: sig
  type t = int64

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end

module NativeInt: sig
  type t = nativeint

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end

module BigInt: sig
  type t = Pervasives.OCamlStandard.Big_int.big_int

  include Concepts.Integer.S0 with type t := t
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
    include Concepts.Able.Operators.S0 with type t := t
    val (^): t -> t -> t
  end

  include Traits.Displayable.S0 with type t := t
  include Concepts.Able.S0 with type t := t and module O := O

  val concat: t -> t -> t

  (* @todo val try_substring: t -> pos:int -> len:int -> t option *)
  val substring: t -> pos:int -> len:int -> t
  (* @todo val try_prefix: t -> len:int -> t option *)
  val prefix: t -> len:int -> t
  (* @todo val try_suffix: t -> len:int -> t option *)
  val suffix: t -> len:int -> t

  val has_prefix: t -> pre:t -> bool
  val try_drop_prefix: t -> pre:t -> t option
  val drop_prefix: t -> pre:t -> t
  val has_suffix: t -> suf:t -> bool
  val try_drop_suffix: t -> suf:t -> t option
  val drop_suffix: t -> suf:t -> t

  val split: t -> sep:t -> t list
end

(* @todo Rational, Complex, Quaternion, Matrix *)

(* Fixed-size containers *)

module Option: sig
  type 'a t = 'a option

  include Concepts.Able.S1 with type 'a t := 'a t

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

  module Specialize(A: sig type t end): sig
    type t = A.t option

    val some_if: bool -> A.t lazy_t -> t
    val some_if': bool -> A.t -> t

    val is_some: t -> bool
    val is_none: t -> bool

    val value_def: t -> def:A.t -> A.t
    val value: ?exc:exn -> t -> A.t

    val map: t -> f:(A.t -> 'a) -> 'a option
    val iter: t -> f:(A.t -> unit) -> unit
    val filter: t -> f:(A.t -> bool) -> t
    val filter_map: t -> f:(A.t -> 'a option) -> 'a option

    val value_map: t -> def:'a -> f:(A.t -> 'a) -> 'a
  end
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

  (* @todo Concept.Able *)

  val of_contents: 'a -> 'a t
  val contents: 'a t -> 'a
  val assign: 'a t -> 'a -> unit

  module O: sig
    val ref: 'a -> 'a t
    val (!): 'a t -> 'a
    val (:=): 'a t -> 'a -> unit
  end

  module SpecializeOperators(A: sig type t end): sig
    type nonrec t = A.t t

    val ref: A.t -> t
    val (!): t -> A.t
    val (:=): t -> A.t -> unit
  end

  module Specialize(A: sig type t end): sig
    type nonrec t = A.t t

    val of_contents: A.t -> t
    val contents: t -> A.t
    val assign: t -> A.t -> unit

    module O: module type of SpecializeOperators(A) with type t := t
  end

  (* @todo SpecializeComparable *)
  (* @todo SpecializeEquatable *)
  (* @todo SpecializeRepresentable *)
  (* @todo SpecializeAble (merge of three previous) *)

  module SpecializePredSucc(A: Traits.PredSucc.S0): sig
    type nonrec t = A.t t

    val increment: t -> unit
    val decrement: t -> unit
  end

  module SpecializeRingoidOperators(A: Traits.Ringoid.Basic.S0): sig
    type nonrec t = A.t t

    val (=+): t -> A.t -> unit
    val (=-): t -> A.t -> unit
    val (=*): t -> A.t -> unit
    val (=/): t -> A.t -> unit
  end

  module SpecializeRingoid(A: Traits.Ringoid.Basic.S0): sig
    type nonrec t = A.t t

    module O: module type of SpecializeRingoidOperators(A) with type t := t
  end
end

module Tuple2: sig
  type ('a, 'b) t = 'a * 'b

  include Concepts.Able.S2 with type ('a, 'b) t := ('a, 'b) t

  val make: 'a -> 'b -> ('a, 'b) t

  val get_0: ('a, _) t -> 'a
  val get_1: (_, 'b) t -> 'b

  val flip: ('a, 'b) t -> ('b, 'a) t
end

module Tuple3: sig
  type ('a, 'b, 'c) t = 'a * 'b * 'c

  include Concepts.Able.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t

  val make: 'a -> 'b -> 'c -> ('a, 'b, 'c) t

  val get_0: ('a, _, _) t -> 'a
  val get_1: (_, 'b, _) t -> 'b
  val get_2: (_, _, 'c) t -> 'c

  val flip: ('a, 'b, 'c) t -> ('c, 'b, 'a) t
end

module Tuple4: sig
  type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd

  include Concepts.Able.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t

  val make: 'a -> 'b -> 'c -> 'd -> ('a, 'b, 'c, 'd) t

  val get_0: ('a, _, _, _) t -> 'a
  val get_1: (_, 'b, _, _) t -> 'b
  val get_2: (_, _, 'c, _) t -> 'c
  val get_3: (_, _, _, 'd) t -> 'd

  val flip: ('a, 'b, 'c, 'd) t -> ('d, 'c, 'b, 'a) t
end

module Tuple5: sig
  type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e

  include Concepts.Able.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t

  val make: 'a -> 'b -> 'c -> 'd -> 'e -> ('a, 'b, 'c, 'd, 'e) t

  val get_0: ('a, _, _, _, _) t -> 'a
  val get_1: (_, 'b, _, _, _) t -> 'b
  val get_2: (_, _, 'c, _, _) t -> 'c
  val get_3: (_, _, _, 'd, _) t -> 'd
  val get_4: (_, _, _, _, 'e) t -> 'e

  val flip: ('a, 'b, 'c, 'd, 'e) t -> ('e, 'd, 'c, 'b, 'a) t
end

(* Specializations of fixed-size containers *)

module IntOption: sig
  include module type of Option.Specialize(Int)
end

module FloatOption: sig
  include module type of Option.Specialize(Float)
end

module StringOption: sig
  include module type of Option.Specialize(String)
end

(* @todo BoolOption, with tri-bool operations (None == "unknown") as functions and as operators *)

module IntReference: sig
  type t = int Reference.t

  module O: sig
    include module type of Reference.SpecializeOperators(Int) with type t := t
    include module type of Reference.SpecializeRingoidOperators(Int) with type t := t
  end

  include module type of Reference.Specialize(Int) with type t := t and module O := O
  include module type of Reference.SpecializePredSucc(Int) with type t := t
  include module type of Reference.SpecializeRingoid(Int) with type t := t and module O := O
end

module FloatReference: sig
  type t = float Reference.t

  module O: sig
    include module type of Reference.SpecializeOperators(Float) with type t := t
    include module type of Reference.SpecializeRingoidOperators(Float) with type t := t
  end

  include module type of Reference.Specialize(Float) with type t := t and module O := O
  include module type of Reference.SpecializeRingoid(Float) with type t := t and module O := O
end

module StringReference: sig
  type t = string Reference.t

  module O: sig
    include module type of Reference.SpecializeOperators(String) with type t := t
    val (=^): t -> string -> unit
  end

  include module type of Reference.Specialize(String) with type t := t and module O := O
end

(* @todo BoolReference with set and reset *)
(* @todo OptionReference with := s setting to Some x and reset setting to None *)

(* Collection containers *)

module List: sig
  type 'a t = 'a list

  (* @todo Traits *)

  val empty: 'a t
  val of_list: 'a list -> 'a t
  val to_list: 'a t -> 'a list
  val of_array: 'a array -> 'a t
  val to_array: 'a t -> 'a array

  val size: 'a t -> int
  val contains: 'a t -> 'a -> equal_a:('a -> 'a -> bool) -> bool

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

  module Specialize(A: sig type t end): sig
    type t = A.t list

    val empty: t
    val of_list: A.t list -> t
    val to_list: t -> A.t list
    val of_array: A.t array -> t
    val to_array: t -> A.t array

    val size: t -> int

    val cons: A.t -> t -> t
    val head: t -> A.t
    val tail: t -> t
    val try_head: t -> A.t option
    val try_tail: t -> t option

    val reverse: t -> t
    val append: t -> t -> t

    val map: t -> f:(A.t -> 'a) -> 'a list
    val iter: t -> f:(A.t -> unit) -> unit
    val fold: t -> init:'a -> f:('a -> A.t -> 'a) -> 'a
    val try_reduce: t -> f:(A.t -> A.t -> A.t) -> A.t option
    val reduce: t -> f:(A.t -> A.t -> A.t) -> A.t
    (* val scan: *)

    val concat_map: t -> f:(A.t -> 'a list) -> 'a list

    val filter: t -> f:(A.t -> bool) -> t
    val filter_map: t -> f:(A.t -> 'a option) -> 'a list

    val iter_i: t -> f:(int -> A.t -> unit) -> unit
    val fold_i: t -> init:'a -> f:(int -> 'a -> A.t -> 'a) -> 'a

    module O: sig
      val (@): t -> t -> t
    end
  end

  module SpecializeEquatable(A: Traits.Equatable.Basic.S0): sig
    type t = A.t list

    val contains: t -> A.t -> bool
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

module IntList: sig
  include module type of List.Specialize(Int)
end

module FloatList: sig
  include module type of List.Specialize(Float)
end

module StringList: sig
  include module type of List.Specialize(String)

  val concat: ?sep:string -> t -> string
end

(* @todo XxxList when Xxx is a Ringoid: add sum, product *)
(* @todo BoolList (with all, exists, etc.) *)
(* @todo OptionList (with values (or filter_some), roughly equivalent to filter_map ~f:identity) *)

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
  module BigInt: module type of BigInt
  module Bool: module type of Bool
  module CallStack: module type of CallStack
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
  module Int32: module type of Int32
  module Int64: module type of Int64
  module Int: module type of Int
  module Lazy: module type of Lazy
  module List: module type of List
  module NativeInt: module type of NativeInt
  module Option: module type of Option
  module Reference: module type of Reference
  module String: module type of String
  module Tuple2: module type of Tuple2
  module Tuple3: module type of Tuple3
  module Tuple4: module type of Tuple4
  module Tuple5: module type of Tuple5
  module Unit: module type of Unit

  module IntOption: module type of IntOption
  module FloatOption: module type of FloatOption
  module StringOption: module type of StringOption
  module IntReference: module type of IntReference
  module FloatReference: module type of FloatReference
  module StringReference: module type of StringReference
  module IntList: module type of IntList
  module FloatList: module type of FloatList
  module StringList: module type of StringList

  include module type of Pervasives
  with module Array := Array
  and module Char := Char
  and module Format := Format
  and module Int32 := Int32
  and module Int64 := Int64
  and module Lazy := Lazy
  and module List := List
  and module String := String
end

module Abbr: sig
  module Tst: module type of Testing

  module Ar: module type of Array
  module BigInt: module type of BigInt
  module Bo: module type of Bool
  module CallStack: module type of CallStack
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
  module Int32: module type of Int32
  module Int64: module type of Int64
  module Laz: module type of Lazy
  module Li: module type of List
  module NativeInt: module type of NativeInt
  module Opt: module type of Option
  module Ref: module type of Reference
  module Str: module type of String
  module Tu2: module type of Tuple2
  module Tu3: module type of Tuple3
  module Tu4: module type of Tuple4
  module Tu5: module type of Tuple5
  module Unit: module type of Unit

  module IntOpt: module type of IntOption
  module FlOpt: module type of FloatOption
  module StrOpt: module type of StringOption
  module IntRef: module type of IntReference
  module FlRef: module type of FloatReference
  module StrRef: module type of StringReference
  module IntLi: module type of IntList
  module FlLi: module type of FloatList
  module StrLi: module type of StringList

  include module type of Pervasives
  with module Int32 := Int32
  and module Int64 := Int64
end
