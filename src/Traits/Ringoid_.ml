module Basic = struct
  module type S0 = sig
    type t

    val zero: t
    val one: t

    val negate: t -> t
    val add: t -> t -> t
    val substract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (~-): t -> t
    val (+): t -> t -> t
    val (-): t -> t -> t
    val ( * ): t -> t -> t
    val (/): t -> t -> t

    val ( ** ): t -> int -> t
  end

  module Make0(M: sig
    type t

    val negate: t -> t
    val add: t -> t -> t
    val substract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t

    val exponentiate: t -> int -> t
  end) = struct
    open M

    let (~-) x =
      negate x

    let (+) x y =
      add x y

    let (-) x y =
      substract x y

    let ( * ) x y =
      multiply x y

    let (/) x y =
      divide x y

    let ( ** ) x n =
      exponentiate x n
  end
end

module type S0 = sig
  include Basic.S0

  val square: t -> t
  val exponentiate: t -> int -> t

  module O: Operators.S0 with type t := t
end

module Substract = struct
  module Make0(M: sig
    type t

    val negate: t -> t
    val add: t -> t -> t
  end) = struct
    open M

    let substract x y =
      add x (negate y)
  end
end

module Square = struct
  module Make0(M: sig
    type t

    val multiply: t -> t -> t
  end) = struct
    open M

    let square x =
      multiply x x
  end
end

module Exponentiate = struct
  module Make0(M: sig
    type t

    val one: t

    val square: t -> t
    val multiply: t -> t -> t

    val exponentiate_negative_exponent: exponentiate:(t -> int -> t) -> t -> int -> t
  end) = struct
    open M

    let exponentiate =
      let rec aux y x n = OCamlStandard.Pervasives.(
        if n < 0 then
          exponentiate_negative_exponent ~exponentiate:(aux one) x n
        else if n = 0 then
          y
        else if n = 1 then
          multiply x y
        else if n mod 2 = 0 then
          aux y (square x) (n / 2)
        else
          aux (multiply x y) (square x) ((n - 1) / 2)
      ) in
      fun x n ->
      aux one x n
  end
end
