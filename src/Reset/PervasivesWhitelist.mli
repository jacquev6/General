(** This module overrides all elements from the standard
`pervasives <https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libref/Stdlib.html>`_
with unusable but guiding values like:

.. val:: raise
  :noindex:
  :type: [ `Please_use_General__Exception__raise ]

  The types of these values point at what replaces them in :mod:`General`.
  (In that case, :val:`General.Exception.raise`).

It then brings back a small set of ubiquitous values: *)

(** **Boolean operators** *)

(** Negation. Alias of :val:`General.Bool.O.not`. *)
val not: bool -> bool

(** Conjunction. Lazy. Alias of :val:`General.Bool.O.(&&)` *)
val (&&): bool -> bool -> bool

(** Disjunction. Lazy. Alias of :val:`General.Bool.O.(||)` *)
val (||): bool -> bool -> bool

(** **Integer operators** *)

val (~-): int -> int
val (~+): int -> int
val (+): int -> int -> int
val (-): int -> int -> int
val ( * ): int -> int -> int
val (/): int -> int -> int
val (mod): int -> int -> int

(** **Floating point operators** *)

val (~-.): float -> float
val (~+.): float -> float
val (+.): float -> float -> float
val (-.): float -> float -> float
val ( *. ): float -> float -> float
val (/.): float -> float -> float
val ( ** ): float -> float -> float

(** **Function composition and application** *)

val (@@): ('a -> 'b) -> 'a -> 'b
val (|>): 'a -> ('a -> 'b) -> 'b
val (%): ('a -> 'b) -> ('c -> 'a) -> ('c -> 'b)

(** **References** *)

val ref: 'a -> 'a OCamlStandard.Pervasives.ref
val (:=): 'a OCamlStandard.Pervasives.ref -> 'a -> unit
val (!): 'a OCamlStandard.Pervasives.ref -> 'a

(** **Polymorphic comparison** *)

(* @todo Should we really publish these? They are error-prone when comparing types with specialized comparisons. And yet so practical... *)

val (=): 'a -> 'a -> bool
val (<>): 'a -> 'a -> bool

val (<): 'a -> 'a -> bool
val (<=): 'a -> 'a -> bool
val (>=): 'a -> 'a -> bool
val (>): 'a -> 'a -> bool

(** **Ubiquitous functions** *)

val ignore: 'a -> unit

val identity: 'a -> 'a

(** **Miscelaneous operators** *)

val (@): 'a list -> 'a list -> 'a list

val (^): string -> string -> string