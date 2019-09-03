(* Exceptions *)
RESET_VALUE(raise, Exception__raise)
RESET_VALUE(raise_notrace, Exception__raise_without_backtrace)
RESET_VALUE(invalid_arg, Exception__invalid_argument)
RESET_VALUE(failwith, Exception__failure)
(* exception Exit *)

(* Comparisons *)
RESET_VALUE((=), Equate__Poly__equal)
RESET_VALUE((<>), Equate__Poly__different)
RESET_VALUE((<), Compare__Poly__less_than)
RESET_VALUE((>), Compare__Poly__greater_than)
RESET_VALUE((<=), Compare__Poly__less_or_equal)
RESET_VALUE((>=), Compare__Poly__greater_or_equal)
RESET_VALUE(compare, Compare__Poly__compare)
RESET_VALUE(min, Compare__Poly__min)
RESET_VALUE(max, Compare__Poly__max)
RESET_VALUE((==), Equate__Phys__equal)
RESET_VALUE((!=), Equate__Phys__different)

(* Boolean operations *)
RESET_VALUE(not, Bool__not)
RESET_VALUE((&&), Bool__and_)
RESET_VALUE((||), Bool__or_)
[@@@ocaml.warning "-3"]
RESET_VALUE((&), Bool__and_)
RESET_VALUE((or), Bool__or_)
[@@@ocaml.warning "+3"]

(* Debugging *)
(* Nothing to reset *)

(* Composition operators *)
RESET_VALUE((|>), Function1__rev_apply)
RESET_VALUE((@@), Function1__apply)

(* Integer arithmetics *)
RESET_VALUE((~-), Int__negate)
RESET_VALUE((~+), Function1__identity)
RESET_VALUE(succ, Int__succ)
RESET_VALUE(pred, Int__pred)
RESET_VALUE((+), Int__add)
RESET_VALUE((-), Int__substract)
RESET_VALUE(( * ), Int__multiply)
RESET_VALUE((/), Int__divide)
RESET_VALUE((mod), Int__modulo)
RESET_VALUE(abs, Int__abs)
RESET_VALUE(max_int, Int__greatest)
RESET_VALUE(min_int, Int__smallest)

(* Bitwise operations *)
RESET_VALUE((land), Int__Bitwise__logical_and)
RESET_VALUE((lor), Int__Bitwise__logical_or)
RESET_VALUE((lxor), Int__Bitwise__logical_xor)
RESET_VALUE(lnot, Int__Bitwise__logical_not)
RESET_VALUE((lsl), Int__Bitwise__logical_shift_left)
RESET_VALUE((lsr), Int__Bitwise__logical_shift_right)
RESET_VALUE((asr), Int__Bitwise__arithmetic_shift_right)

(* Floating-point arithmetic *)
RESET_VALUE((~-.), Float__negate)
RESET_VALUE((~+.), Function1__identity)
RESET_VALUE((+.), Float__add)
RESET_VALUE((-.), Float__substract)
RESET_VALUE(( *. ), Float__multiply)
RESET_VALUE((/.), Float__divide)
RESET_VALUE(( ** ), Float__exponentiate)
RESET_VALUE(sqrt, Float__sqrt)
RESET_VALUE(exp, Float__exp)
RESET_VALUE(log, Float__log)
RESET_VALUE(log10, Float__log10)
RESET_VALUE(expm1, Float__expm1)
RESET_VALUE(log1p, Float__log1p)
RESET_VALUE(cos, Float__cos)
RESET_VALUE(sin, Float__sin)
RESET_VALUE(tan, Float__tan)
RESET_VALUE(acos, Float__acos)
RESET_VALUE(asin, Float__asin)
RESET_VALUE(atan, Float__atan)
RESET_VALUE(atan2, Float__atan2)
RESET_VALUE(hypot, Float__hypot)
RESET_VALUE(cosh, Float__cosh)
RESET_VALUE(sinh, Float__sinh)
RESET_VALUE(tanh, Float__tanh)
RESET_VALUE(ceil, Float__ceil)
RESET_VALUE(floor, Float__floor)
RESET_VALUE(abs_float, Float__abs)
RESET_VALUE(copysign, Float__copy_sign)
RESET_VALUE(mod_float, Float__modulo)
RESET_VALUE(frexp, Float__to_parts)
RESET_VALUE(ldexp, Float__of_parts)
RESET_VALUE(modf, Float__to_fractional_and_integral)
RESET_VALUE(float, Float__of_int)
RESET_VALUE(float_of_int, Float__of_int)
RESET_VALUE(truncate, Int__of_float)
RESET_VALUE(int_of_float, Int__of_float)
RESET_VALUE(infinity, Float__infinity)
RESET_VALUE(neg_infinity, Float__negative_infinity)
RESET_VALUE(nan, Float__not_a_number)
RESET_VALUE(max_float, Float__smallest)
RESET_VALUE(min_float, Float__greatest)
RESET_VALUE(epsilon_float, Float__epsilon)
RESET_TYPE(fpclass, Float__Class__t)
RESET_VALUE(classify_float, Float__Class__of_float)

(* String operations *)
RESET_VALUE((^), String__concat)

(* Character operations *)
RESET_VALUE(int_of_char, Char__of_int)
RESET_VALUE(char_of_int, Char__to_int)

(* Unit operations *)
RESET_VALUE(ignore, Unit__ignore)

(* String conversion functions *)
RESET_VALUE(string_of_bool, Bool__to_string)
RESET_VALUE(bool_of_string, Bool__of_string)
#ifdef HAS_Pervasives_bool_of_string_opt
RESET_VALUE(bool_of_string_opt, Bool__try_of_string)
#endif
RESET_VALUE(string_of_int, Int__to_string)
RESET_VALUE(int_of_string, Int__of_string)
#ifdef HAS_Pervasives_int_of_string_opt
RESET_VALUE(int_of_string_opt, Int__try_of_string)
#endif
RESET_VALUE(string_of_float, Float__of_string)
RESET_VALUE(float_of_string, Float__to_string)
#ifdef HAS_Pervasives_float_of_string_opt
RESET_VALUE(float_of_string_opt, Float__try_of_string)
#endif

(* Pair operations *)
RESET_VALUE(fst, Tuple2__get_0)
RESET_VALUE(snd, Tuple2__get_1)

(* List operations *)
RESET_VALUE((@), List__concat)

(* Input/output *)
RESET_TYPE(in_channel, InChannel__t)
RESET_TYPE(out_channel, OutChannel__t)
RESET_VALUE(stdin, StdIn__channel)
RESET_VALUE(stdout, StdOut__channel)
RESET_VALUE(stderr, StdErr__channel)

(* Output functions on standard output *)
RESET_VALUE(print_char, StdOut__print)
RESET_VALUE(print_string, StdOut__print)
RESET_VALUE(print_bytes, StdOut__print)
RESET_VALUE(print_int, StdOut__print)
RESET_VALUE(print_float, StdOut__print)
RESET_VALUE(print_endline, StdOut__print)
RESET_VALUE(print_newline, StdOut__print)

(* Output functions on standard error *)
RESET_VALUE(prerr_char, StdErr__print)
RESET_VALUE(prerr_string, StdErr__print)
RESET_VALUE(prerr_bytes, StdErr__print)
RESET_VALUE(prerr_int, StdErr__print)
RESET_VALUE(prerr_float, StdErr__print)
RESET_VALUE(prerr_endline, StdErr__print)
RESET_VALUE(prerr_newline, StdErr__print)

(* Input functions on standard input *)
RESET_VALUE(read_line, todo)
RESET_VALUE(read_int, todo)
(* @todo Remove "ifdef" in this module: put everything in our Pervasives even if it's not in OCamlStandard.Pervasives *)
#ifdef HAS_Pervasives_read_int_opt
RESET_VALUE(read_int_opt, todo)
#endif
RESET_VALUE(read_float, todo)
#ifdef HAS_Pervasives_read_float_opt
RESET_VALUE(read_float_opt, todo)
#endif

(* General output functions *)
RESET_TYPE(open_flag, todo)
RESET_VALUE(open_out, OutFile__with_file)
RESET_VALUE(open_out_bin, OutFile__with_file)
RESET_VALUE(open_out_gen, OutFile__with_file)
RESET_VALUE(flush, OutChannel__flush)
RESET_VALUE(flush_all, todo)
RESET_VALUE(output_char, OutChannel__print)
RESET_VALUE(output_string, OutChannel__print)
RESET_VALUE(output_bytes, OutChannel__output)
RESET_VALUE(output, OutChannel__output)
RESET_VALUE(output_substring, OutChannel__output)
RESET_VALUE(output_byte, OutChannel__output)
RESET_VALUE(output_binary_int, OutChannel__output)
RESET_VALUE(output_value, OutChannel__output)
RESET_VALUE(seek_out, OutFile__seek)
RESET_VALUE(pos_out, OutFile__pos)
RESET_VALUE(out_channel_length, OutFile__size)
RESET_VALUE(close_out, OutFile__with_file)
RESET_VALUE(close_out_noerr, todo)
RESET_VALUE(set_binary_mode_out, todo)

(* General input functions *)
RESET_VALUE(open_in, InFile__with_file)
RESET_VALUE(open_in_bin, InFile__with_file)
RESET_VALUE(open_in_gen, InFile__with_file)
RESET_VALUE(input_char, todo)
RESET_VALUE(input_line, todo)
RESET_VALUE(input, todo)
RESET_VALUE(really_input, todo)
RESET_VALUE(really_input_string, todo)
RESET_VALUE(input_byte, todo)
RESET_VALUE(input_binary_int, todo)
RESET_VALUE(input_value, todo)
RESET_VALUE(seek_in, InFile__seek)
RESET_VALUE(pos_in, InFile__pos)
RESET_VALUE(in_channel_length, InFile__size)
RESET_VALUE(close_in, InFile__with_file)
RESET_VALUE(close_in_noerr, todo)
RESET_VALUE(set_binary_mode_in, todo)

(* Operations on large files *)
RESET_MODULE(LargeFile)
  RESET_VALUE(seek_out, OutFile__seek)
  RESET_VALUE(pos_out, OutFile__pos)
  RESET_VALUE(out_channel_length, OutFile__size)
  RESET_VALUE(seek_in, InFile__seek)
  RESET_VALUE(pos_in, InFile__pos)
  RESET_VALUE(in_channel_length, InFile__size)
end

(* References *)
RESET_TYPE('a ref, Reference__t)
RESET_VALUE(ref, Reference__of_contents)
RESET_VALUE((!), Reference__contents)
RESET_VALUE((:=), Reference__assign)
RESET_VALUE(incr, IntReference__increment)
RESET_VALUE(decr, IntReference__decrement)

(* Result type *)
#ifdef HAS_Pervasives_result
RESET_TYPE(('a, 'b) result, todo)
#endif

(* Operations on format strings *)
RESET_TYPE(('a, 'b, 'c, 'd, 'e, 'f) format6, Format__t)
RESET_TYPE(('a, 'b, 'c, 'd) format4, Format__t)
RESET_TYPE(('a, 'b, 'c) format, Format__t)
RESET_VALUE(string_of_format, Format__to_string)
RESET_VALUE(format_of_string, Format__of_string)
RESET_VALUE((^^), Format__concat)

(* Program termination *)
RESET_VALUE(exit, Exit__exit)
RESET_VALUE(at_exit, Exit__at_exit)

(* The following is for system use only. Do not call directly. *)
RESET_VALUE(valid_float_lexem, Standard__OCamlStandard__Pervasives__valid_float_lexem)
RESET_VALUE(unsafe_really_input, Standard__OCamlStandard__Pervasives__unsafe_really_input)
RESET_VALUE(do_at_exit, Standard__OCamlStandard__Pervasives__do_at_exit)
