(** Some doc for :mod:`General` *)

#include "Reset/CommonHeader.ml"
#include "Reset/SignatureHeader.ml"

(** Some doc for :mod:`General.Ubiquitous` *)

module Ubiquitous: sig
  #include "Reset/ResetPervasives.ml"
  #include "Reset/ResetStandardLibrary.ml"
  #include "Reset/PervasivesWhitelist.mli"
end

#include "Reset/Footer.ml"

module OCamlStandard = Ubiquitous.OCamlStandard

module Shorten: sig
  (** Return type for functions used in short-circuit iterations over collections.
  (i.e: :val:`General.Facets.Foldable.Short.S0:fold_short`) *)
  type t =
    | GoOn (** Used to indicate iteration should proceed to next item *)
    | ShortCircuit (** Used to indicate iteration should stop after this item *)
end

module Compare: sig
  type t = LT | EQ | GT

  module Poly: sig
    val compare: 'a -> 'a -> t

    val less_than: 'a -> 'a -> bool
    val less_or_equal: 'a -> 'a -> bool
    val greater_than: 'a -> 'a -> bool
    val greater_or_equal: 'a -> 'a -> bool

    val between: 'a -> low:'a -> high:'a -> bool
    val between_or_equal: 'a -> low:'a -> high:'a -> bool

    val min: 'a -> 'a -> 'a
    val max: 'a -> 'a -> 'a
    val min_max: 'a -> 'a -> 'a * 'a

    module O: sig
      val (<): 'a -> 'a -> bool
      val (<=): 'a -> 'a -> bool
      val (>): 'a -> 'a -> bool
      val (>=): 'a -> 'a -> bool
    end
  end

  (* @feature: functors to revert comparison (i.e. "descending order") *)
end

module Equate: sig
  module Poly: sig
    (** Polymorphic structural equality *)
    val equal: 'a -> 'a -> bool

    (** Polymorphic inequality *)
    val different: 'a -> 'a -> bool

    module O: sig
      val (=): 'a -> 'a -> bool
      val (<>): 'a -> 'a -> bool
    end
  end

  module Phys: sig
    (** Physical identity (address equality) *)
    val equal: 'a -> 'a -> bool

    (** Physical inequality *)
    val different: 'a -> 'a -> bool
  end
end

(* Testing base *)
module Test: sig
  type t
end

module Facets: sig
  #include "Generated/Facets.mli"

  (* @feature Facets for head and tail (Headable.Left?), and init and last (Headable.Right?) *)

  (* Typology of iterations other collection:
  - is there an accumulator (fold vs map)
  - is it short circuit (exists/fold_short/find vs fold/map)
  - does it produce a list (map) or a scalar (find/fold) or nothing (iter)
  - from a list (map) or from a scalar (unfold/until_none/until_fixed)? (until_none i: [f i; f f i; f f f i; ... until f returns None]; until_fixed: until f f f i = f f i)
  - other criteria?
  and we need a generic function in each category. *)

  (* @todo Generate these facets *)
  module FilterMapable: sig
    #include "OldFashion/Facets/FilterMapable.signatures.ml"

    module ToContainer(C: sig type 'a t end): sig
      #include "OldFashion/Facets/FilterMapable.signatures.ToContainer.ml"
    end

    module ToList: module type of ToContainer(struct type 'a t = 'a list end)

    module ToArray: module type of ToContainer(struct type 'a t = 'a array end)
  end

  module Foldable: sig
    module Basic: sig
      #include "OldFashion/Facets/Foldable.signatures.Basic.ml"
    end

    #include "OldFashion/Facets/Foldable.signatures.ml"

    module Right: sig
      module Basic: sig
        #include "OldFashion/Facets/Foldable.signatures.Right.Basic.ml"
      end

      #include "OldFashion/Facets/Foldable.signatures.Right.ml"
    end

    module Short: sig
      module Basic: sig
        #include "OldFashion/Facets/Foldable.signatures.Short.Basic.ml"
      end

      #include "OldFashion/Facets/Foldable.signatures.Short.ml"

      module Right: sig
        module Basic: sig
          #include "OldFashion/Facets/Foldable.signatures.Short.Right.Basic.ml"
        end

        #include "OldFashion/Facets/Foldable.signatures.Short.Right.ml"
      end
    end
  end

  module Scanable: sig
    #include "OldFashion/Facets/Scanable.signatures.ml"

    module ToContainer(C: sig type 'a t end): sig
      #include "OldFashion/Facets/Scanable.signatures.ToContainer.ml"
    end

    module ToList: module type of ToContainer(struct type 'a t = 'a list end)

    module ToArray: module type of ToContainer(struct type 'a t = 'a array end)

    module Right: sig
      #include "OldFashion/Facets/Scanable.signatures.Right.ml"

      module ToContainer(C: sig type 'a t end): sig
        #include "OldFashion/Facets/Scanable.signatures.Right.ToContainer.ml"
      end

      module ToList: module type of ToContainer(struct type 'a t = 'a list end)

      module ToArray: module type of ToContainer(struct type 'a t = 'a array end)
    end

    module Short: sig
      #include "OldFashion/Facets/Scanable.signatures.Short.ml"

      module ToContainer(C: sig type 'a t end): sig
        #include "OldFashion/Facets/Scanable.signatures.Short.ToContainer.ml"
      end

      module ToList: module type of ToContainer(struct type 'a t = 'a list end)

      module ToArray: module type of ToContainer(struct type 'a t = 'a array end)

      module Right: sig
        #include "OldFashion/Facets/Scanable.signatures.Short.Right.ml"

        module ToContainer(C: sig type 'a t end): sig
          #include "OldFashion/Facets/Scanable.signatures.Short.Right.ToContainer.ml"
        end

        module ToList: module type of ToContainer(struct type 'a t = 'a list end)

        module ToArray: module type of ToContainer(struct type 'a t = 'a array end)
      end
    end
  end
end

#include "Generated/Atoms.mli"

(* @feature Rational, Complex, Quaternion, Matrix *)

(* Fixed-size containers *)

#include "Generated/Wrappers.mli"

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

(* @feature BoolOption, with tri-bool operations (None == "unknown") as functions and as operators *)

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

(* @feature BoolReference with set and reset *)
(* @feature OptionReference with := x setting to Some x and reset setting to None *)
(* @feature OptionPair.to_pair_option (Some a, Some b) -> Some (a, b) | _ -> None *)
(* @feature LazyPair.to_pair_lazy *)

(* Collection containers *)

module List: sig
  type 'a t = 'a list

  module O: sig
    val (@): 'a t -> 'a t -> 'a t
  end

  val empty: 'a t
  val singleton: 'a -> 'a t
  val of_list: 'a list -> 'a t
  val to_list: 'a t -> 'a list
  val of_array: 'a array -> 'a t
  val to_array: 'a t -> 'a array

  val size: 'a t -> int
  val is_empty: 'a t -> bool
  val head: 'a t -> 'a
  val tail: 'a t -> 'a t
  val try_head: 'a t -> 'a option
  val try_tail: 'a t -> 'a t option

  val contains: 'a t -> 'a -> equal_a:('a -> 'a -> bool) -> bool

  module Poly: sig
    val contains: 'a t -> 'a -> bool
  end

  val prepend: 'a -> 'a t -> 'a t
  val reverse: 'a t -> 'a t
  val concat: 'a t -> 'a t -> 'a t

  include Facets.Representable.S1 with type 'a t := 'a t
  include Facets.Equatable.S1 with type 'a t := 'a t
  include Facets.FilterMapable.S1 with type 'a t := 'a t
  include Facets.Foldable.S1 with type 'a t := 'a t
  include Facets.Foldable.Short.S1 with type 'a t := 'a t
  (* include Facets.Foldable.Right.S1 with type 'a t := 'a t *)
  (* include Facets.Foldable.Short.Right.S1 with type 'a t := 'a t *)
  include Facets.Scanable.S1 with type 'a t := 'a t
  include Facets.Scanable.Short.S1 with type 'a t := 'a t
  (* include Facets.Scanable.Right.S1 with type 'a t := 'a t *)
  (* include Facets.Scanable.Short.Right.S1 with type 'a t := 'a t *)

  module Two: sig
    val to_pair_list: 'a t -> 'b t -> ('a * 'b) t
    val to_pair_list_short: 'a t -> 'b t -> ('a * 'b) t
  end

  module Specialize(A: sig type t end): sig
    type t = A.t list

    module O: sig
      val (@): t -> t -> t
    end

    val empty: t
    val singleton: A.t -> t
    val of_list: A.t list -> t
    val to_list: t -> A.t list
    val of_array: A.t array -> t
    val to_array: t -> A.t array

    val size: t -> int
    val is_empty: t -> bool
    val head: t -> A.t
    val tail: t -> t
    val try_head: t -> A.t option
    val try_tail: t -> t option

    val prepend: A.t -> t -> t
    val reverse: t -> t
    val concat: t -> t -> t

    include Facets.FilterMapable.S0 with type elt := A.t and type t := t
    include Facets.Foldable.S0 with type elt := A.t and type t := t
    include Facets.Foldable.Short.S0 with type elt := A.t and type t := t
    (* include Facets.Foldable.Right.S0 with type elt := A.t and type t := t *)
    (* include Facets.Foldable.Short.Right.S0 with type elt := A.t and type t := t *)
    include Facets.Scanable.S0 with type elt := A.t and type t := t
    include Facets.Scanable.Short.S0 with type elt := A.t and type t := t
    (* include Facets.Scanable.Right.S0 with type elt := A.t and type t := t *)
    (* include Facets.Scanable.Short.Right.S0 with type elt := A.t and type t := t *)

    module ToList: sig
      include Facets.FilterMapable.ToList.S0 with type elt := A.t and type t := t
      include Facets.Scanable.ToList.S0 with type elt := A.t and type t := t
      include Facets.Scanable.Short.ToList.S0 with type elt := A.t and type t := t
      (* include Facets.Scanable.Right.ToList.S0 with type elt := A.t and type t := t *)
      (* include Facets.Scanable.Short.Right.ToList.S0 with type elt := A.t and type t := t *)
    end
  end

  module SpecializeEquatable(A: Facets.Equatable.Basic.S0): sig
    type t = A.t list

    val contains: t -> A.t -> bool
  end

  module SpecializeRepresentable(A: Facets.Representable.S0): Facets.Representable.S0 with type t = A.t list
end

module Array: sig
  type 'a t = 'a array

  (* @todo Implement *)

  val empty: 'a t
  val singleton: 'a -> 'a t
  val repeat: 'a -> size:int -> 'a t
  val of_list: 'a list -> 'a t
  val to_list: 'a t -> 'a list
  val of_array: 'a array -> 'a t
  val to_array: 'a t -> 'a array

  val size: 'a t -> int
  val get: 'a t -> int -> 'a
  val set: 'a t -> int -> 'a -> unit
end

module Stream: sig
  type 'a t = 'a OCamlStandard.Stream.t

  val empty: 'a t
  val singleton: 'a -> 'a t

  val to_list: 'a t -> 'a list
  val of_list: 'a list -> 'a t

  val prepend: 'a -> 'a t -> 'a t
  val concat: 'a t -> 'a t -> 'a t

  include Facets.FilterMapable.S1 with type 'a t := 'a t
  (* @feature Other iteration facets: Foldable and Scanable *)

  module ToList: sig
    include Facets.FilterMapable.ToList.S1 with type 'a t := 'a t
  end

  (* @feature module Specialize (with ToList and ToStream) *)
end

module SortedSet: sig
  module Poly: sig
    type 'a t

    val empty: 'a t

    val of_list: 'a list -> 'a t
    val to_list: 'a t -> 'a list

    val is_empty: 'a t -> bool
    val size: 'a t -> int

    val add: 'a t -> v:'a -> bool * 'a t
    val replace: 'a t -> v:'a -> 'a t
    val remove: 'a t -> v:'a -> bool * 'a t

    val contains: 'a t -> v:'a -> bool

    (* @feature Facets *)
  end

  module Make(E: Facets.Comparable.Basic.S0): sig
    type t

    val empty: t

    val of_list: E.t list -> t
    val to_list: t -> E.t list

    val is_empty: t -> bool
    val size: t -> int

    val add: t -> v:E.t -> bool * t
    val replace: t -> v:E.t -> t
    val remove: t -> v:E.t -> bool * t

    val contains: t -> v:E.t -> bool

    (* @feature Facets *)
  end
end

module SortedMap: sig
  module Poly: sig
    type ('a, 'b) t

    val empty: ('a, 'b) t
    val singleton: k:'a -> v:'b -> ('a, 'b) t

    (* val of_list_unique: ('a * 'b) list -> ('a, 'b) t *)
    (* val try_of_list_unique: ('a * 'b) list -> ('a, 'b) t option *)
    val of_list_first: ('a * 'b) list -> ('a, 'b) t
    val of_list_last: ('a * 'b) list -> ('a, 'b) t
    val of_list_reduce: ('a * 'b) list -> f:('a -> 'b -> 'b -> 'b) -> ('a, 'b) t
    val to_list: ('a, 'b) t -> ('a * 'b) list

    val is_empty: ('a, 'b) t -> bool
    val size: ('a, 'b) t -> int

    val add: ('a, 'b) t -> k:'a -> v:'b -> bool * ('a, 'b) t
    val replace: ('a, 'b) t -> k:'a -> v:'b -> ('a, 'b) t
    val remove: ('a, 'b) t -> k:'a -> bool * ('a, 'b) t

    val try_get: ('a, 'b) t -> k:'a -> 'b option
    val get: ('a, 'b) t -> k:'a -> 'b

    (* @feature [try_](smallest|largest): ('a, 'b) t -> ('a, 'b) [option] returning (k, v) with smallest (largest) k *)

    (* @feature Facets *)
  end

  module Make(K: Facets.Comparable.Basic.S0): sig
    type 'a t

    val empty: 'a t
    val singleton: k:K.t -> v:'a -> 'a t

    (* @feature [try_]of_list_unique, of_list_reduce *)
    val of_list_first: (K.t * 'a) list -> 'a t
    val of_list_last: (K.t * 'a) list -> 'a t
    val of_list_reduce: (K.t * 'a) list -> f:(K.t -> 'a -> 'a -> 'a) -> 'a t
    val to_list: 'a t -> (K.t * 'a) list

    val is_empty: 'a t -> bool
    val size: 'a t -> int

    val add: 'a t -> k:K.t -> v:'a -> bool * 'a t
    val replace: 'a t -> k:K.t -> v:'a -> 'a t
    val remove: 'a t -> k:K.t -> bool * 'a t

    val try_get: 'a t -> k:K.t -> 'a option
    val get: 'a t -> k:K.t -> 'a

    (* @feature Facets *)
  end
end

module Heap: sig
  module Poly: sig
    type 'a t

    val empty: 'a t

    (* val of_list: 'a list -> 'a t *)
    (* val to_list: 'a t -> 'a list *)

    (* val is_empty: 'a t -> bool *)
    (* val size: 'a t -> int *)

    val add: 'a t -> v:'a -> 'a t
    val pop_max: 'a t -> 'a t
    val max: 'a t -> 'a
  end

  module Make(E: Facets.Comparable.Basic.S0): sig
    type t

    val empty: t

    val add: t -> v:E.t -> t
    val pop_max: t -> t
    val max: t -> E.t
  end
end

module PriorityQueue: sig
  module Poly: sig
    type ('a, 'b) t

    val empty: ('a, 'b) t

    val is_empty: ('a, 'b) t -> bool

    val add: ('a, 'b) t -> k:'a -> v:'b -> ('a, 'b) t
    val pop_max: ('a, 'b) t -> ('a, 'b) t
    val max: ('a, 'b) t -> 'a * 'b
  end

  module Make(K: Facets.Comparable.Basic.S0): sig
    type 'a t

    val empty: 'a t

    val is_empty: 'a t -> bool

    val add: 'a t -> k:K.t -> v:'a -> 'a t
    val pop_max: 'a t -> 'a t
    val max: 'a t -> K.t * 'a
  end
end

(* @feature SortedList, UniqueList? *)
(* @feature Double-ended queue *)
(* @feature HashSet, HashMap *)
(* @feature SortedMultiSet, SortedMultiMap, HashMultiSet, HashMultiMap *)
(* [Sorted|Hash][Multi]Index (a Map where the keys are computed from the values (think "vertex_by_name")) *)

(* Specializations of collection containers *)

module IntRange: sig
  type t

  include Facets.Identifiable.S0 with type t := t
  (* @feature Add Comparable to make it Able
  Warning: compare r1 r2 should always be equal to List.compare (to_list r1) (to_list r2), so Compare.Poly will not work. *)

  val empty: t
  val make: ?start:int -> ?step:int -> int -> t

  val to_list: t -> int list
  val to_array: t -> int array

  include Facets.Foldable.S0 with type elt := int and type t := t
  include Facets.Foldable.Short.S0 with type elt := int and type t := t

  module ToList: sig
    include Facets.FilterMapable.ToList.S0 with type elt := int and type t := t
    include Facets.Scanable.ToList.S0 with type elt := int and type t := t
    include Facets.Scanable.Short.ToList.S0 with type elt := int and type t := t
  end
end

module IntList: sig
  include module type of List.Specialize(Int)
  include module type of List.SpecializeEquatable(Int) with type t := t
  include module type of List.SpecializeRepresentable(Int) with type t := t
end

module FloatList: sig
  include module type of List.Specialize(Float)
  include module type of List.SpecializeEquatable(Float) with type t := t
end

module StringList: sig
  include module type of List.Specialize(String)
  include module type of List.SpecializeEquatable(String) with type t := t

  val join: ?sep:string -> t -> string
end

module IntSortedSet: sig
  include module type of SortedSet.Make(Int)
end

module FloatSortedSet: sig
  include module type of SortedSet.Make(Float)
end

module StringSortedSet: sig
  include module type of SortedSet.Make(String)
end

module CharSortedSet: sig
  include module type of SortedSet.Make(Char)
end

module IntSortedMap: sig
  include module type of SortedMap.Make(Int)
end

module FloatSortedMap: sig
  include module type of SortedMap.Make(Float)
end

module StringSortedMap: sig
  include module type of SortedMap.Make(String)
end

module CharSortedMap: sig
  include module type of SortedMap.Make(Char)
end

(* @feature XxxList when Xxx is a Ringoid: add sum, product *)
(* @feature BoolList (with all, exists, etc.) *)
(* @feature OptionList (with first_some, values (ie filter_some)) *)
(* @feature ListList, ArrayArray, StreamStream with val flatten: 'a t t -> 'a t *)
(* @feature LazyList.to_list_lazy *)

(* Input/output *)

module Format: sig
  type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6

  (* From Pervasives:
  type ('a, 'b, 'c, 'd) format4 = ('a, 'b, 'c, 'c, 'c, 'd) format6
  type ('a, 'b, 'c) format = ('a, 'b, 'c, 'c, 'c, 'c) format6 *)

  val with_result: ('b, unit, string, string, string, 'a) t -> f:(string -> 'a) -> 'b

  val apply: ('a, unit, string, string, string, string) t -> 'a

  val to_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> string

  val of_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('a, 'b, 'c, 'd, 'e, 'f) t

  val concat: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('f, 'b, 'c, 'e, 'g, 'h) t -> ('a, 'b, 'c, 'd, 'g, 'h) t

  val with_scan_result: ('a, OCamlStandard.Scanf.Scanning.scanbuf, 'b, 'c -> 'd, 'a -> 'e, 'e) t -> f:'c -> string -> 'd
end

module InChannel: sig
  type t = OCamlStandard.Pervasives.in_channel

  (* @feature val lines: string Stream.t *)
end

module InFile: sig
  type t

  (* @todo Open modes *)
  val with_file: string -> f:(t -> 'a) -> 'a
  val with_channel: string -> f:(InChannel.t -> 'a) -> 'a

  val channel: t -> InChannel.t

  val seek: t -> pos:int64 -> unit
  val pos: t -> int64
  val size: t -> int64
end

module OutChannel: sig
  type t = OCamlStandard.Pervasives.out_channel

  val print: ?flush:bool -> t -> ('a, t, unit, unit, unit, unit) Format.t -> 'a
  val output: t -> bytes -> unit
  val flush: t -> unit
end

module OutFile: sig
  type t

  (* @todo Open modes *)
  val with_file: string -> f:(t -> 'a) -> 'a
  val with_channel: string -> f:(OutChannel.t -> 'a) -> 'a

  val channel: t -> OutChannel.t

  val seek: t -> pos:int64 -> unit
  val pos: t -> int64
  val size: t -> int64
end

module StdIn: sig
  val channel: InChannel.t
end

module StdOut: sig
  val channel: OutChannel.t
  val print: ?flush:bool -> ('a, OutChannel.t, unit, unit, unit, unit) Format.t -> 'a
  val output: bytes -> unit
  val flush: unit -> unit
end

module StdErr: sig
  val channel: OutChannel.t
  val print: ?flush:bool -> ('a, OutChannel.t, unit, unit, unit, unit) Format.t -> 'a
  val output: bytes -> unit
  val flush: unit -> unit
end

(* Testing utilities *)

module Testing: sig
  module Result: sig
    module Status: sig
      type failure

      type t =
        | Success
        | Failure of failure
        | Error of exn * OCamlStandard.Printexc.raw_backtrace option

      val to_string: t -> string
    end

    type single = {
      label: string;
      status: Status.t;
    }

    module Counts: sig
      type t = {
        successes: int;
        failures: int;
        errors: int;
      }
    end

    type group = {
      name: string;
      children: t list;
      counts: Counts.t;
    }

    and t =
      | Single of single
      | Group of group
  end

  val run: ?record_backtrace:bool -> Test.t -> Result.t

  val command_line_main: argv:string list -> Test.t -> Exit.t

  val (>::): string -> Test.t list -> Test.t

  val (>:): string -> unit lazy_t -> Test.t

  val (~:): ('a, unit, string, string, string, unit lazy_t -> Test.t) CamlinternalFormatBasics.format6 -> 'a

  val (~::): ('a, unit, string, string, string, Test.t list -> Test.t) CamlinternalFormatBasics.format6 -> 'a

  val fail: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val expect_exception: expected:exn -> 'a lazy_t -> unit

  val expect_exception_named: expected:string -> 'a lazy_t -> unit

  val check: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a -> unit

  val check_poly: repr:('a -> string) -> expected:'a -> 'a -> unit

  val check_string: expected:string -> string -> unit

  val check_bool: expected:bool -> bool -> unit

  val check_true: bool -> unit

  val check_false: bool -> unit

  val check_int: expected:int -> int -> unit

  (* @feature val check_int32: expected:int32 -> int32 -> unit *)

  (* @feature val check_int64: expected:int64 -> int64 -> unit *)

  val check_float: ?precision:float -> expected:float -> float -> unit

  val check_float_in: low:float -> high:float -> float -> unit

  val check_float_exact: expected:float -> float -> unit

  val check_option: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a option -> 'a option -> unit

  val check_option_poly: repr:('a -> string) -> expected:'a option -> 'a option -> unit

  val check_some: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a -> 'a option -> unit

  val check_none: repr:('a -> string) -> equal:('a -> 'a -> bool) -> 'a option -> unit

  val check_some_poly: repr:('a -> string) -> expected:'a -> 'a option -> unit

  val check_none_poly: repr:('a -> string) -> 'a option -> unit

  val check_int_option: expected:int option -> int option -> unit

  val check_some_int: expected:int -> int option -> unit

  val check_none_int: int option -> unit

  val check_string_option: expected:string option -> string option -> unit

  val check_some_string: expected:string -> string option -> unit

  val check_none_string: string option -> unit

  val check_list: repr:('a -> string) -> equal:('a -> 'a -> bool) -> expected:'a list -> 'a list -> unit

  val check_list_poly: repr:('a -> string) -> expected:'a list -> 'a list -> unit

  val check_string_list: expected:string list -> string list -> unit

  val check_int_list: expected:int list -> int list -> unit
end

(** Modules to be opened *)

module Standard: sig
  (** This modules defines aliases for all standard modules in :mod:`General`: *)

  module Testing = Testing

  module Array = Array
  module BigInt = BigInt
  module Bool = Bool
  module Bytes = Bytes
  module CallStack = CallStack
  module Char = Char
  module Exception = Exception
  module Exit = Exit
  module Float = Float
  module Format = Format
  module Function1 = Function1
  module Function2 = Function2
  module Function3 = Function3
  module Function4 = Function4
  module Function5 = Function5
  module Heap = Heap
  module InChannel = InChannel
  module InFile = InFile
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Lazy = Lazy
  module List = List
  module NativeInt = NativeInt
  module Option = Option
  module OutChannel = OutChannel
  module OutFile = OutFile
  module PriorityQueue = PriorityQueue
  module Reference = Reference
  module SortedMap = SortedMap
  module SortedSet = SortedSet
  module StdErr = StdErr
  module StdIn = StdIn
  module StdOut = StdOut
  module Stream = Stream
  module String = String
  module Tuple2 = Tuple2
  module Tuple3 = Tuple3
  module Tuple4 = Tuple4
  module Tuple5 = Tuple5
  module Unit = Unit

  module IntRange = IntRange

  module FloatOption = FloatOption
  module IntOption = IntOption
  module StringOption = StringOption

  module FloatReference = FloatReference
  module IntReference = IntReference
  module StringReference = StringReference

  module FloatList = FloatList
  module IntList = IntList
  module StringList = StringList

  module CharSortedSet = CharSortedSet
  module FloatSortedSet = FloatSortedSet
  module IntSortedSet = IntSortedSet
  module StringSortedSet = StringSortedSet

  module CharSortedMap = CharSortedMap
  module FloatSortedMap = FloatSortedMap
  module IntSortedMap = IntSortedMap
  module StringSortedMap = StringSortedMap

  (** It also includes :mod:`General.Ubiquitous`. *)

  include module type of Ubiquitous[@remove_aliases]
  with module Array := Array
  and module Bytes := Bytes
  and module Char := Char
  #ifdef HAS_Float
  and module Float := Float
  #endif
  and module Format := Format
  and module Int32 := Int32
  and module Int64 := Int64
  and module Lazy := Lazy
  and module List := List
  and module Stream := Stream
  and module String := String
  [@@autodoc.hide]
end

module Abbr: sig
  (** This modules defines abbreviated aliases for all standard modules in :mod:`General`: *)

  module Tst = Testing

  module Ar = Array
  module BigInt = BigInt
  module Bo = Bool
  module By = Bytes
  module CallStack = CallStack
  module Ch = Char
  module Exit = Exit
  module Exn = Exception
  module Fl = Float
  module Frmt = Format
  module Fun1 = Function1
  module Fun2 = Function2
  module Fun3 = Function3
  module Fun4 = Function4
  module Fun5 = Function5
  module Heap = Heap
  module InCh = InChannel
  module InFile = InFile
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Laz = Lazy
  module Li = List
  module NativeInt = NativeInt
  module Opt = Option
  module OutCh = OutChannel
  module OutFile = OutFile
  module PriQu = PriorityQueue
  module Ref = Reference
  module SoMap = SortedMap
  module SoSet = SortedSet
  module StdErr = StdErr
  module StdIn = StdIn
  module StdOut = StdOut
  module Str = String
  module Strm = Stream
  module Tu2 = Tuple2
  module Tu3 = Tuple3
  module Tu4 = Tuple4
  module Tu5 = Tuple5
  module Unit = Unit

  module IntRa = IntRange

  module FlOpt = FloatOption
  module IntOpt = IntOption
  module StrOpt = StringOption

  module FlRef = FloatReference
  module IntRef = IntReference
  module StrRef = StringReference

  module FlLi = FloatList
  module IntLi = IntList
  module StrLi = StringList

  module ChSoSet = CharSortedSet
  module FlSoSet = FloatSortedSet
  module IntSoSet = IntSortedSet
  module StrSoSet = StringSortedSet

  module ChSoMap = CharSortedMap
  module FlSoMap = FloatSortedMap
  module IntSoMap = IntSortedMap
  module StrSoMap = StringSortedMap

  (** It also includes :mod:`General.Ubiquitous`. *)

  include module type of Ubiquitous[@remove_aliases]
  with module Int32 := Int32
  and module Int64 := Int64
  [@@autodoc.hide]
end

(* @todo Remove from interface, or make a functor, to avoid linking tests in client applications *)
module Tests: sig
  val test: Test.t
end [@@autodoc.hide]
