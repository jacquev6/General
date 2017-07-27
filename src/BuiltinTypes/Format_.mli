type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6

(* From Pervasives:
type ('a, 'b, 'c, 'd) format4 = ('a, 'b, 'c, 'c, 'c, 'd) format6
type ('a, 'b, 'c) format = ('a, 'b, 'c, 'c, 'c, 'c) format6 *)

val ksprintf: ('b, unit, string, string, string, 'a) t -> f:(string -> 'a) -> 'b

val sprintf : ('a, unit, string, string, string, string) t -> 'a

val printf : ('a, out_channel, unit, unit, unit, unit) t -> 'a

val to_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> string

val of_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('a, 'b, 'c, 'd, 'e, 'f) t

val concat: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('f, 'b, 'c, 'e, 'g, 'h) t -> ('a, 'b, 'c, 'd, 'g, 'h) t
