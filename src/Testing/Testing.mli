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

val check_char: expected:char -> char -> unit

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
