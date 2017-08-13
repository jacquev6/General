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

(** Doc for record *)
type record = {
  a: int; (** Doc for record.a *)
  b: float; (** Doc for record.b *)
}
(** Doc' for record *)

(** Doc for variant *)
type variant =
  | None (** Doc for None *)
  | Single of int (** Doc for Single *)
  | Several of int * float (** Doc for Several *)
  | Tuple of (int * float) (** Doc for Tuple *)
  | Record of {
    a: int; (** Doc for Record.a *)
    b: float; (** Doc for Record.b *)
  } (** Doc for Record *)
(** Doc' for variant *)
