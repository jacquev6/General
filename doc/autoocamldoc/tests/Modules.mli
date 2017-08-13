(** Doc for Signature *)
module Signature: sig
  type t1

  (** Floating doc *)

  type t2

  (**       Floating doc with many leading spaces (which should be removed),
  several lines::

      and a quoted, indented part (that should keep its indentation)
      with another line with trailing spaces (that should be removed)                 

  And a conclusion with many trailing spaces (which should be removed as well).       *)
end
(** Doc' for Signature *)

(** Doc for Hidden *)
module Hidden: sig
end [@@autodoc.hide]
(** Doc for Hidden *)
