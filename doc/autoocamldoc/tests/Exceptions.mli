(** Doc for Single *)
exception Simple
(** Doc' for Single *)

(** Doc for SinglePayload *)
exception SinglePayload of int
(** Doc' for SinglePayload *)

(** Doc for SeveralPayload *)
exception SeveralPayload of int * float * string
(** Doc' for SeveralPayload *)

(** Doc for TuplePayload *)
exception TuplePayload of (int * float * string)
(** Doc' for TuplePayload *)

(* @todo exception RecordPayload of {a: int; b: float} *)
