module type MT = sig
  (** Doc for v *)
  val v: int
  (** Doc' for v *)

  (** Doc for hidden *)
  val hidden: int [@@autodoc.hide]
  (** Doc' for hidden *)
end

include MT
