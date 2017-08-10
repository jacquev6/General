type simple

type 'a one_parameter

type ('a, 'b, 'c, 'd) several_parameter

type (+'a, -'b) variance

type manifest = int

type ('a, 'b) manifest_and_parameters = 'a list * 'b array

(** Doc for variant *)
type variant =
  | A (** Doc for A *)
  | B of int (** Doc for B *)
  | C of int * string (** Doc for C *)
  | D of (int * string) (** Doc for D *)
(** Doc' for variant *)

type 'a variant_with_manifest_and_parameter = 'a option = None | Some of 'a

(** Doc for record *)
type record = {
  field: int; (** Doc for field *)
  bar: float list; (** Doc for bar *)
}
(** Doc' for record *)

type 'a record_with_manifest_and_parameter = 'a ref = {mutable contents: 'a}

(** Two mutually recursive types *)
type tree = Node of node | Leaf
and node = int * tree

type 'a constrained_to_list constraint 'a = _ list

type 'a constrained_to_tuple constraint 'a = (_ * _)

type ('a, 'b) function_ = 'a -> 'b

type function_with_label = a:int -> unit

type function_with_optional_label = ?a:int -> unit
