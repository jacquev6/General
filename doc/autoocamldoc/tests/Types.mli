(** Doc for manifest *)
type manifest = int
(** Doc' for manifest *)

(** Doc for parameter *)
type 'a parameter
(** Doc' for parameter *)

(** Doc for parameters *)
type ('a, 'b) parameters
(** Doc' for parameters *)

(** Doc for variances *)
type (-'a, +'b) variances
(** Doc' for variances *)

(* @todo type record = {a: int; b: float} *)

(* @todo type variant =
  | Single of int
  | Several of int * float
  | Tuple of (int * float)
  | None *)
