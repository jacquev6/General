type 'a t = 'a option

include Traits_.Equatable_.S1 with type 'a t := 'a t
include Traits_.Representable_.S1 with type 'a t := 'a t

val some_if: bool -> 'a lazy_t -> 'a t
