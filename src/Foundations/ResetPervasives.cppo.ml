(*
All val, external, type and module from Pervasives, checked in OCaml:
- 4.02 (https://caml.inria.fr/pub/docs/manual-ocaml-4.02/libref/Pervasives.html)

Exceptions:
I don't know how to reset exceptions. Thankfully, there is just one: Exit.

Values:
If we forget to reset a val, it will be detected by greping ResetPervasives.inferred.mli.
If we try to reset an unexisting val, the PLEASE_USE macro will raise an error.

Externals:
Currently we don't want to reset any external.

Types and modules:
If we forget them entirely, it will be detected as well.
If we add them to the destructive substitution in 'include Pervasives', there is no way to detect that we forgot them in the body.
So: add types and modules in the body *before* in 'include Pervasives'.
*)

#if OCAML_VERSION >= (4, 2, 0)
  #define HAS_raise_notrace
#endif

(* To detect values not reset, in ResetPervasives.inferred.mli *)
include (Pervasives:
  module type of Pervasives
  with type fpclass := Pervasives.fpclass
  and type in_channel := Pervasives.in_channel
  and type out_channel := Pervasives.out_channel
  and type open_flag := Pervasives.open_flag
  and type 'a ref := 'a Pervasives.ref
  and type ('a, 'b, 'c, 'd, 'e, 'f) format6 := ('a, 'b, 'c, 'd, 'e, 'f) Pervasives.format6
  and type ('a, 'b, 'c, 'd) format4 := ('a, 'b, 'c, 'd) Pervasives.format4
  and type ('a, 'b, 'c) format := ('a, 'b, 'c) Pervasives.format
  and module LargeFile := Pervasives.LargeFile
)

#define PLEASE_USE(v, repl) \
  let _ = v \
  let v = `CONCAT(Please_use_General__, repl)

#define PLEASE_USE_TYPE(t, repl) \
  type t = [`CONCAT(Please_use_General__, repl)]

(* Exceptions *)
PLEASE_USE(raise, Exception__raise)
#ifdef HAS_raise_notrace
PLEASE_USE(raise_notrace, Exception__raise_without_backtrace)
#endif
PLEASE_USE(invalid_arg, Exception__invalid_argument)
PLEASE_USE(failwith, Exception__failure)
(* exception Exit *)

(* Comparisons *)
PLEASE_USE((=), Equate__Poly__equal)
PLEASE_USE((<>), Equate__Poly__different)
PLEASE_USE((<), Compare__Poly__less_than)
PLEASE_USE((>), Compare__Poly__greater_than)
PLEASE_USE((<=), Compare__Poly__less_or_equal)
PLEASE_USE((>=), Compare__Poly__greater_or_equal)
PLEASE_USE(compare, Compare__Poly__compare)
PLEASE_USE(min, Compare__Poly__min)
PLEASE_USE(max, Compare__Poly__max)
PLEASE_USE((==), Equate__Physical__equal)
PLEASE_USE((!=), Equate__Physical__different)

(* Boolean operations *)
PLEASE_USE(not, Bool__not)
PLEASE_USE((&&), Bool__and_)
let (&) = `Please_use_General__Bool__and_
PLEASE_USE((||), Bool__or_)
let (or) = `Please_use_General__Bool__or_

(* Debugging *)
(* Nothing to reset *)

(* Composition operators *)
PLEASE_USE((|>), Function__rev_apply)
PLEASE_USE((@@), Function__apply)

(* Integer arithmetics *)
PLEASE_USE((~-), Int__negate)
PLEASE_USE((~+), Std__identity)
PLEASE_USE(succ, Int__succ)
PLEASE_USE(pred, Int__pred)
PLEASE_USE((+), Int__add)
PLEASE_USE((-), Int__substract)
PLEASE_USE(( * ), Int__multiply)
PLEASE_USE((/), Int__divide)
PLEASE_USE((mod), Int__modulo)
PLEASE_USE(abs, Int__abs)
PLEASE_USE(max_int, Int__greatest)
PLEASE_USE(min_int, Int__smallest)

(* Bitwise operations *)
PLEASE_USE((land), Int__Bitwise__logical_and)
PLEASE_USE((lor), Int__Bitwise__logical_or)
PLEASE_USE((lxor), Int__Bitwise__logical_xor)
PLEASE_USE((lnot), Int__Bitwise__logical_not)
PLEASE_USE((lsl), Int__Bitwise__logical_shift_left)
PLEASE_USE((lsr), Int__Bitwise__logical_shift_right)
PLEASE_USE((asr), Int__Bitwise__arithmetic_shift_right)

(* Floating-point arithmetic *)
PLEASE_USE((~-.), Float__negate)
PLEASE_USE((~+.), Std__identity)
PLEASE_USE((+.), Float__add)
PLEASE_USE((-.), Float__substract)
PLEASE_USE(( *. ), Float__multiply)
PLEASE_USE((/.), Float__divide)
PLEASE_USE(( ** ), Float__exponentiate)
PLEASE_USE(sqrt, Float__sqrt)
PLEASE_USE(exp, Float__exp)
PLEASE_USE(log, Float__log)
PLEASE_USE(log10, Float__log10)
PLEASE_USE(expm1, Float__expm1)
PLEASE_USE(log1p, Float__log1p)
PLEASE_USE(cos, Float__cos)
PLEASE_USE(sin, Float__sin)
PLEASE_USE(tan, Float__tan)
PLEASE_USE(acos, Float__acos)
PLEASE_USE(asin, Float__asin)
PLEASE_USE(atan, Float__atan)
PLEASE_USE(atan2, Float__atan2)
PLEASE_USE(hypot, Float__hypot)
PLEASE_USE(cosh, Float__cosh)
PLEASE_USE(sinh, Float__sinh)
PLEASE_USE(tanh, Float__tanh)
PLEASE_USE(ceil, Float__ceil)
PLEASE_USE(floor, Float__floor)
PLEASE_USE(abs_float, Float__abs)
PLEASE_USE(copysign, Float__copy_sign)
PLEASE_USE(mod_float, Float__modulo)
PLEASE_USE(frexp, Float__to_parts)
PLEASE_USE(ldexp, Float__of_parts)
PLEASE_USE(modf, Float__to_fractional_and_integral)
PLEASE_USE(float, Float__of_int)
PLEASE_USE(float_of_int, Float__of_int)
PLEASE_USE(truncate, Int__of_float)
PLEASE_USE(int_of_float, Int__of_float)
PLEASE_USE(infinity, Float__infinity)
PLEASE_USE(neg_infinity, Float__negative_infinity)
PLEASE_USE(nan, Float__not_a_number)
PLEASE_USE(max_float, Float__smallest)
PLEASE_USE(min_float, Float__greatest)
PLEASE_USE(epsilon_float, Float__epsilon)
PLEASE_USE_TYPE(fpclass, Float__Class__t)
PLEASE_USE(classify_float, Float__Class__of_float)

(* String operations *)
PLEASE_USE((^), String__concat)

(* Character operations *)
PLEASE_USE(int_of_char, Char__of_int)
PLEASE_USE(char_of_int, Char__to_int)

(* Unit operations *)
PLEASE_USE(ignore, Unit__ignore)

(* String conversion functions *)
PLEASE_USE(string_of_bool, Bool__to_string)
PLEASE_USE(bool_of_string, Bool__of_string)
PLEASE_USE(string_of_int, Int__to_string)
PLEASE_USE(int_of_string, Int__of_string)
PLEASE_USE(string_of_float, Float__of_string)
PLEASE_USE(float_of_string, Float__to_string)

(* Pair operations *)
PLEASE_USE(fst, Tuple2__get_0)
PLEASE_USE(snd, Tuple2__get_1)

(* List operations *)
PLEASE_USE((@), List__append__todo)

(* Input/output *)
PLEASE_USE_TYPE(in_channel, InChannel__t__todo)
PLEASE_USE_TYPE(out_channel, OutChannel__t__todo)
PLEASE_USE(stdin, todo)
PLEASE_USE(stdout, todo)
PLEASE_USE(stderr, todo)

(* Output functions on standard output *)
PLEASE_USE(print_char, todo)
PLEASE_USE(print_string, todo)
PLEASE_USE(print_bytes, todo)
PLEASE_USE(print_int, todo)
PLEASE_USE(print_float, todo)
PLEASE_USE(print_endline, todo)
PLEASE_USE(print_newline, todo)

(* Output functions on standard error *)
PLEASE_USE(prerr_char, todo)
PLEASE_USE(prerr_string, todo)
PLEASE_USE(prerr_bytes, todo)
PLEASE_USE(prerr_int, todo)
PLEASE_USE(prerr_float, todo)
PLEASE_USE(prerr_endline, todo)
PLEASE_USE(prerr_newline, todo)

(* Input functions on standard input *)
PLEASE_USE(read_line, todo)
PLEASE_USE(read_int, todo)
PLEASE_USE(read_float, todo)

(* General output functions *)
PLEASE_USE_TYPE(open_flag, todo)
PLEASE_USE(open_out, todo)
PLEASE_USE(open_out_bin, todo)
PLEASE_USE(open_out_gen, todo)
PLEASE_USE(flush, todo)
PLEASE_USE(flush_all, todo)
PLEASE_USE(output_char, todo)
PLEASE_USE(output_string, todo)
PLEASE_USE(output_bytes, todo)
PLEASE_USE(output, todo)
PLEASE_USE(output_substring, todo)
PLEASE_USE(output_byte, todo)
PLEASE_USE(output_binary_int, todo)
PLEASE_USE(output_value, todo)
PLEASE_USE(seek_out, todo)
PLEASE_USE(pos_out, todo)
PLEASE_USE(out_channel_length, todo)
PLEASE_USE(close_out, todo)
PLEASE_USE(close_out_noerr, todo)
PLEASE_USE(set_binary_mode_out, todo)

(* General input functions *)
PLEASE_USE(open_in, todo)
PLEASE_USE(open_in_bin, todo)
PLEASE_USE(open_in_gen, todo)
PLEASE_USE(input_char, todo)
PLEASE_USE(input_line, todo)
PLEASE_USE(input, todo)
PLEASE_USE(really_input, todo)
PLEASE_USE(really_input_string, todo)
PLEASE_USE(input_byte, todo)
PLEASE_USE(input_binary_int, todo)
PLEASE_USE(input_value, todo)
PLEASE_USE(seek_in, todo)
PLEASE_USE(pos_in, todo)
PLEASE_USE(in_channel_length, todo)
PLEASE_USE(close_in, todo)
PLEASE_USE(close_in_noerr, todo)
PLEASE_USE(set_binary_mode_in, todo)

(* Operations on large files *)
module LargeFile = struct
  include Pervasives.LargeFile

  PLEASE_USE(seek_out, todo)
  PLEASE_USE(pos_out, todo)
  PLEASE_USE(out_channel_length, todo)
  PLEASE_USE(seek_in, todo)
  PLEASE_USE(pos_in, todo)
  PLEASE_USE(in_channel_length, todo)
end

(* References *)
PLEASE_USE_TYPE('a ref, Reference__t)
PLEASE_USE(ref, Reference__of_contents)
PLEASE_USE((!), Reference__contents)
PLEASE_USE((:=), Reference__assign)
PLEASE_USE(incr, IntReference__increment)
PLEASE_USE(decr, IntReference__decrement)

(* Operations on format strings *)
PLEASE_USE_TYPE(('a, 'b, 'c, 'd, 'e, 'f) format6, Format__t)
PLEASE_USE_TYPE(('a, 'b, 'c, 'd) format4, Format__t)
PLEASE_USE_TYPE(('a, 'b, 'c) format, Format__t)
PLEASE_USE(string_of_format, Format__to_string)
PLEASE_USE(format_of_string, Format__of_string)
PLEASE_USE((^^), Format__concat)

(* Program termination *)
PLEASE_USE(exit, Exit__exit)
PLEASE_USE(at_exit, Exit__at_exit)

(* The following is for system use only. Do not call directly. *)
PLEASE_USE(valid_float_lexem, Std__OCamlStandard__Pervasives__valid_float_lexem)
PLEASE_USE(unsafe_really_input, Std__OCamlStandard__Pervasives__unsafe_really_input)
PLEASE_USE(do_at_exit, Std__OCamlStandard__Pervasives__do_at_exit)
