(** Doc for typ *)
type typ
(** Doc' for typ *)

(** Doc for hidden_type *)
type hidden_type [@@autodoc.hide]
(** Doc' for hidden_type *)

(** Doc for v *)
val v: typ
(** Doc' for v *)

(** Doc for hidden_v *)
val hidden_v: typ [@@autodoc.hide]
(** Doc' for hidden_v *)

(** Doc for Exception0 *)
exception Exception0
(** Doc' for Exception0 *)

(** Doc for Exception1 *)
exception Exception1 of typ
(** Doc' for Exception1 *)

(** Doc for Exception2 *)
exception Exception2 of typ * int
(** Doc' for Exception2 *)

(** Doc for HiddenException0 *)
exception HiddenException0 [@@autodoc.hide]
(** Doc' for HiddenException0 *)

(** Doc for HiddenException1 *)
exception HiddenException1 of typ [@@autodoc.hide]
(** Doc' for HiddenException1 *)

(** Doc for HiddenException2 *)
exception HiddenException2 of typ * int [@@autodoc.hide]
(** Doc' for HiddenException2 *)

(** Floating documentation *)

(** Doc for Module *)
module Module: sig end
(** Doc' for Module *)

(** Doc for HiddenModule *)
module HiddenModule: sig end [@@autodoc.hide]
(** Doc' for HiddenModule *)

(** Doc for ModuleType *)
module type ModuleType = sig end
(** Doc' for ModuleType *)

(** Doc for HiddenModuleType *)
module type HiddenModuleType = sig end [@@autodoc.hide]
(** Doc' for HiddenModuleType *)

(** Doc for include *)
include Set.OrderedType
(** Doc' for include *)

module A: sig
  include Set.OrderedType [@@autodoc.hide]
end

(** Doc for recursive_type1 *)
type recursive_type1 =
  | A of recursive_type2 (** Doc for A *)
  | B (** Doc for B *)
(** Doc' for recursive_type1 *)

(** Doc for recursive_type2 *)
and recursive_type2 = recursive_type1 * recursive_type1
(** Doc' for recursive_type2 *)

(** Doc for hidden_recursive_type1 *)
type hidden_recursive_type1 =
  | A of hidden_recursive_type2 (** Doc for A *)
  | B (** Doc for B *) [@@autodoc.hide]
(** Doc' for hidden_recursive_type1 *)

(** Doc for hidden_recursive_type2 *)
and hidden_recursive_type2 = hidden_recursive_type1 * hidden_recursive_type1 [@@autodoc.hide]
(** Doc' for hidden_recursive_type2 *)
