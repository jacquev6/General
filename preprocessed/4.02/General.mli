# 1 "General.cppo.mli"
(* Basics *)

(** Some doc for :mod:`General` *)

module Reset: sig













  
# 9 "General.cppo.mli"
  module ResetPervasives: sig
# 1 "Reset/ResetPervasives.ml"
(* Exceptions *)
# 2 "Reset/ResetPervasives.ml"
 val raise: [` Please_use_General__Exception__raise ] 
# 3 "Reset/ResetPervasives.ml"
 val raise_notrace: [` Please_use_General__Exception__raise_without_backtrace ] 
# 4 "Reset/ResetPervasives.ml"
 val invalid_arg: [` Please_use_General__Exception__invalid_argument ] 
# 5 "Reset/ResetPervasives.ml"
 val failwith: [` Please_use_General__Exception__failure ] 
# 6 "Reset/ResetPervasives.ml"
(* exception Exit *)

(* Comparisons *)
# 9 "Reset/ResetPervasives.ml"
 val (=): [` Please_use_General__Equate__Poly__equal ] 
# 10 "Reset/ResetPervasives.ml"
 val (<>): [` Please_use_General__Equate__Poly__different ] 
# 11 "Reset/ResetPervasives.ml"
 val (<): [` Please_use_General__Compare__Poly__less_than ] 
# 12 "Reset/ResetPervasives.ml"
 val (>): [` Please_use_General__Compare__Poly__greater_than ] 
# 13 "Reset/ResetPervasives.ml"
 val (<=): [` Please_use_General__Compare__Poly__less_or_equal ] 
# 14 "Reset/ResetPervasives.ml"
 val (>=): [` Please_use_General__Compare__Poly__greater_or_equal ] 
# 15 "Reset/ResetPervasives.ml"
 val compare: [` Please_use_General__Compare__Poly__compare ] 
# 16 "Reset/ResetPervasives.ml"
 val min: [` Please_use_General__Compare__Poly__min ] 
# 17 "Reset/ResetPervasives.ml"
 val max: [` Please_use_General__Compare__Poly__max ] 
# 18 "Reset/ResetPervasives.ml"
 val (==): [` Please_use_General__Equate__Phys__equal ] 
# 19 "Reset/ResetPervasives.ml"
 val (!=): [` Please_use_General__Equate__Phys__different ] 

# 21 "Reset/ResetPervasives.ml"
(* Boolean operations *)
# 22 "Reset/ResetPervasives.ml"
 val not: [` Please_use_General__Bool__not ] 
# 23 "Reset/ResetPervasives.ml"
 val (&&): [` Please_use_General__Bool__and_ ] 
# 24 "Reset/ResetPervasives.ml"
 val (||): [` Please_use_General__Bool__or_ ] 
# 25 "Reset/ResetPervasives.ml"
[@@@ocaml.warning "-3"]
# 26 "Reset/ResetPervasives.ml"
 val (&): [` Please_use_General__Bool__and_ ] 
# 27 "Reset/ResetPervasives.ml"
 val (or): [` Please_use_General__Bool__or_ ] 
# 28 "Reset/ResetPervasives.ml"
[@@@ocaml.warning "+3"]

(* Debugging *)
(* Nothing to reset *)

(* Composition operators *)
# 34 "Reset/ResetPervasives.ml"
 val (|>): [` Please_use_General__Function1__rev_apply ] 
# 35 "Reset/ResetPervasives.ml"
 val (@@): [` Please_use_General__Function1__apply ] 

# 37 "Reset/ResetPervasives.ml"
(* Integer arithmetics *)
# 38 "Reset/ResetPervasives.ml"
 val (~-): [` Please_use_General__Int__negate ] 
# 39 "Reset/ResetPervasives.ml"
 val (~+): [` Please_use_General__Function1__identity ] 
# 40 "Reset/ResetPervasives.ml"
 val succ: [` Please_use_General__Int__succ ] 
# 41 "Reset/ResetPervasives.ml"
 val pred: [` Please_use_General__Int__pred ] 
# 42 "Reset/ResetPervasives.ml"
 val (+): [` Please_use_General__Int__add ] 
# 43 "Reset/ResetPervasives.ml"
 val (-): [` Please_use_General__Int__substract ] 
# 44 "Reset/ResetPervasives.ml"
 val ( * ): [` Please_use_General__Int__multiply ] 
# 45 "Reset/ResetPervasives.ml"
 val (/): [` Please_use_General__Int__divide ] 
# 46 "Reset/ResetPervasives.ml"
 val (mod): [` Please_use_General__Int__modulo ] 
# 47 "Reset/ResetPervasives.ml"
 val abs: [` Please_use_General__Int__abs ] 
# 48 "Reset/ResetPervasives.ml"
 val max_int: [` Please_use_General__Int__greatest ] 
# 49 "Reset/ResetPervasives.ml"
 val min_int: [` Please_use_General__Int__smallest ] 

# 51 "Reset/ResetPervasives.ml"
(* Bitwise operations *)
# 52 "Reset/ResetPervasives.ml"
 val (land): [` Please_use_General__Int__Bitwise__logical_and ] 
# 53 "Reset/ResetPervasives.ml"
 val (lor): [` Please_use_General__Int__Bitwise__logical_or ] 
# 54 "Reset/ResetPervasives.ml"
 val (lxor): [` Please_use_General__Int__Bitwise__logical_xor ] 
# 55 "Reset/ResetPervasives.ml"
 val lnot: [` Please_use_General__Int__Bitwise__logical_not ] 
# 56 "Reset/ResetPervasives.ml"
 val (lsl): [` Please_use_General__Int__Bitwise__logical_shift_left ] 
# 57 "Reset/ResetPervasives.ml"
 val (lsr): [` Please_use_General__Int__Bitwise__logical_shift_right ] 
# 58 "Reset/ResetPervasives.ml"
 val (asr): [` Please_use_General__Int__Bitwise__arithmetic_shift_right ] 

# 60 "Reset/ResetPervasives.ml"
(* Floating-point arithmetic *)
# 61 "Reset/ResetPervasives.ml"
 val (~-.): [` Please_use_General__Float__negate ] 
# 62 "Reset/ResetPervasives.ml"
 val (~+.): [` Please_use_General__Function1__identity ] 
# 63 "Reset/ResetPervasives.ml"
 val (+.): [` Please_use_General__Float__add ] 
# 64 "Reset/ResetPervasives.ml"
 val (-.): [` Please_use_General__Float__substract ] 
# 65 "Reset/ResetPervasives.ml"
 val ( *. ): [` Please_use_General__Float__multiply ] 
# 66 "Reset/ResetPervasives.ml"
 val (/.): [` Please_use_General__Float__divide ] 
# 67 "Reset/ResetPervasives.ml"
 val ( ** ): [` Please_use_General__Float__exponentiate ] 
# 68 "Reset/ResetPervasives.ml"
 val sqrt: [` Please_use_General__Float__sqrt ] 
# 69 "Reset/ResetPervasives.ml"
 val exp: [` Please_use_General__Float__exp ] 
# 70 "Reset/ResetPervasives.ml"
 val log: [` Please_use_General__Float__log ] 
# 71 "Reset/ResetPervasives.ml"
 val log10: [` Please_use_General__Float__log10 ] 
# 72 "Reset/ResetPervasives.ml"
 val expm1: [` Please_use_General__Float__expm1 ] 
# 73 "Reset/ResetPervasives.ml"
 val log1p: [` Please_use_General__Float__log1p ] 
# 74 "Reset/ResetPervasives.ml"
 val cos: [` Please_use_General__Float__cos ] 
# 75 "Reset/ResetPervasives.ml"
 val sin: [` Please_use_General__Float__sin ] 
# 76 "Reset/ResetPervasives.ml"
 val tan: [` Please_use_General__Float__tan ] 
# 77 "Reset/ResetPervasives.ml"
 val acos: [` Please_use_General__Float__acos ] 
# 78 "Reset/ResetPervasives.ml"
 val asin: [` Please_use_General__Float__asin ] 
# 79 "Reset/ResetPervasives.ml"
 val atan: [` Please_use_General__Float__atan ] 
# 80 "Reset/ResetPervasives.ml"
 val atan2: [` Please_use_General__Float__atan2 ] 
# 81 "Reset/ResetPervasives.ml"
 val hypot: [` Please_use_General__Float__hypot ] 
# 82 "Reset/ResetPervasives.ml"
 val cosh: [` Please_use_General__Float__cosh ] 
# 83 "Reset/ResetPervasives.ml"
 val sinh: [` Please_use_General__Float__sinh ] 
# 84 "Reset/ResetPervasives.ml"
 val tanh: [` Please_use_General__Float__tanh ] 
# 85 "Reset/ResetPervasives.ml"
 val ceil: [` Please_use_General__Float__ceil ] 
# 86 "Reset/ResetPervasives.ml"
 val floor: [` Please_use_General__Float__floor ] 
# 87 "Reset/ResetPervasives.ml"
 val abs_float: [` Please_use_General__Float__abs ] 
# 88 "Reset/ResetPervasives.ml"
 val copysign: [` Please_use_General__Float__copy_sign ] 
# 89 "Reset/ResetPervasives.ml"
 val mod_float: [` Please_use_General__Float__modulo ] 
# 90 "Reset/ResetPervasives.ml"
 val frexp: [` Please_use_General__Float__to_parts ] 
# 91 "Reset/ResetPervasives.ml"
 val ldexp: [` Please_use_General__Float__of_parts ] 
# 92 "Reset/ResetPervasives.ml"
 val modf: [` Please_use_General__Float__to_fractional_and_integral ] 
# 93 "Reset/ResetPervasives.ml"
 val float: [` Please_use_General__Float__of_int ] 
# 94 "Reset/ResetPervasives.ml"
 val float_of_int: [` Please_use_General__Float__of_int ] 
# 95 "Reset/ResetPervasives.ml"
 val truncate: [` Please_use_General__Int__of_float ] 
# 96 "Reset/ResetPervasives.ml"
 val int_of_float: [` Please_use_General__Int__of_float ] 
# 97 "Reset/ResetPervasives.ml"
 val infinity: [` Please_use_General__Float__infinity ] 
# 98 "Reset/ResetPervasives.ml"
 val neg_infinity: [` Please_use_General__Float__negative_infinity ] 
# 99 "Reset/ResetPervasives.ml"
 val nan: [` Please_use_General__Float__not_a_number ] 
# 100 "Reset/ResetPervasives.ml"
 val max_float: [` Please_use_General__Float__smallest ] 
# 101 "Reset/ResetPervasives.ml"
 val min_float: [` Please_use_General__Float__greatest ] 
# 102 "Reset/ResetPervasives.ml"
 val epsilon_float: [` Please_use_General__Float__epsilon ] 
# 103 "Reset/ResetPervasives.ml"
 type fpclass = [` Please_use_General__Float__Class__t ] 
# 104 "Reset/ResetPervasives.ml"
 val classify_float: [` Please_use_General__Float__Class__of_float ] 

# 106 "Reset/ResetPervasives.ml"
(* String operations *)
# 107 "Reset/ResetPervasives.ml"
 val (^): [` Please_use_General__String__concat ] 

# 109 "Reset/ResetPervasives.ml"
(* Character operations *)
# 110 "Reset/ResetPervasives.ml"
 val int_of_char: [` Please_use_General__Char__of_int ] 
# 111 "Reset/ResetPervasives.ml"
 val char_of_int: [` Please_use_General__Char__to_int ] 

# 113 "Reset/ResetPervasives.ml"
(* Unit operations *)
# 114 "Reset/ResetPervasives.ml"
 val ignore: [` Please_use_General__Unit__ignore ] 

# 116 "Reset/ResetPervasives.ml"
(* String conversion functions *)
# 117 "Reset/ResetPervasives.ml"
 val string_of_bool: [` Please_use_General__Bool__to_string ] 
# 118 "Reset/ResetPervasives.ml"
 val bool_of_string: [` Please_use_General__Bool__of_string ] 
# 122 "Reset/ResetPervasives.ml"
 val string_of_int: [` Please_use_General__Int__to_string ] 
# 123 "Reset/ResetPervasives.ml"
 val int_of_string: [` Please_use_General__Int__of_string ] 
# 127 "Reset/ResetPervasives.ml"
 val string_of_float: [` Please_use_General__Float__of_string ] 
# 128 "Reset/ResetPervasives.ml"
 val float_of_string: [` Please_use_General__Float__to_string ] 

# 133 "Reset/ResetPervasives.ml"
(* Pair operations *)
# 134 "Reset/ResetPervasives.ml"
 val fst: [` Please_use_General__Tuple2__get_0 ] 
# 135 "Reset/ResetPervasives.ml"
 val snd: [` Please_use_General__Tuple2__get_1 ] 

# 137 "Reset/ResetPervasives.ml"
(* List operations *)
# 138 "Reset/ResetPervasives.ml"
 val (@): [` Please_use_General__List__concat ] 

# 140 "Reset/ResetPervasives.ml"
(* Input/output *)
# 141 "Reset/ResetPervasives.ml"
 type in_channel = [` Please_use_General__InChannel__t ] 
# 142 "Reset/ResetPervasives.ml"
 type out_channel = [` Please_use_General__OutChannel__t ] 
# 143 "Reset/ResetPervasives.ml"
 val stdin: [` Please_use_General__StdIn__channel ] 
# 144 "Reset/ResetPervasives.ml"
 val stdout: [` Please_use_General__StdOut__channel ] 
# 145 "Reset/ResetPervasives.ml"
 val stderr: [` Please_use_General__StdErr__channel ] 

# 147 "Reset/ResetPervasives.ml"
(* Output functions on standard output *)
# 148 "Reset/ResetPervasives.ml"
 val print_char: [` Please_use_General__StdOut__print ] 
# 149 "Reset/ResetPervasives.ml"
 val print_string: [` Please_use_General__StdOut__print ] 
# 150 "Reset/ResetPervasives.ml"
 val print_bytes: [` Please_use_General__StdOut__print ] 
# 151 "Reset/ResetPervasives.ml"
 val print_int: [` Please_use_General__StdOut__print ] 
# 152 "Reset/ResetPervasives.ml"
 val print_float: [` Please_use_General__StdOut__print ] 
# 153 "Reset/ResetPervasives.ml"
 val print_endline: [` Please_use_General__StdOut__print ] 
# 154 "Reset/ResetPervasives.ml"
 val print_newline: [` Please_use_General__StdOut__print ] 

# 156 "Reset/ResetPervasives.ml"
(* Output functions on standard error *)
# 157 "Reset/ResetPervasives.ml"
 val prerr_char: [` Please_use_General__StdErr__print ] 
# 158 "Reset/ResetPervasives.ml"
 val prerr_string: [` Please_use_General__StdErr__print ] 
# 159 "Reset/ResetPervasives.ml"
 val prerr_bytes: [` Please_use_General__StdErr__print ] 
# 160 "Reset/ResetPervasives.ml"
 val prerr_int: [` Please_use_General__StdErr__print ] 
# 161 "Reset/ResetPervasives.ml"
 val prerr_float: [` Please_use_General__StdErr__print ] 
# 162 "Reset/ResetPervasives.ml"
 val prerr_endline: [` Please_use_General__StdErr__print ] 
# 163 "Reset/ResetPervasives.ml"
 val prerr_newline: [` Please_use_General__StdErr__print ] 

# 165 "Reset/ResetPervasives.ml"
(* Input functions on standard input *)
# 166 "Reset/ResetPervasives.ml"
 val read_line: [` Please_use_General__todo ] 
# 167 "Reset/ResetPervasives.ml"
 val read_int: [` Please_use_General__todo ] 
# 168 "Reset/ResetPervasives.ml"
(* @todo Remove "ifdef" in this module: put everything in our Pervasives even if it's not in OCamlStandard.Pervasives *)
# 172 "Reset/ResetPervasives.ml"
 val read_float: [` Please_use_General__todo ] 

# 177 "Reset/ResetPervasives.ml"
(* General output functions *)
# 178 "Reset/ResetPervasives.ml"
 type open_flag = [` Please_use_General__todo ] 
# 179 "Reset/ResetPervasives.ml"
 val open_out: [` Please_use_General__OutFile__with_file ] 
# 180 "Reset/ResetPervasives.ml"
 val open_out_bin: [` Please_use_General__OutFile__with_file ] 
# 181 "Reset/ResetPervasives.ml"
 val open_out_gen: [` Please_use_General__OutFile__with_file ] 
# 182 "Reset/ResetPervasives.ml"
 val flush: [` Please_use_General__OutChannel__flush ] 
# 183 "Reset/ResetPervasives.ml"
 val flush_all: [` Please_use_General__todo ] 
# 184 "Reset/ResetPervasives.ml"
 val output_char: [` Please_use_General__OutChannel__print ] 
# 185 "Reset/ResetPervasives.ml"
 val output_string: [` Please_use_General__OutChannel__print ] 
# 186 "Reset/ResetPervasives.ml"
 val output_bytes: [` Please_use_General__OutChannel__output ] 
# 187 "Reset/ResetPervasives.ml"
 val output: [` Please_use_General__OutChannel__output ] 
# 188 "Reset/ResetPervasives.ml"
 val output_substring: [` Please_use_General__OutChannel__output ] 
# 189 "Reset/ResetPervasives.ml"
 val output_byte: [` Please_use_General__OutChannel__output ] 
# 190 "Reset/ResetPervasives.ml"
 val output_binary_int: [` Please_use_General__OutChannel__output ] 
# 191 "Reset/ResetPervasives.ml"
 val output_value: [` Please_use_General__OutChannel__output ] 
# 192 "Reset/ResetPervasives.ml"
 val seek_out: [` Please_use_General__OutFile__seek ] 
# 193 "Reset/ResetPervasives.ml"
 val pos_out: [` Please_use_General__OutFile__pos ] 
# 194 "Reset/ResetPervasives.ml"
 val out_channel_length: [` Please_use_General__OutFile__size ] 
# 195 "Reset/ResetPervasives.ml"
 val close_out: [` Please_use_General__OutFile__with_file ] 
# 196 "Reset/ResetPervasives.ml"
 val close_out_noerr: [` Please_use_General__todo ] 
# 197 "Reset/ResetPervasives.ml"
 val set_binary_mode_out: [` Please_use_General__todo ] 

# 199 "Reset/ResetPervasives.ml"
(* General input functions *)
# 200 "Reset/ResetPervasives.ml"
 val open_in: [` Please_use_General__InFile__with_file ] 
# 201 "Reset/ResetPervasives.ml"
 val open_in_bin: [` Please_use_General__InFile__with_file ] 
# 202 "Reset/ResetPervasives.ml"
 val open_in_gen: [` Please_use_General__InFile__with_file ] 
# 203 "Reset/ResetPervasives.ml"
 val input_char: [` Please_use_General__todo ] 
# 204 "Reset/ResetPervasives.ml"
 val input_line: [` Please_use_General__todo ] 
# 205 "Reset/ResetPervasives.ml"
 val input: [` Please_use_General__todo ] 
# 206 "Reset/ResetPervasives.ml"
 val really_input: [` Please_use_General__todo ] 
# 207 "Reset/ResetPervasives.ml"
 val really_input_string: [` Please_use_General__todo ] 
# 208 "Reset/ResetPervasives.ml"
 val input_byte: [` Please_use_General__todo ] 
# 209 "Reset/ResetPervasives.ml"
 val input_binary_int: [` Please_use_General__todo ] 
# 210 "Reset/ResetPervasives.ml"
 val input_value: [` Please_use_General__todo ] 
# 211 "Reset/ResetPervasives.ml"
 val seek_in: [` Please_use_General__InFile__seek ] 
# 212 "Reset/ResetPervasives.ml"
 val pos_in: [` Please_use_General__InFile__pos ] 
# 213 "Reset/ResetPervasives.ml"
 val in_channel_length: [` Please_use_General__InFile__size ] 
# 214 "Reset/ResetPervasives.ml"
 val close_in: [` Please_use_General__InFile__with_file ] 
# 215 "Reset/ResetPervasives.ml"
 val close_in_noerr: [` Please_use_General__todo ] 
# 216 "Reset/ResetPervasives.ml"
 val set_binary_mode_in: [` Please_use_General__todo ] 

# 218 "Reset/ResetPervasives.ml"
(* Operations on large files *)
# 219 "Reset/ResetPervasives.ml"
 module LargeFile: sig 
  
# 220 "Reset/ResetPervasives.ml"
   val seek_out: [` Please_use_General__OutFile__seek ] 
  
# 221 "Reset/ResetPervasives.ml"
   val pos_out: [` Please_use_General__OutFile__pos ] 
  
# 222 "Reset/ResetPervasives.ml"
   val out_channel_length: [` Please_use_General__OutFile__size ] 
  
# 223 "Reset/ResetPervasives.ml"
   val seek_in: [` Please_use_General__InFile__seek ] 
  
# 224 "Reset/ResetPervasives.ml"
   val pos_in: [` Please_use_General__InFile__pos ] 
  
# 225 "Reset/ResetPervasives.ml"
   val in_channel_length: [` Please_use_General__InFile__size ] 
# 226 "Reset/ResetPervasives.ml"
end

(* References *)
# 229 "Reset/ResetPervasives.ml"
 type 'a ref = [` Please_use_General__Reference__t ] 
# 230 "Reset/ResetPervasives.ml"
 val ref: [` Please_use_General__Reference__of_contents ] 
# 231 "Reset/ResetPervasives.ml"
 val (!): [` Please_use_General__Reference__contents ] 
# 232 "Reset/ResetPervasives.ml"
 val (:=): [` Please_use_General__Reference__assign ] 
# 233 "Reset/ResetPervasives.ml"
 val incr: [` Please_use_General__IntReference__increment ] 
# 234 "Reset/ResetPervasives.ml"
 val decr: [` Please_use_General__IntReference__decrement ] 

# 236 "Reset/ResetPervasives.ml"
(* Result type *)

# 241 "Reset/ResetPervasives.ml"
(* Operations on format strings *)
# 242 "Reset/ResetPervasives.ml"
 type ('a, 'b, 'c, 'd, 'e, 'f) format6 = [` Please_use_General__Format__t ] 
# 243 "Reset/ResetPervasives.ml"
 type ('a, 'b, 'c, 'd) format4 = [` Please_use_General__Format__t ] 
# 244 "Reset/ResetPervasives.ml"
 type ('a, 'b, 'c) format = [` Please_use_General__Format__t ] 
# 245 "Reset/ResetPervasives.ml"
 val string_of_format: [` Please_use_General__Format__to_string ] 
# 246 "Reset/ResetPervasives.ml"
 val format_of_string: [` Please_use_General__Format__of_string ] 
# 247 "Reset/ResetPervasives.ml"
 val (^^): [` Please_use_General__Format__concat ] 

# 249 "Reset/ResetPervasives.ml"
(* Program termination *)
# 250 "Reset/ResetPervasives.ml"
 val exit: [` Please_use_General__Exit__exit ] 
# 251 "Reset/ResetPervasives.ml"
 val at_exit: [` Please_use_General__Exit__at_exit ] 

# 253 "Reset/ResetPervasives.ml"
(* The following is for system use only. Do not call directly. *)
# 254 "Reset/ResetPervasives.ml"
 val valid_float_lexem: [` Please_use_General__Standard__OCamlStandard__Pervasives__valid_float_lexem ] 
# 255 "Reset/ResetPervasives.ml"
 val unsafe_really_input: [` Please_use_General__Standard__OCamlStandard__Pervasives__unsafe_really_input ] 
# 256 "Reset/ResetPervasives.ml"
 val do_at_exit: [` Please_use_General__Standard__OCamlStandard__Pervasives__do_at_exit ] 
  
# 11 "General.cppo.mli"
  end

  module ResetStandardLibrary: sig
# 1 "Reset/ResetStandardLibrary.ml"
 module OCamlStandard: sig 
  
# 2 "Reset/ResetStandardLibrary.ml"
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/core.html *)
  
# 6 "Reset/ResetStandardLibrary.ml"
   module Pervasives = Pervasives 

  
# 9 "Reset/ResetStandardLibrary.ml"
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/stdlib.html *)
  
# 10 "Reset/ResetStandardLibrary.ml"
   module Arg = Arg 
  
# 11 "Reset/ResetStandardLibrary.ml"
   module Array = Array 
  
# 12 "Reset/ResetStandardLibrary.ml"
   module ArrayLabels = ArrayLabels 
  
# 16 "Reset/ResetStandardLibrary.ml"
   module Buffer = Buffer 
  
# 17 "Reset/ResetStandardLibrary.ml"
   module Bytes = Bytes 
  
# 18 "Reset/ResetStandardLibrary.ml"
   module BytesLabels = BytesLabels 
  
# 19 "Reset/ResetStandardLibrary.ml"
   module Callback = Callback 
  
# 20 "Reset/ResetStandardLibrary.ml"
   module Char = Char 
  
# 21 "Reset/ResetStandardLibrary.ml"
   module Complex = Complex 
  
# 22 "Reset/ResetStandardLibrary.ml"
   module Digest = Digest 
  
# 26 "Reset/ResetStandardLibrary.ml"
   module Filename = Filename 
  
# 30 "Reset/ResetStandardLibrary.ml"
   module Format = Format 
  
# 31 "Reset/ResetStandardLibrary.ml"
   module Gc = Gc 
  
# 32 "Reset/ResetStandardLibrary.ml"
   module Genlex = Genlex 
  
# 33 "Reset/ResetStandardLibrary.ml"
   module Hashtbl = Hashtbl 
  
# 34 "Reset/ResetStandardLibrary.ml"
   module Int32 = Int32 
  
# 35 "Reset/ResetStandardLibrary.ml"
   module Int64 = Int64 
  
# 36 "Reset/ResetStandardLibrary.ml"
   module Lazy = Lazy 
  
# 37 "Reset/ResetStandardLibrary.ml"
   module Lexing = Lexing 
  
# 38 "Reset/ResetStandardLibrary.ml"
   module List = List 
  
# 39 "Reset/ResetStandardLibrary.ml"
   module ListLabels = ListLabels 
  
# 40 "Reset/ResetStandardLibrary.ml"
   module Map = Map 
  
# 41 "Reset/ResetStandardLibrary.ml"
   module Marshal = Marshal 
  
# 42 "Reset/ResetStandardLibrary.ml"
   module MoreLabels = MoreLabels 
  
# 43 "Reset/ResetStandardLibrary.ml"
   module Nativeint = Nativeint 
  
# 44 "Reset/ResetStandardLibrary.ml"
   module Oo = Oo 
  
# 45 "Reset/ResetStandardLibrary.ml"
   module Parsing = Parsing 
  
# 46 "Reset/ResetStandardLibrary.ml"
   module Printexc = Printexc 
  
# 47 "Reset/ResetStandardLibrary.ml"
   module Printf = Printf 
  
# 48 "Reset/ResetStandardLibrary.ml"
   module Queue = Queue 
  
# 49 "Reset/ResetStandardLibrary.ml"
   module Random = Random 
  
# 50 "Reset/ResetStandardLibrary.ml"
   module Scanf = Scanf 
  
# 54 "Reset/ResetStandardLibrary.ml"
   module Set = Set 
  
# 56 "Reset/ResetStandardLibrary.ml"
   module Sort = Sort 
  
# 61 "Reset/ResetStandardLibrary.ml"
   module Stack = Stack 
  
# 62 "Reset/ResetStandardLibrary.ml"
   module StdLabels = StdLabels 
  
# 63 "Reset/ResetStandardLibrary.ml"
   module Stream = Stream 
  
# 64 "Reset/ResetStandardLibrary.ml"
   module String = String 
  
# 65 "Reset/ResetStandardLibrary.ml"
   module StringLabels = StringLabels 
  
# 66 "Reset/ResetStandardLibrary.ml"
   module Sys = Sys 
  
# 70 "Reset/ResetStandardLibrary.ml"
   module Weak = Weak 

  
# 72 "Reset/ResetStandardLibrary.ml"
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/parsing.html *)

  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libunix.html *)

  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libnum.html *)
  
# 77 "Reset/ResetStandardLibrary.ml"
   module Num = Num 
  
# 78 "Reset/ResetStandardLibrary.ml"
   module Big_int = Big_int 
  
# 79 "Reset/ResetStandardLibrary.ml"
   module Arith_status = Arith_status 

  
# 81 "Reset/ResetStandardLibrary.ml"
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libstr.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libthreads.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libgraph.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libdynlink.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libbigarray.html *)
end

# 88 "Reset/ResetStandardLibrary.ml"
 module Pervasives: sig end 

# 90 "Reset/ResetStandardLibrary.ml"
 module Arg: sig end 
# 91 "Reset/ResetStandardLibrary.ml"
 module Array: sig 
  
# 92 "Reset/ResetStandardLibrary.ml"
   val get:  'a array -> int -> 'a 
  
# 93 "Reset/ResetStandardLibrary.ml"
   val set:  'a array -> int -> 'a -> unit 
# 94 "Reset/ResetStandardLibrary.ml"
end
# 95 "Reset/ResetStandardLibrary.ml"
 module ArrayLabels: sig end 
# 99 "Reset/ResetStandardLibrary.ml"
 module Buffer: sig end 
# 100 "Reset/ResetStandardLibrary.ml"
 module Bytes: sig end 
# 101 "Reset/ResetStandardLibrary.ml"
 module BytesLabels: sig end 
# 102 "Reset/ResetStandardLibrary.ml"
 module Callback: sig end 
# 103 "Reset/ResetStandardLibrary.ml"
 module Char: sig end 
# 104 "Reset/ResetStandardLibrary.ml"
 module Complex: sig end 
# 105 "Reset/ResetStandardLibrary.ml"
 module Digest: sig end 
# 109 "Reset/ResetStandardLibrary.ml"
 module Filename: sig end 
# 113 "Reset/ResetStandardLibrary.ml"
 module Format: sig end 
# 114 "Reset/ResetStandardLibrary.ml"
 module Gc: sig end 
# 115 "Reset/ResetStandardLibrary.ml"
 module Genlex: sig end 
# 116 "Reset/ResetStandardLibrary.ml"
 module Hashtbl: sig end 
# 117 "Reset/ResetStandardLibrary.ml"
 module Int32: sig end 
# 118 "Reset/ResetStandardLibrary.ml"
 module Int64: sig end 
# 119 "Reset/ResetStandardLibrary.ml"
 module Lazy: sig end 
# 120 "Reset/ResetStandardLibrary.ml"
 module Lexing: sig end 
# 121 "Reset/ResetStandardLibrary.ml"
 module List: sig end 
# 122 "Reset/ResetStandardLibrary.ml"
 module ListLabels: sig end 
# 123 "Reset/ResetStandardLibrary.ml"
 module Map: sig end 
# 124 "Reset/ResetStandardLibrary.ml"
 module Marshal: sig end 
# 125 "Reset/ResetStandardLibrary.ml"
 module MoreLabels: sig end 
# 126 "Reset/ResetStandardLibrary.ml"
 module Nativeint: sig end 
# 127 "Reset/ResetStandardLibrary.ml"
 module Oo: sig end 
# 128 "Reset/ResetStandardLibrary.ml"
 module Parsing: sig end 
# 129 "Reset/ResetStandardLibrary.ml"
 module Printexc: sig end 
# 130 "Reset/ResetStandardLibrary.ml"
 module Printf: sig end 
# 131 "Reset/ResetStandardLibrary.ml"
 module Queue: sig end 
# 132 "Reset/ResetStandardLibrary.ml"
 module Random: sig end 
# 133 "Reset/ResetStandardLibrary.ml"
 module Scanf: sig end 
# 137 "Reset/ResetStandardLibrary.ml"
 module Set: sig end 
# 138 "Reset/ResetStandardLibrary.ml"
 module Sort: sig end 
# 142 "Reset/ResetStandardLibrary.ml"
 module Stack: sig end 
# 143 "Reset/ResetStandardLibrary.ml"
 module StdLabels: sig end 
# 144 "Reset/ResetStandardLibrary.ml"
 module Stream: sig end 
# 145 "Reset/ResetStandardLibrary.ml"
 module String: sig 
  
# 146 "Reset/ResetStandardLibrary.ml"
   val get:  string -> int -> char 
  
# 147 "Reset/ResetStandardLibrary.ml"
   val set:  bytes -> int -> char -> unit 
# 148 "Reset/ResetStandardLibrary.ml"
end
# 149 "Reset/ResetStandardLibrary.ml"
 module StringLabels: sig end 
# 150 "Reset/ResetStandardLibrary.ml"
 module Sys: sig end 
# 154 "Reset/ResetStandardLibrary.ml"
 module Weak: sig end 

# 156 "Reset/ResetStandardLibrary.ml"
 module Num: sig end 
# 157 "Reset/ResetStandardLibrary.ml"
 module Big_int: sig end 
# 158 "Reset/ResetStandardLibrary.ml"
 module Arith_status: sig end 
  
# 15 "General.cppo.mli"
  end

# 18 "General.cppo.mli"
end [@@autodoc.hide]

(** Some doc for :mod:`General.Pervasives` *)
module Pervasives: sig
  include module type of Reset.ResetPervasives [@@autodoc.hide]
  include module type of Reset.ResetStandardLibrary [@@autodoc.hide]

  (** This module overrides all elements from the standard
  `pervasives <https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html>`_
  with unusable but guiding values like:

  .. val:: raise
    :noindex:
    :type: [ `Please_use_General__Exception__raise ]

    The types of these values point at what replaces them in :mod:`General`.
    (In that case, :val:`General.Exception.raise`).

  It then brings back a small set of ubiquitous values: *)

  (** **Boolean operators** *)

  (** Negation. Alias of :val:`General.Bool.O.not`. *)
  val not: bool -> bool

  (** Conjunction. Lazy. Alias of :val:`General.Bool.O.(&&)` *)
  val (&&): bool -> bool -> bool

  (** Disjunction. Lazy. Alias of :val:`General.Bool.O.(||)` *)
  val (||): bool -> bool -> bool

  (** **Integer operators** *)

  val (~-): int -> int
  val (~+): int -> int
  val (+): int -> int -> int
  val (-): int -> int -> int
  val ( * ): int -> int -> int
  val (/): int -> int -> int
  val (mod): int -> int -> int

  (** **Floating point operators** *)

  val (~-.): float -> float
  val (~+.): float -> float
  val (+.): float -> float -> float
  val (-.): float -> float -> float
  val ( *. ): float -> float -> float
  val (/.): float -> float -> float
  val ( ** ): float -> float -> float

  (** **Function composition and application** *)

  val (@@): ('a -> 'b) -> 'a -> 'b
  val (|>): 'a -> ('a -> 'b) -> 'b
  val (%): ('a -> 'b) -> ('c -> 'a) -> ('c -> 'b)

  (** **References** *)

  val ref: 'a -> 'a OCamlStandard.Pervasives.ref
  val (:=): 'a OCamlStandard.Pervasives.ref -> 'a -> unit
  val (!): 'a OCamlStandard.Pervasives.ref -> 'a

  (** **Polymorphic comparison** *)

  val (=): 'a -> 'a -> bool
  val (<>): 'a -> 'a -> bool

  val (<): 'a -> 'a -> bool
  val (<=): 'a -> 'a -> bool
  val (>=): 'a -> 'a -> bool
  val (>): 'a -> 'a -> bool

  (** **Ubiquitous functions** *)

  val ignore: 'a -> unit

  val identity: 'a -> 'a

  (** **Miscelaneous operators** *)

  val (@): 'a list -> 'a list -> 'a list

  val (^): string -> string -> string
end

module Shorten: sig
  (** Return type for functions used in short-circuit iterations over collections.
  (i.e: :val:`General.Traits.Foldable.Short.S0:fold_short`) *)
  type t =
    | GoOn (** Used to indicate iteration should proceed to next item *)
    | ShortCircuit (** Used to indicate iteration should stop after this item *)
end

module Compare: sig
  type t = LT | EQ | GT

  module Poly: sig
    val compare: 'a -> 'a -> t

    val less_than: 'a -> 'a -> bool
    val less_or_equal: 'a -> 'a -> bool
    val greater_than: 'a -> 'a -> bool
    val greater_or_equal: 'a -> 'a -> bool

    val between: 'a -> low:'a -> high:'a -> bool
    val between_or_equal: 'a -> low:'a -> high:'a -> bool

    val min: 'a -> 'a -> 'a
    val max: 'a -> 'a -> 'a
    val min_max: 'a -> 'a -> 'a * 'a

    module O: sig
      val (<): 'a -> 'a -> bool
      val (<=): 'a -> 'a -> bool
      val (>): 'a -> 'a -> bool
      val (>=): 'a -> 'a -> bool
    end
  end

  (* @feature: functors to revert comparison (i.e. "descending order") *)
end

module Equate: sig
  module Poly: sig
    (** Polymorphic structural equality *)
    val equal: 'a -> 'a -> bool

    (** Polymorphic inequality *)
    val different: 'a -> 'a -> bool

    module O: sig
      val (=): 'a -> 'a -> bool
      val (<>): 'a -> 'a -> bool
    end
  end

  module Phys: sig
    (** Physical identity (address equality) *)
    val equal: 'a -> 'a -> bool

    (** Physical inequality *)
    val different: 'a -> 'a -> bool
  end
end

(** Traits are isolated capabilities associated with a type. *)
module Traits: sig
  (* @feature Traits.Hashable with val hash: t -> int, Poly using Hashtbl.hash *)
  (* @feature Traits for head and tail (Headable.Left?), and init and last (Headable.Right?) *)
  (* @feature Publish helper functors (Specialize, Ringoid.Exponentiate.Make, Tests.Make, etc.) *)

  (** A *representation* is a string representing a value for a software developer audience.
  When possible, it should a valid OCaml expression for the value. *)
  module Representable: sig
# 1 "Traits/Representable.signatures.ml"
module type S0 = sig
  type t

  val repr: t
    -> string
end

module type S1 = sig
  type 'a t

  val repr: 'a t
    -> repr_a:('a -> string)
    -> string
end

module type S2 = sig
  type ('a, 'b) t

  val repr: ('a, 'b) t
    -> repr_a:('a -> string)
    -> repr_b:('b -> string)
    -> string
end

module type S3 = sig
  type ('a, 'b, 'c) t

  val repr: ('a, 'b, 'c) t
    -> repr_a:('a -> string)
    -> repr_b:('b -> string)
    -> repr_c:('c -> string)
    -> string
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t

  val repr: ('a, 'b, 'c, 'd) t
    -> repr_a:('a -> string)
    -> repr_b:('b -> string)
    -> repr_c:('c -> string)
    -> repr_d:('d -> string)
    -> string
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t

  val repr: ('a, 'b, 'c, 'd, 'e) t
    -> repr_a:('a -> string)
    -> repr_b:('b -> string)
    -> repr_c:('c -> string)
    -> repr_d:('d -> string)
    -> repr_e:('e -> string)
    -> string
end
  
# 174 "General.cppo.mli"
  end

  module Displayable: sig
# 1 "Traits/Displayable.signatures.ml"
module type S0 = sig
  type t

  val to_string: t -> string
end
  
# 178 "General.cppo.mli"
  end

  module Parsable: sig
# 1 "Traits/Parsable.signatures.ml"
module type S0 = sig
  type t

  val try_of_string: string -> t option
  val of_string: string -> t
end
  
# 182 "General.cppo.mli"
  end

  module Equatable: sig
    module Basic: sig
# 1 "Traits/Equatable.signatures.Basic.ml"
module type S0 = sig
  type t

  val equal: t -> t
    -> bool
end

module type S1 = sig
  type 'a t

  val equal: 'a t -> 'a t
    -> equal_a:('a -> 'a -> bool)
    -> bool
end

module type S2 = sig
  type ('a, 'b) t

  val equal: ('a, 'b) t -> ('a, 'b) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> bool
end

module type S3 = sig
  type ('a, 'b, 'c) t

  val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> equal_c:('c -> 'c -> bool)
    -> bool
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t

  val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> equal_c:('c -> 'c -> bool)
    -> equal_d:('d -> 'd -> bool)
    -> bool
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t

  val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> equal_c:('c -> 'c -> bool)
    -> equal_d:('d -> 'd -> bool)
    -> equal_e:('e -> 'e -> bool)
    -> bool
end
    
# 187 "General.cppo.mli"
    end

    module Operators: sig
# 1 "Traits/Equatable.signatures.Operators.ml"
module type S0 = sig
  type t

  val (=): t -> t
    -> bool
  val (<>): t -> t
    -> bool
end
    
# 191 "General.cppo.mli"
    end

# 1 "Traits/Equatable.signatures.ml"
module type S0 = sig
  include Basic.S0

  val different: t -> t
    -> bool

  module O: Operators.S0 with type t := t
end

module type S1 = sig
  include Basic.S1

  val different: 'a t -> 'a t
    -> equal_a:('a -> 'a -> bool)
    -> bool
end

module type S2 = sig
  include Basic.S2

  val different: ('a, 'b) t -> ('a, 'b) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> bool
end

module type S3 = sig
  include Basic.S3

  val different: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> equal_c:('c -> 'c -> bool)
    -> bool
end

module type S4 = sig
  include Basic.S4

  val different: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> equal_c:('c -> 'c -> bool)
    -> equal_d:('d -> 'd -> bool)
    -> bool
end

module type S5 = sig
  include Basic.S5

  val different: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> equal_a:('a -> 'a -> bool)
    -> equal_b:('b -> 'b -> bool)
    -> equal_c:('c -> 'c -> bool)
    -> equal_d:('d -> 'd -> bool)
    -> equal_e:('e -> 'e -> bool)
    -> bool
end
  
# 194 "General.cppo.mli"
  end

  module Comparable: sig
    module Basic: sig
# 1 "Traits/Comparable.signatures.Basic.ml"
module type S0 = sig
  type t

  val compare: t -> t
    -> Compare.t
end

module type S1 = sig
  type 'a t

  val compare: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> Compare.t
end

module type S2 = sig
  type ('a, 'b) t

  val compare: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> Compare.t
end

module type S3 = sig
  type ('a, 'b, 'c) t

  val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> Compare.t
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t

  val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> Compare.t
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t

  val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> Compare.t
end
    
# 199 "General.cppo.mli"
    end

    module Operators: sig
# 1 "Traits/Comparable.signatures.Operators.ml"
module type S0 = sig
  type t

  val (<): t -> t
    -> bool
  val (<=): t -> t
    -> bool
  val (>): t -> t
    -> bool
  val (>=): t -> t
    -> bool
end
    
# 203 "General.cppo.mli"
    end

# 1 "Traits/Comparable.signatures.ml"
module type S0 = sig
  include Basic.S0

  val less_than: t -> t
    -> bool
  val less_or_equal: t -> t
    -> bool
  val greater_than: t -> t
    -> bool
  val greater_or_equal: t -> t
    -> bool

  val between: t -> low:t -> high:t
    -> bool
  val between_or_equal: t -> low:t -> high:t
    -> bool

  val min: t -> t
    -> t
  val max: t -> t
    -> t
  val min_max: t -> t
    -> t * t

  module O: Operators.S0 with type t := t
end

module type S1 = sig
  include Basic.S1

  val less_than: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val less_or_equal: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val greater_than: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val greater_or_equal: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool

  val between: 'a t -> low:'a t -> high:'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool
  val between_or_equal: 'a t -> low:'a t -> high:'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> bool

  val min: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> 'a t
  val max: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> 'a t
  val min_max: 'a t -> 'a t
    -> compare_a:('a -> 'a -> Compare.t)
    -> 'a t * 'a t
end

module type S2 = sig
  include Basic.S2

  val less_than: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val greater_than: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool

  val between: ('a, 'b) t -> low:('a, 'b) t -> high:('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b) t -> low:('a, 'b) t -> high:('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> bool

  val min: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> ('a, 'b) t
  val max: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> ('a, 'b) t
  val min_max: ('a, 'b) t -> ('a, 'b) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> ('a, 'b) t * ('a, 'b) t
end

module type S3 = sig
  include Basic.S3

  val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool

  val between: ('a, 'b, 'c) t -> low:('a, 'b, 'c) t -> high:('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b, 'c) t -> low:('a, 'b, 'c) t -> high:('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> bool

  val min: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> ('a, 'b, 'c) t
  val max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> ('a, 'b, 'c) t
  val min_max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> ('a, 'b, 'c) t * ('a, 'b, 'c) t
end

module type S4 = sig
  include Basic.S4

  val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool

  val between: ('a, 'b, 'c, 'd) t -> low:('a, 'b, 'c, 'd) t -> high:('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b, 'c, 'd) t -> low:('a, 'b, 'c, 'd) t -> high:('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> bool

  val min: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> ('a, 'b, 'c, 'd) t
  val max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> ('a, 'b, 'c, 'd) t
  val min_max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> ('a, 'b, 'c, 'd) t * ('a, 'b, 'c, 'd) t
end

module type S5 = sig
  include Basic.S5

  val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool

  val between: ('a, 'b, 'c, 'd, 'e) t -> low:('a, 'b, 'c, 'd, 'e) t -> high:('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool
  val between_or_equal: ('a, 'b, 'c, 'd, 'e) t -> low:('a, 'b, 'c, 'd, 'e) t -> high:('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> bool

  val min: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> ('a, 'b, 'c, 'd, 'e) t
  val max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> ('a, 'b, 'c, 'd, 'e) t
  val min_max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
    -> compare_a:('a -> 'a -> Compare.t)
    -> compare_b:('b -> 'b -> Compare.t)
    -> compare_c:('c -> 'c -> Compare.t)
    -> compare_d:('d -> 'd -> Compare.t)
    -> compare_e:('e -> 'e -> Compare.t)
    -> ('a, 'b, 'c, 'd, 'e) t * ('a, 'b, 'c, 'd, 'e) t
end
  
# 206 "General.cppo.mli"
  end

  module Ringoid: sig
    module Basic: sig
# 1 "Traits/Ringoid.signatures.Basic.ml"
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
    
# 211 "General.cppo.mli"
    end

    module Operators: sig
# 1 "Traits/Ringoid.signatures.Operators.ml"
module type S0 = sig
  type t

  val (~+): t -> t
  val (~-): t -> t
  val (+): t -> t -> t
  val (-): t -> t -> t
  val ( * ): t -> t -> t
  val (/): t -> t -> t

  val ( ** ): t -> int -> t
end

# 1 "Traits/Ringoid.makers.Operators.mli"
module Make0(M: sig
  type t

  val negate: t -> t
  val add: t -> t -> t
  val substract: t -> t -> t
  val multiply: t -> t -> t
  val divide: t -> t -> t
  val exponentiate: t -> int -> t
end): sig
  val (~+): M.t -> M.t
  val (~-): M.t -> M.t
  val (+): M.t -> M.t -> M.t
  val (-): M.t -> M.t -> M.t
  val ( * ): M.t -> M.t -> M.t
  val (/): M.t -> M.t -> M.t
  val ( ** ): M.t -> int -> M.t
end
    
# 217 "General.cppo.mli"
    end

# 1 "Traits/Ringoid.signatures.ml"
module type S0 = sig
  include Basic.S0

  val square: t -> t
  val exponentiate: t -> int -> t

  module O: Operators.S0 with type t := t
end

# 1 "Traits/Ringoid.makers.mli"
module Substract: sig
  module Make0(M: sig
    type t

    val negate: t -> t
    val add: t -> t -> t
  end): sig
    val substract: M.t -> M.t -> M.t
  end
end

module Square: sig
  module Make0(M: sig
    type t

    val multiply: t -> t -> t
  end): sig
    val square: M.t -> M.t
  end
end

module Exponentiate: sig
  module Make0(M: sig
    type t

    val one: t

    val square: t -> t
    val multiply: t -> t -> t

    val exponentiate_negative_exponent: exponentiate:(t -> int -> t) -> t -> int -> t
  end): sig
    val exponentiate: M.t -> int -> M.t
  end
end
  
# 222 "General.cppo.mli"
  end

  module PredSucc: sig
# 1 "Traits/PredSucc.signatures.ml"
module type S0 = sig
  type t

  val succ: t -> t
  val pred: t -> t
end

# 1 "Traits/PredSucc.makers.mli"
module Make0(M: sig
  type t

  val one: t

  val add: t -> t -> t
  val substract: t -> t -> t
end): sig
  val pred: M.t -> M.t
  val succ: M.t -> M.t
end
  
# 228 "General.cppo.mli"
  end

  module FilterMapable: sig
# 1 "Traits/FilterMapable.signatures.ml"
module type S0 = sig
  type elt
  type t

  val map: t -> f:(elt -> elt) -> t
  val map_i: t -> f:(i:int -> elt -> elt) -> t
  val map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * elt) -> t

  val filter: t -> f:(elt -> bool) -> t
  val filter_i: t -> f:(i:int -> elt -> bool) -> t
  val filter_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> t

  val filter_map: t -> f:(elt -> elt option) -> t
  val filter_map_i: t -> f:(i:int -> elt -> elt option) -> t
  val filter_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * elt option) -> t

  val flat_map: t -> f:(elt -> t) -> t
  val flat_map_i: t -> f:(i:int -> elt -> t) -> t
  val flat_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * t) -> t
end

module type S1 = sig
  type 'a t

  val map: 'a t -> f:('a -> 'b) -> 'b t
  val map_i: 'a t -> f:(i:int -> 'a -> 'b) -> 'b t
  val map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b) -> 'b t

  val filter: 'a t -> f:('a -> bool) -> 'a t
  val filter_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a t
  val filter_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a t

  val filter_map: 'a t -> f:('a -> 'b option) -> 'b t
  val filter_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b t
  val filter_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b t

  val flat_map: 'a t -> f:('a -> 'b t) -> 'b t
  val flat_map_i: 'a t -> f:(i:int -> 'a -> 'b t) -> 'b t
  val flat_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b t) -> 'b t
end

    
# 233 "General.cppo.mli"
    module ToContainer(C: sig type 'a t end): sig
# 1 "Traits/FilterMapable.signatures.ToContainer.ml"
module type S0 = sig
  type elt
  type t

  val map: t -> f:(elt -> 'b) -> 'b C.t
  val map_i: t -> f:(i:int -> elt -> 'b) -> 'b C.t
  val map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b) -> 'b C.t

  val filter: t -> f:(elt -> bool) -> elt C.t
  val filter_i: t -> f:(i:int -> elt -> bool) -> elt C.t
  val filter_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> elt C.t

  val filter_map: t -> f:(elt -> 'b option) -> 'b C.t
  val filter_map_i: t -> f:(i:int -> elt -> 'b option) -> 'b C.t
  val filter_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> 'b C.t

  val flat_map: t -> f:(elt -> 'b C.t) -> 'b C.t
  val flat_map_i: t -> f:(i:int -> elt -> 'b C.t) -> 'b C.t
  val flat_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b C.t) -> 'b C.t
end

module type S1 = sig
  type 'a t

  val map: 'a t -> f:('a -> 'b) -> 'b C.t
  val map_i: 'a t -> f:(i:int -> 'a -> 'b) -> 'b C.t
  val map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b) -> 'b C.t

  val filter: 'a t -> f:('a -> bool) -> 'a C.t
  val filter_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a C.t
  val filter_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a C.t

  val filter_map: 'a t -> f:('a -> 'b option) -> 'b C.t
  val filter_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b C.t
  val filter_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b C.t

  val flat_map: 'a t -> f:('a -> 'b C.t) -> 'b C.t
  val flat_map_i: 'a t -> f:(i:int -> 'a -> 'b C.t) -> 'b C.t
  val flat_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b C.t) -> 'b C.t
end
    
# 235 "General.cppo.mli"
    end

    module ToList: module type of ToContainer(struct type 'a t = 'a list end)

    module ToArray: module type of ToContainer(struct type 'a t = 'a array end)
  end

  module Foldable: sig
    module Basic: sig
# 1 "Traits/Foldable.signatures.Basic.ml"
module type S0 = sig
  type elt
  type t

  val fold: init:'b -> t -> f:('b -> elt -> 'b) -> 'b
  val fold_i: init:'b -> t -> f:(i:int -> 'b -> elt -> 'b) -> 'b
  val fold_acc: acc:'acc -> init:'b -> t -> f:(acc:'acc -> 'b -> elt -> 'acc * 'b) -> 'b
end

module type S1 = sig
  type 'a t

  val fold: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b
  val fold_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b
  val fold_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b
end
    
# 245 "General.cppo.mli"
    end

# 1 "Traits/Foldable.signatures.ml"
module type S0 = sig
  include Basic.S0

  val reduce: t -> f:(elt -> elt -> elt) -> elt
  val reduce_i: t -> f:(i:int -> elt -> elt -> elt) -> elt
  val reduce_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> elt

  val try_reduce: t -> f:(elt -> elt -> elt) -> (elt) option
  val try_reduce_i: t -> f:(i:int -> elt -> elt -> elt) -> (elt) option
  val try_reduce_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> (elt) option

  val iter: t -> f:(elt -> unit) -> unit
  val iter_i: t -> f:(i:int -> elt -> unit) -> unit
  val iter_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc) -> unit

  val count: t -> f:(elt -> bool) -> int
  val count_i: t -> f:(i:int -> elt -> bool) -> int
  val count_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> int
end

module type S1 = sig
  include Basic.S1

  val reduce: 'a t -> f:('a -> 'a -> 'a) -> 'a
  val reduce_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> 'a
  val reduce_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> 'a

  val try_reduce: 'a t -> f:('a -> 'a -> 'a) -> ('a) option
  val try_reduce_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> ('a) option
  val try_reduce_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> ('a) option

  val iter: 'a t -> f:('a -> unit) -> unit
  val iter_i: 'a t -> f:(i:int -> 'a -> unit) -> unit
  val iter_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc) -> unit

  val count: 'a t -> f:('a -> bool) -> int
  val count_i: 'a t -> f:(i:int -> 'a -> bool) -> int
  val count_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> int
end

    
# 249 "General.cppo.mli"
    module Right: sig
      module Basic: sig
# 1 "Traits/Foldable.signatures.Right.Basic.ml"
module type S0 = sig
  type elt
  type t

  val fold_right: t -> init:'b -> f:(elt -> 'b -> 'b) -> 'b
  val fold_right_i: t -> init:'b -> f:(i:int -> elt -> 'b -> 'b) -> 'b
  val fold_right_acc: acc:'acc -> t -> init:'b -> f:(acc:'acc -> elt -> 'b -> 'acc * 'b) -> 'b
end

module type S1 = sig
  type 'a t

  val fold_right: 'a t -> init:'b -> f:('a -> 'b -> 'b) -> 'b
  val fold_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> 'b) -> 'b
  val fold_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * 'b) -> 'b
end
      
# 252 "General.cppo.mli"
      end

# 1 "Traits/Foldable.signatures.Right.ml"
module type S0 = sig
  include Basic.S0

  val reduce_right: t -> f:(elt -> elt -> elt) -> elt
  val reduce_right_i: t -> f:(i:int -> elt -> elt -> elt) -> elt
  val reduce_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> elt

  val try_reduce_right: t -> f:(elt -> elt -> elt) -> (elt) option
  val try_reduce_right_i: t -> f:(i:int -> elt -> elt -> elt) -> (elt) option
  val try_reduce_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> (elt) option

  val iter_right: t -> f:(elt -> unit) -> unit
  val iter_right_i: t -> f:(i:int -> elt -> unit) -> unit
  val iter_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * unit) -> unit
end

module type S1 = sig
  include Basic.S1

  val reduce_right: 'a t -> f:('a -> 'a -> 'a) -> 'a
  val reduce_right_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> 'a
  val reduce_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> 'a

  val try_reduce_right: 'a t -> f:('a -> 'a -> 'a) -> ('a) option
  val try_reduce_right_i: 'a t -> f:(i:int -> 'a -> 'a -> 'a) -> ('a) option
  val try_reduce_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * 'a) -> ('a) option

  val iter_right: 'a t -> f:('a -> unit) -> unit
  val iter_right_i: 'a t -> f:(i:int -> 'a -> unit) -> unit
  val iter_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * unit) -> unit
end
    
# 255 "General.cppo.mli"
    end

    module Short: sig
      module Basic: sig
# 1 "Traits/Foldable.signatures.Short.Basic.ml"
module type S0 = sig
  type elt
  type t

  val fold_short: init:'b -> t -> f:('b -> elt -> Shorten.t * 'b) -> 'b
  val fold_short_i: init:'b -> t -> f:(i:int -> 'b -> elt -> Shorten.t * 'b) -> 'b
  val fold_short_acc: acc:'acc -> init:'b -> t -> f:(acc:'acc -> 'b -> elt -> 'acc * Shorten.t * 'b) -> 'b
end

module type S1 = sig
  type 'a t

  val fold_short: init:'b -> 'a t -> f:('b -> 'a -> Shorten.t * 'b) -> 'b
  val fold_short_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> Shorten.t * 'b) -> 'b
  val fold_short_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * Shorten.t * 'b) -> 'b
end
      
# 260 "General.cppo.mli"
      end

# 1 "Traits/Foldable.signatures.Short.ml"
module type S0 = sig
  include Basic.S0

  val reduce_short: t -> f:(elt -> elt -> Shorten.t * elt) -> elt
  val reduce_short_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> elt
  val reduce_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> elt

  val try_reduce_short: t -> f:(elt -> elt -> Shorten.t * elt) -> (elt) option
  val try_reduce_short_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> (elt) option
  val try_reduce_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> (elt) option

  val iter_short: t -> f:(elt -> Shorten.t) -> unit
  val iter_short_i: t -> f:(i:int -> elt -> Shorten.t) -> unit
  val iter_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * Shorten.t) -> unit

  val for_all: t -> f:(elt -> bool) -> bool
  val for_all_i: t -> f:(i:int -> elt -> bool) -> bool
  val for_all_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> bool

  val there_exists: t -> f:(elt -> bool) -> bool
  val there_exists_i: t -> f:(i:int -> elt -> bool) -> bool
  val there_exists_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> bool

  val find: t -> f:(elt -> bool) -> elt
  val find_i: t -> f:(i:int -> elt -> bool) -> elt
  val find_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> elt

  val try_find: t -> f:(elt -> bool) -> (elt) option
  val try_find_i: t -> f:(i:int -> elt -> bool) -> (elt) option
  val try_find_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> (elt) option

  val find_map: t -> f:(elt -> 'b option) -> 'b
  val find_map_i: t -> f:(i:int -> elt -> 'b option) -> 'b
  val find_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> 'b

  val try_find_map: t -> f:(elt -> 'b option) -> ( 'b) option
  val try_find_map_i: t -> f:(i:int -> elt -> 'b option) -> ( 'b) option
  val try_find_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> ( 'b) option
end

module type S1 = sig
  include Basic.S1

  val reduce_short: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> 'a
  val reduce_short_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> 'a
  val reduce_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> 'a

  val try_reduce_short: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> ('a) option
  val try_reduce_short_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> ('a) option
  val try_reduce_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> ('a) option

  val iter_short: 'a t -> f:('a -> Shorten.t) -> unit
  val iter_short_i: 'a t -> f:(i:int -> 'a -> Shorten.t) -> unit
  val iter_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * Shorten.t) -> unit

  val for_all: 'a t -> f:('a -> bool) -> bool
  val for_all_i: 'a t -> f:(i:int -> 'a -> bool) -> bool
  val for_all_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> bool

  val there_exists: 'a t -> f:('a -> bool) -> bool
  val there_exists_i: 'a t -> f:(i:int -> 'a -> bool) -> bool
  val there_exists_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> bool

  val find: 'a t -> f:('a -> bool) -> 'a
  val find_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a
  val find_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a

  val try_find: 'a t -> f:('a -> bool) -> ('a) option
  val try_find_i: 'a t -> f:(i:int -> 'a -> bool) -> ('a) option
  val try_find_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> ('a) option

  val find_map: 'a t -> f:('a -> 'b option) -> 'b
  val find_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b
  val find_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b

  val try_find_map: 'a t -> f:('a -> 'b option) -> ( 'b) option
  val try_find_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> ( 'b) option
  val try_find_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> ( 'b) option
end

      
# 264 "General.cppo.mli"
      module Right: sig
        module Basic: sig
# 1 "Traits/Foldable.signatures.Short.Right.Basic.ml"
module type S0 = sig
  type elt
  type t

  val fold_short_right: t -> init:'b -> f:(elt -> 'b -> Shorten.t * 'b) -> 'b
  val fold_short_right_i: t -> init:'b -> f:(i:int -> elt -> 'b -> Shorten.t * 'b) -> 'b
  val fold_short_right_acc: acc:'acc -> t -> init:'b -> f:(acc:'acc -> elt -> 'b -> 'acc * Shorten.t * 'b) -> 'b
end

module type S1 = sig
  type 'a t

  val fold_short_right: 'a t -> init:'b -> f:('a -> 'b -> Shorten.t * 'b) -> 'b
  val fold_short_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> Shorten.t * 'b) -> 'b
  val fold_short_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * Shorten.t * 'b) -> 'b
end
        
# 267 "General.cppo.mli"
        end

# 1 "Traits/Foldable.signatures.Short.Right.ml"
module type S0 = sig
  include Basic.S0

  val reduce_short_right: t -> f:(elt -> elt -> Shorten.t * elt) -> elt
  val reduce_short_right_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> elt
  val reduce_short_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> elt

  val try_reduce_short_right: t -> f:(elt -> elt -> Shorten.t * elt) -> (elt) option
  val try_reduce_short_right_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> (elt) option
  val try_reduce_short_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> (elt) option

  val iter_short_right: t -> f:(elt -> Shorten.t) -> unit
  val iter_short_right_i: t -> f:(i:int -> elt -> Shorten.t) -> unit
  val iter_short_right_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * Shorten.t) -> unit
end

module type S1 = sig
  include Basic.S1

  val reduce_short_right: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> 'a
  val reduce_short_right_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> 'a
  val reduce_short_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> 'a

  val try_reduce_short_right: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> ('a) option
  val try_reduce_short_right_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> ('a) option
  val try_reduce_short_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> ('a) option

  val iter_short_right: 'a t -> f:('a -> Shorten.t) -> unit
  val iter_short_right_i: 'a t -> f:(i:int -> 'a -> Shorten.t) -> unit
  val iter_short_right_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * Shorten.t) -> unit
end
      
# 270 "General.cppo.mli"
      end
    end
  end

  module Scanable: sig
# 1 "Traits/Scanable.signatures.ml"
module type S0 = sig
  type elt
  type t

  val scan: init:elt -> t -> f:(elt -> elt -> elt) -> t
  val scan_i: init:elt -> t -> f:(i:int -> elt -> elt -> elt) -> t
  val scan_acc: acc:'acc -> init:elt -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> t
end

module type S1 = sig
  type 'a t

  val scan: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b t
  val scan_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b t
  val scan_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b t
end

    
# 277 "General.cppo.mli"
    module ToContainer(C: sig type 'a t end): sig
# 1 "Traits/Scanable.signatures.ToContainer.ml"
module type S0 = sig
  type elt
  type t

  val scan: init:'a -> t -> f:('a -> elt -> 'a) -> 'a C.t
  val scan_i: init:'a -> t -> f:(i:int -> 'a -> elt -> 'a) -> 'a C.t
  val scan_acc: acc:'acc -> init:'a -> t -> f:(acc:'acc -> 'a -> elt -> 'acc * 'a) -> 'a C.t
end

module type S1 = sig
  type 'a t

  val scan: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b C.t
  val scan_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b C.t
  val scan_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b C.t
end
    
# 279 "General.cppo.mli"
    end

    module ToList: module type of ToContainer(struct type 'a t = 'a list end)

    module ToArray: module type of ToContainer(struct type 'a t = 'a array end)

    module Right: sig
# 1 "Traits/Scanable.signatures.Right.ml"
module type S0 = sig
  type elt
  type t

  val scan_right: t -> init:elt -> f:(elt -> elt -> elt) -> t
  val scan_right_i: t -> init:elt -> f:(i:int -> elt -> elt -> elt) -> t
  val scan_right_acc: acc:'acc -> t -> init:elt -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> t
end

module type S1 = sig
  type 'a t

  val scan_right: 'a t -> init:'b -> f:('a -> 'b -> 'b) -> 'b t
  val scan_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> 'b) -> 'b t
  val scan_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * 'b) -> 'b t
end

      
# 288 "General.cppo.mli"
      module ToContainer(C: sig type 'a t end): sig
# 1 "Traits/Scanable.signatures.Right.ToContainer.ml"
module type S0 = sig
  type elt
  type t

  val scan_right: t -> init:'a -> f:(elt -> 'a -> 'a) -> 'a C.t
  val scan_right_i: t -> init:'a -> f:(i:int -> elt -> 'a -> 'a) -> 'a C.t
  val scan_right_acc: acc:'acc -> t -> init:'a -> f:(acc:'acc -> elt -> 'a -> 'acc * 'a) -> 'a C.t
end

module type S1 = sig
  type 'a t

  val scan_right: 'a t -> init:'b -> f:('a -> 'b -> 'b) -> 'b C.t
  val scan_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> 'b) -> 'b C.t
  val scan_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * 'b) -> 'b C.t
end
      
# 290 "General.cppo.mli"
      end

      module ToList: module type of ToContainer(struct type 'a t = 'a list end)

      module ToArray: module type of ToContainer(struct type 'a t = 'a array end)
    end

    module Short: sig
# 1 "Traits/Scanable.signatures.Short.ml"
module type S0 = sig
  type elt
  type t

  val scan_short: init:elt -> t -> f:(elt -> elt -> Shorten.t * elt) -> t
  val scan_short_i: init:elt -> t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> t
  val scan_short_acc: acc:'acc -> init:elt -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> t
end

module type S1 = sig
  type 'a t

  val scan_short: init:'b -> 'a t -> f:('b -> 'a -> Shorten.t * 'b) -> 'b t
  val scan_short_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> Shorten.t * 'b) -> 'b t
  val scan_short_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * Shorten.t * 'b) -> 'b t
end

      
# 300 "General.cppo.mli"
      module ToContainer(C: sig type 'a t end): sig
# 1 "Traits/Scanable.signatures.Short.ToContainer.ml"
module type S0 = sig
  type elt
  type t

  val scan_short: init:'a -> t -> f:('a -> elt -> Shorten.t * 'a) -> 'a C.t
  val scan_short_i: init:'a -> t -> f:(i:int -> 'a -> elt -> Shorten.t * 'a) -> 'a C.t
  val scan_short_acc: acc:'acc -> init:'a -> t -> f:(acc:'acc -> 'a -> elt -> 'acc * Shorten.t * 'a) -> 'a C.t
end

module type S1 = sig
  type 'a t

  val scan_short: init:'b -> 'a t -> f:('b -> 'a -> Shorten.t * 'b) -> 'b C.t
  val scan_short_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> Shorten.t * 'b) -> 'b C.t
  val scan_short_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * Shorten.t * 'b) -> 'b C.t
end
      
# 302 "General.cppo.mli"
      end

      module ToList: module type of ToContainer(struct type 'a t = 'a list end)

      module ToArray: module type of ToContainer(struct type 'a t = 'a array end)

      module Right: sig
# 1 "Traits/Scanable.signatures.Short.Right.ml"
module type S0 = sig
  type elt
  type t

  val scan_short_right: t -> init:elt -> f:(elt -> elt -> Shorten.t * elt) -> t
  val scan_short_right_i: t -> init:elt -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> t
  val scan_short_right_acc: acc:'acc -> t -> init:elt -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> t
end

module type S1 = sig
  type 'a t

  val scan_short_right: 'a t -> init:'b -> f:('a -> 'b -> Shorten.t * 'b) -> 'b t
  val scan_short_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> Shorten.t * 'b) -> 'b t
  val scan_short_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * Shorten.t * 'b) -> 'b t
end

        
# 311 "General.cppo.mli"
        module ToContainer(C: sig type 'a t end): sig
# 1 "Traits/Scanable.signatures.Short.Right.ToContainer.ml"
module type S0 = sig
  type elt
  type t

  val scan_short_right: t -> init:'a -> f:(elt -> 'a -> Shorten.t * 'a) -> 'a C.t
  val scan_short_right_i: t -> init:'a -> f:(i:int -> elt -> 'a -> Shorten.t * 'a) -> 'a C.t
  val scan_short_right_acc: acc:'acc -> t -> init:'a -> f:(acc:'acc -> elt -> 'a -> 'acc * Shorten.t * 'a) -> 'a C.t
end

module type S1 = sig
  type 'a t

  val scan_short_right: 'a t -> init:'b -> f:('a -> 'b -> Shorten.t * 'b) -> 'b C.t
  val scan_short_right_i: 'a t -> init:'b -> f:(i:int -> 'a -> 'b -> Shorten.t * 'b) -> 'b C.t
  val scan_short_right_acc: acc:'acc -> 'a t -> init:'b -> f:(acc:'acc -> 'a -> 'b -> 'acc * Shorten.t * 'b) -> 'b C.t
end
        
# 313 "General.cppo.mli"
        end

        module ToList: module type of ToContainer(struct type 'a t = 'a list end)

        module ToArray: module type of ToContainer(struct type 'a t = 'a array end)
      end
    end
  end
end

(* Typology of iterations other collection:
- is there an accumulator (fold vs map)
- is it short circuit (exists/fold_short/find vs fold/map)
- does it produce a list (map) or a scalar (find/fold) or nothing (iter)
- from a list (map) or from a scalar (unfold/until_none/until_fixed)? (until_none i: [f i; f f i; f f f i; ... until f returns None]; until_fixed: until f f f i = f f i)
- other criteria?
and we need a generic function in each category. *)

module Concepts: sig
  (* @feature Concepts for iterables and collections. Something like Collection, Container, MonoBag, MultiBag, LinearContainer *)
  (* @feature Concepts.Stringable including Parsable and Displayable *)

  module Identifiable: sig
# 1 "Concepts/Identifiable.signatures.ml"
module Operators = Traits.Equatable.Operators

module type S0 = sig
  type t

  include Traits.Equatable.S0 with type t := t
  include Traits.Representable.S0 with type t := t
end

module type S1 = sig
  type 'a t

  include Traits.Equatable.S1 with type 'a t := 'a t
  include Traits.Representable.S1 with type 'a t := 'a t
end

module type S2 = sig
  type ('a, 'b) t

  include Traits.Equatable.S2 with type ('a, 'b) t := ('a, 'b) t
  include Traits.Representable.S2 with type ('a, 'b) t := ('a, 'b) t
end

module type S3 = sig
  type ('a, 'b, 'c) t

  include Traits.Equatable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  include Traits.Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t

  include Traits.Equatable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  include Traits.Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t

  include Traits.Equatable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  include Traits.Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
end
  
# 337 "General.cppo.mli"
  end

  module Able: sig
    module Operators: sig
# 1 "Concepts/Able.signatures.Operators.ml"
module type S0 = sig
  type t

  include Identifiable.Operators.S0 with type t := t
  include Traits.Comparable.Operators.S0 with type t := t
end
    
# 342 "General.cppo.mli"
    end

# 1 "Concepts/Able.signatures.ml"
module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Identifiable.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O
end

module type S1 = sig
  type 'a t

  include Identifiable.S1 with type 'a t := 'a t
  include Traits.Comparable.S1 with type 'a t := 'a t
end

module type S2 = sig
  type ('a, 'b) t

  include Identifiable.S2 with type ('a, 'b) t := ('a, 'b) t
  include Traits.Comparable.S2 with type ('a, 'b) t := ('a, 'b) t
end

module type S3 = sig
  type ('a, 'b, 'c) t

  include Identifiable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  include Traits.Comparable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
end

module type S4 = sig
  type ('a, 'b, 'c, 'd) t

  include Identifiable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  include Traits.Comparable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
end

module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t

  include Identifiable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  include Traits.Comparable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
end
  
# 345 "General.cppo.mli"
  end

  module Number: sig
    module Operators: sig
# 1 "Concepts/Number.signatures.Operators.ml"
module type S0 = sig
  type t

  include Traits.Equatable.Operators.S0 with type t := t
  include Traits.Ringoid.Operators.S0 with type t := t
end
    
# 350 "General.cppo.mli"
    end

# 1 "Concepts/Number.signatures.ml"
module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Traits.Displayable.S0 with type t := t
  include Traits.Equatable.S0 with type t := t and module O := O
  include Traits.Parsable.S0 with type t := t
  include Traits.Representable.S0 with type t := t
  include Traits.Ringoid.S0 with type t := t and module O := O

  (* @feature Traits.OfStandardNumbers? *)
  (* @feature of_int32, of_int64, of_nativeint *)
  val of_int: int -> t
  val of_float: float -> t
end
  
# 353 "General.cppo.mli"
  end

  module RealNumber: sig
    module Operators: sig
# 1 "Concepts/RealNumber.signatures.Operators.ml"
module type S0 = sig
  type t

  include Number.Operators.S0 with type t := t
  include Traits.Comparable.Operators.S0 with type t := t

  val (mod): t -> t -> t
end
    
# 358 "General.cppo.mli"
    end


# 2 "Concepts/RealNumber.signatures.ml"
module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Number.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O

  val abs: t -> t
  val modulo: t -> t -> t

  (* @feature Traits.ToStandardNumbers? *)
  val to_int: t -> int
  val to_float: t -> float

  (* @feature sign *)
end
  
# 361 "General.cppo.mli"
  end

  module Integer: sig
# 1 "Concepts/Integer.signatures.ml"
module type S0 = sig
  type t

  include RealNumber.S0 with type t := t
  include Traits.PredSucc.S0 with type t := t

  (* @feature Bitwise? *)
  (* @feature gcd, lcm, quomod *)
end
  
# 365 "General.cppo.mli"
  end
end

(* Technical, utility modules *)

module CallStack: sig
  type t = Pervasives.OCamlStandard.Printexc.raw_backtrace

  include Traits.Displayable.S0 with type t := t
  include Traits.Representable.S0 with type t := t

  val current: ?max_size:int -> unit -> t

  module Location: sig
    type t = Pervasives.OCamlStandard.Printexc.location = {
      filename: string;
      line_number: int;
      start_char: int;
      end_char: int;
    }

    include Concepts.Able.S0 with type t := t
  end

  module Frame: sig
    type t = Pervasives.OCamlStandard.Printexc.backtrace_slot

    val is_raise: t -> bool
    (* @feature val is_inline: t -> bool *)

    val location: t -> Location.t option

    val format: int -> t -> string option
  end

  (* @feature? val size: t -> int *)
  (* @feature? val frame: t -> int -> Frame.t *)
  val frames: t -> Frame.t list
end

module Exception: sig
  type t = exn

  include Concepts.Identifiable.S0 with type t := t
  include Traits.Displayable.S0 with type t := t

  val register_printer: (t -> string option) -> unit

  val record_backtraces: bool -> unit
  val recording_backtraces: unit -> bool
  (* There is no way to get the call stack of a specific exception.
  It's just possible to get the call stack of the most recent exception. *)
  val most_recent_backtrace: unit -> CallStack.t option

  (* Aliases for all predefined exceptions
  https://caml.inria.fr/pub/docs/manual-ocaml-4.05/core.html#sec527 *)
  exception MatchFailure of (string * int * int)
  exception AssertFailure of (string * int * int)
  exception InvalidArgument of string
  exception Failure of string
  exception NotFound

  (** Raised when the system could not allocate memory *)
  exception OutOfMemory

  exception StackOverflow
  exception SysError of string
  exception EndOfFile
  exception DivisionByZero
  exception SysBlockedIO
  exception UndefinedRecursiveModule of (string * int * int)

  (* Aliases for all exceptions in Pervasives
  https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libref/Pervasives.html *)
  exception Exit

  val raise: t -> 'a

  val raise_without_backtrace: t -> 'a

  val invalid_argument: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val failure: ('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a

  val failure_if: bool -> ('a, unit, string, string, string, unit) CamlinternalFormatBasics.format6 -> 'a
  val failure_unless: bool -> ('a, unit, string, string, string, unit) CamlinternalFormatBasics.format6 -> 'a

  val name: exn -> string

  val or_none: 'a lazy_t -> 'a option
end

module Exit: sig
  type t =
    | Success
    | Failure of int

  (* @feature Able *)

  val of_int: int -> t

  val exit: t -> 'a

  val at_exit: (unit -> unit) -> unit
end

(* Functions *)

module Function1: sig
  type ('a, 'z) t = 'a -> 'z

  val identity: ('a, 'a) t

  val apply: ('a, 'z) t -> 'a -> 'z
  val rev_apply: 'a -> ('a, 'z) t -> 'z
  val compose: ('a, 'b) t -> ('c, 'a) t -> ('c, 'b) t

  module O: sig
    val (@@): ('a, 'z) t -> 'a -> 'z
    val (|>): 'a -> ('a, 'z) t -> 'z
    val (%): ('a, 'b) t -> ('c, 'a) t -> ('c, 'b) t
  end
end

module Function2: sig
  type ('a, 'b, 'z) t = 'a -> 'b -> 'z

  val flip: ('a, 'b, 'z) t -> ('b, 'a, 'z) t

  val curry: ('a * 'b, 'z) Function1.t -> ('a, 'b, 'z) t
  val uncurry: ('a, 'b, 'z) t -> ('a * 'b, 'z) Function1.t
end

module Function3: sig
  type ('a, 'b, 'c, 'z) t = 'a -> 'b -> 'c -> 'z

  val flip: ('a, 'b, 'c, 'z) t -> ('c, 'b, 'a, 'z) t

  val curry: ('a * 'b * 'c, 'z) Function1.t -> ('a, 'b, 'c, 'z) t
  val uncurry: ('a, 'b, 'c, 'z) t -> ('a * 'b * 'c, 'z) Function1.t
end

module Function4: sig
  type ('a, 'b, 'c, 'd, 'z) t = 'a -> 'b -> 'c -> 'd -> 'z

  val flip: ('a, 'b, 'c, 'd, 'z) t -> ('d, 'c, 'b, 'a, 'z) t

  val curry: ('a * 'b * 'c * 'd, 'z) Function1.t -> ('a, 'b, 'c, 'd, 'z) t
  val uncurry: ('a, 'b, 'c, 'd, 'z) t -> ('a * 'b * 'c * 'd, 'z) Function1.t
end

module Function5: sig
  type ('a, 'b, 'c, 'd, 'e, 'z) t = 'a -> 'b -> 'c -> 'd -> 'e -> 'z

  val flip: ('a, 'b, 'c, 'd, 'e, 'z) t -> ('e, 'd, 'c, 'b, 'a, 'z) t

  val curry: ('a * 'b * 'c * 'd * 'e, 'z) Function1.t -> ('a, 'b, 'c, 'd, 'e, 'z) t
  val uncurry: ('a, 'b, 'c, 'd, 'e, 'z) t -> ('a * 'b * 'c * 'd * 'e, 'z) Function1.t
end

(* @feature Predicate1,2,3,etc. (or BoolFunction1,2,3, more consistent with other specializations) with composition of predicates (not, and, or, xor) *)

(* Atomic values *)

module Unit: sig
  type t = unit

  (* @feature Able *)

  val ignore: 'a -> t
end

module Bool: sig
  type t = bool

  module O: sig
    include Concepts.Able.Operators.S0 with type t := t

    val not: t -> t
    val (&&): t -> t -> t (* Lazy *)
    val (||): t -> t -> t (* Lazy *)
    val xor: t -> t -> t
  end

  include Concepts.Able.S0 with type t := t and module O := O
  include Traits.Displayable.S0 with type t := t
  include Traits.Parsable.S0 with type t := t

  val not: t -> t
  val and_: t -> t -> t (* Not lazy *)
  val or_: t -> t -> t (* Not lazy *)
  val xor: t -> t -> t
end

module Char: sig
  type t = char

  (* @feature Integer, smallest, greatest *)
  include Traits.Comparable.S0 with type t := t

  val of_int: int -> t
  val to_int: t -> int

  val to_string: t -> string
  val repeat: t -> len:int -> string
end

module Int: sig
  type t = int

  include Concepts.Integer.S0 with type t := t

  (* @feature Traits.Bounded? Concept.FixedWidthInteger? *)
  (* @feature width: int  Like OCS.Nativeint.size and Sys.int_size *)
  val smallest: t
  val greatest: t

  module Bitwise: sig
    val logical_and: t -> t -> t
    val logical_or: t -> t -> t
    val logical_xor: t -> t -> t
    val logical_not: t -> t
    val logical_shift_left: t -> shift:t -> t
    val logical_shift_right: t -> shift:t -> t
    val arithmetic_shift_right: t -> shift:t -> t
  end
end

module Int32: sig
  type t = int32

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end

module Int64: sig
  type t = int64

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end

module NativeInt: sig
  type t = nativeint

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end

module BigInt: sig
  type t = Pervasives.OCamlStandard.Big_int.big_int

  include Concepts.Integer.S0 with type t := t
end

module Float: sig
  type t = float

  include Concepts.RealNumber.S0 with type t := t

  val approx_equal: ?precision:t -> t -> t -> bool

  val epsilon: t
  val smallest: t
  val greatest: t
  val infinity: t
  val negative_infinity: t
  val not_a_number: t
  val pi: float
  val e: float

  val of_parts: significand:float -> exponent:int -> t
  val to_parts: t -> float * int
  val to_fractional_and_integral: t -> float * float

  val sqrt: float -> float

  val exp: float -> float
  val log: float -> float
  val log10: float -> float
  val expm1: float -> float
  val log1p: float -> float

  val cos: float -> float
  val sin: float -> float
  val tan: float -> float
  val acos: float -> float
  val asin: float -> float
  val atan: float -> float
  val atan2: y:float -> x:float -> float
  val hypot: float -> float -> float
  val cosh: float -> float
  val sinh: float -> float
  val tanh: float -> float

  val ceil: float -> float
  val floor: float -> float
  val copy_sign: t -> sign:t -> t

  module Class: sig
    type t =
      | Normal
      | SubNormal
      | Zero
      | Infinite
      | NotANumber

    include Traits.Representable.S0 with type t := t

    val of_float: float -> t
  end
end

module String: sig
  type t = string

  val of_char: char -> t
  val of_list: char list -> t
  val to_list: t -> char list

  val size: t -> int
  val get: t -> int -> char
  val set: bytes -> int -> char -> unit

  val of_bytes: bytes -> t
  val to_bytes: t -> bytes

  module O: sig
    include Concepts.Able.Operators.S0 with type t := t
    val (^): t -> t -> t
  end

  include Traits.Displayable.S0 with type t := t
  include Traits.Parsable.S0 with type t := t
  include Concepts.Able.S0 with type t := t and module O := O

  val concat: t -> t -> t

  (* @feature val try_substring: t -> pos:int -> len:int -> t option *)
  val substring: t -> pos:int -> len:int -> t
  (* @feature val try_prefix: t -> len:int -> t option *)
  val prefix: t -> len:int -> t
  (* @feature val try_suffix: t -> len:int -> t option *)
  val suffix: t -> len:int -> t

  val has_prefix: t -> pre:t -> bool
  val try_drop_prefix: t -> pre:t -> t option
  val drop_prefix: t -> pre:t -> t
  val drop_prefix': t -> len:int -> t
  val has_suffix: t -> suf:t -> bool
  val try_drop_suffix: t -> suf:t -> t option
  val drop_suffix: t -> suf:t -> t
  val drop_suffix': t -> len:int -> t

  val split: t -> sep:t -> t list
  val split': t -> seps:char list -> t list

  (* @feature Traits *)
  val fold: init:'a -> t -> f:('a -> char -> 'a) -> 'a
  val filter: t -> f:(char -> bool) -> t
end

module Bytes: sig
  type t = bytes

  val size: t -> int

  val of_string: string -> t
  val to_string: t -> string

  val get: t -> int -> char
  val set: t -> int -> char -> unit

  val empty: t
  val make: len:int -> t
end

(* @feature Rational, Complex, Quaternion, Matrix *)

(* Fixed-size containers *)

module Option: sig
  type 'a t = 'a option

  include Concepts.Able.S1 with type 'a t := 'a t

  (* @feature coalesce[_def] (with an (|||) operator? The operator *has* to be lazy like (&&) and (||)) *)

  val none: 'a t
  val some: 'a -> 'a t

  val some_if: bool -> 'a lazy_t -> 'a t
  val some_if': bool -> 'a -> 'a t

  val is_some: 'a t -> bool
  val is_none: 'a t -> bool

  val value_def: 'a t -> def:'a -> 'a
  val value: ?exc:exn -> 'a t -> 'a
  val or_failure: ('a, unit, string, string, string, 'b t -> 'b) CamlinternalFormatBasics.format6 -> 'a

  val map: 'a t -> f:('a -> 'b) -> 'b t
  val iter: 'a t -> f:('a -> unit) -> unit
  val filter: 'a t -> f:('a -> bool) -> 'a t
  val filter_map: 'a t -> f:('a -> 'b option) -> 'b t

  val value_map: 'a t -> def:'b -> f:('a -> 'b) -> 'b

  module Specialize(A: sig type t end): sig
    type t = A.t option

    val some_if: bool -> A.t lazy_t -> t
    val some_if': bool -> A.t -> t

    val is_some: t -> bool
    val is_none: t -> bool

    val value_def: t -> def:A.t -> A.t
    val value: ?exc:exn -> t -> A.t
    val or_failure: ('a, unit, string, string, string, t -> A.t) CamlinternalFormatBasics.format6 -> 'a

    val map: t -> f:(A.t -> 'a) -> 'a option
    val iter: t -> f:(A.t -> unit) -> unit
    val filter: t -> f:(A.t -> bool) -> t
    val filter_map: t -> f:(A.t -> 'a option) -> 'a option

    val value_map: t -> def:'a -> f:(A.t -> 'a) -> 'a
  end
end

module Lazy: sig
  type 'a t = 'a lazy_t

  val is_value: 'a t -> bool

  val value: 'a t -> 'a

  val map: 'a t -> f:('a -> 'b) -> 'b t
end

module Reference: sig
  type 'a t = 'a Pervasives.OCamlStandard.Pervasives.ref = {mutable contents: 'a}

  (* @feature Concept.Able *)

  val of_contents: 'a -> 'a t
  val contents: 'a t -> 'a
  val assign: 'a t -> 'a -> unit

  module O: sig
    val ref: 'a -> 'a t
    val (!): 'a t -> 'a
    val (:=): 'a t -> 'a -> unit
  end

  module SpecializeOperators(A: sig type t end): sig
    type nonrec t = A.t t

    val ref: A.t -> t
    val (!): t -> A.t
    val (:=): t -> A.t -> unit
  end

  module Specialize(A: sig type t end): sig
    type nonrec t = A.t t

    val of_contents: A.t -> t
    val contents: t -> A.t
    val assign: t -> A.t -> unit

    module O: module type of SpecializeOperators(A) with type t := t
  end

  (* @feature SpecializeComparable *)
  (* @feature SpecializeEquatable *)
  (* @feature SpecializeRepresentable *)
  (* @feature SpecializeAble (merge of three previous) *)

  module SpecializePredSucc(A: Traits.PredSucc.S0): sig
    type nonrec t = A.t t

    val increment: t -> unit
    val decrement: t -> unit
  end

  module SpecializeRingoidOperators(A: Traits.Ringoid.Basic.S0): sig
    type nonrec t = A.t t

    val (=+): t -> A.t -> unit
    val (=-): t -> A.t -> unit
    val (=*): t -> A.t -> unit
    val (=/): t -> A.t -> unit
  end

  module SpecializeRingoid(A: Traits.Ringoid.Basic.S0): sig
    type nonrec t = A.t t

    module O: module type of SpecializeRingoidOperators(A) with type t := t
  end
end

module Tuple2: sig
  type ('a, 'b) t = 'a * 'b

  include Concepts.Able.S2 with type ('a, 'b) t := ('a, 'b) t

  val make: 'a -> 'b -> ('a, 'b) t

  val get_0: ('a, _) t -> 'a
  val get_1: (_, 'b) t -> 'b

  val flip: ('a, 'b) t -> ('b, 'a) t
end

module Tuple3: sig
  type ('a, 'b, 'c) t = 'a * 'b * 'c

  include Concepts.Able.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t

  val make: 'a -> 'b -> 'c -> ('a, 'b, 'c) t

  val get_0: ('a, _, _) t -> 'a
  val get_1: (_, 'b, _) t -> 'b
  val get_2: (_, _, 'c) t -> 'c

  val flip: ('a, 'b, 'c) t -> ('c, 'b, 'a) t
end

module Tuple4: sig
  type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd

  include Concepts.Able.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t

  val make: 'a -> 'b -> 'c -> 'd -> ('a, 'b, 'c, 'd) t

  val get_0: ('a, _, _, _) t -> 'a
  val get_1: (_, 'b, _, _) t -> 'b
  val get_2: (_, _, 'c, _) t -> 'c
  val get_3: (_, _, _, 'd) t -> 'd

  val flip: ('a, 'b, 'c, 'd) t -> ('d, 'c, 'b, 'a) t
end

module Tuple5: sig
  type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e

  include Concepts.Able.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t

  val make: 'a -> 'b -> 'c -> 'd -> 'e -> ('a, 'b, 'c, 'd, 'e) t

  val get_0: ('a, _, _, _, _) t -> 'a
  val get_1: (_, 'b, _, _, _) t -> 'b
  val get_2: (_, _, 'c, _, _) t -> 'c
  val get_3: (_, _, _, 'd, _) t -> 'd
  val get_4: (_, _, _, _, 'e) t -> 'e

  val flip: ('a, 'b, 'c, 'd, 'e) t -> ('e, 'd, 'c, 'b, 'a) t
end

(* Specializations of fixed-size containers *)

module IntOption: sig
  include module type of Option.Specialize(Int)
end

module FloatOption: sig
  include module type of Option.Specialize(Float)
end

module StringOption: sig
  include module type of Option.Specialize(String)
end

(* @feature BoolOption, with tri-bool operations (None == "unknown") as functions and as operators *)

module IntReference: sig
  type t = int Reference.t

  module O: sig
    include module type of Reference.SpecializeOperators(Int) with type t := t
    include module type of Reference.SpecializeRingoidOperators(Int) with type t := t
  end

  include module type of Reference.Specialize(Int) with type t := t and module O := O
  include module type of Reference.SpecializePredSucc(Int) with type t := t
  include module type of Reference.SpecializeRingoid(Int) with type t := t and module O := O
end

module FloatReference: sig
  type t = float Reference.t

  module O: sig
    include module type of Reference.SpecializeOperators(Float) with type t := t
    include module type of Reference.SpecializeRingoidOperators(Float) with type t := t
  end

  include module type of Reference.Specialize(Float) with type t := t and module O := O
  include module type of Reference.SpecializeRingoid(Float) with type t := t and module O := O
end

module StringReference: sig
  type t = string Reference.t

  module O: sig
    include module type of Reference.SpecializeOperators(String) with type t := t
    val (=^): t -> string -> unit
  end

  include module type of Reference.Specialize(String) with type t := t and module O := O
end

(* @feature BoolReference with set and reset *)
(* @feature OptionReference with := x setting to Some x and reset setting to None *)
(* @feature OptionPair.to_pair_option (Some a, Some b) -> Some (a, b) | _ -> None *)
(* @feature LazyPair.to_pair_lazy *)

(* Collection containers *)

module List: sig
  type 'a t = 'a list

  module O: sig
    val (@): 'a t -> 'a t -> 'a t
  end

  val empty: 'a t
  val singleton: 'a -> 'a t
  val of_list: 'a list -> 'a t
  val to_list: 'a t -> 'a list
  val of_array: 'a array -> 'a t
  val to_array: 'a t -> 'a array

  val size: 'a t -> int
  val is_empty: 'a t -> bool
  val head: 'a t -> 'a
  val tail: 'a t -> 'a t
  val try_head: 'a t -> 'a option
  val try_tail: 'a t -> 'a t option

  val contains: 'a t -> 'a -> equal_a:('a -> 'a -> bool) -> bool

  module Poly: sig
    val contains: 'a t -> 'a -> bool
  end

  val prepend: 'a -> 'a t -> 'a t
  val reverse: 'a t -> 'a t
  val concat: 'a t -> 'a t -> 'a t

  include Traits.Representable.S1 with type 'a t := 'a t
  include Traits.Equatable.S1 with type 'a t := 'a t
  include Traits.FilterMapable.S1 with type 'a t := 'a t
  include Traits.Foldable.S1 with type 'a t := 'a t
  include Traits.Foldable.Short.S1 with type 'a t := 'a t
  (* include Traits.Foldable.Right.S1 with type 'a t := 'a t *)
  (* include Traits.Foldable.Short.Right.S1 with type 'a t := 'a t *)
  include Traits.Scanable.S1 with type 'a t := 'a t
  include Traits.Scanable.Short.S1 with type 'a t := 'a t
  (* include Traits.Scanable.Right.S1 with type 'a t := 'a t *)
  (* include Traits.Scanable.Short.Right.S1 with type 'a t := 'a t *)

  module Two: sig
    val to_pair_list: 'a t -> 'b t -> ('a * 'b) t
    val to_pair_list_short: 'a t -> 'b t -> ('a * 'b) t
  end

  module Specialize(A: sig type t end): sig
    type t = A.t list

    module O: sig
      val (@): t -> t -> t
    end

    val empty: t
    val singleton: A.t -> t
    val of_list: A.t list -> t
    val to_list: t -> A.t list
    val of_array: A.t array -> t
    val to_array: t -> A.t array

    val size: t -> int
    val is_empty: t -> bool
    val head: t -> A.t
    val tail: t -> t
    val try_head: t -> A.t option
    val try_tail: t -> t option

    val prepend: A.t -> t -> t
    val reverse: t -> t
    val concat: t -> t -> t

    include Traits.FilterMapable.S0 with type elt := A.t and type t := t
    include Traits.Foldable.S0 with type elt := A.t and type t := t
    include Traits.Foldable.Short.S0 with type elt := A.t and type t := t
    (* include Traits.Foldable.Right.S0 with type elt := A.t and type t := t *)
    (* include Traits.Foldable.Short.Right.S0 with type elt := A.t and type t := t *)
    include Traits.Scanable.S0 with type elt := A.t and type t := t
    include Traits.Scanable.Short.S0 with type elt := A.t and type t := t
    (* include Traits.Scanable.Right.S0 with type elt := A.t and type t := t *)
    (* include Traits.Scanable.Short.Right.S0 with type elt := A.t and type t := t *)

    module ToList: sig
      include Traits.FilterMapable.ToList.S0 with type elt := A.t and type t := t
      include Traits.Scanable.ToList.S0 with type elt := A.t and type t := t
      include Traits.Scanable.Short.ToList.S0 with type elt := A.t and type t := t
      (* include Traits.Scanable.Right.ToList.S0 with type elt := A.t and type t := t *)
      (* include Traits.Scanable.Short.Right.ToList.S0 with type elt := A.t and type t := t *)
    end
  end

  module SpecializeEquatable(A: Traits.Equatable.Basic.S0): sig
    type t = A.t list

    val contains: t -> A.t -> bool
  end

  module SpecializeRepresentable(A: Traits.Representable.S0): Traits.Representable.S0 with type t = A.t list
end

module Array: sig
  type 'a t = 'a array

  (* @todo Implement *)

  val empty: 'a t
  val singleton: 'a -> 'a t
  val repeat: 'a -> size:int -> 'a t
  val of_list: 'a list -> 'a t
  val to_list: 'a t -> 'a list
  val of_array: 'a array -> 'a t
  val to_array: 'a t -> 'a array

  val size: 'a t -> int
  val get: 'a t -> int -> 'a
  val set: 'a t -> int -> 'a -> unit
end

module Stream: sig
  type 'a t = 'a Pervasives.OCamlStandard.Stream.t

  val empty: 'a t
  val singleton: 'a -> 'a t

  val to_list: 'a t -> 'a list
  val of_list: 'a list -> 'a t

  val prepend: 'a -> 'a t -> 'a t
  val concat: 'a t -> 'a t -> 'a t

  include Traits.FilterMapable.S1 with type 'a t := 'a t
  (* @feature Other iteration traits: Foldable and Scanable *)

  module ToList: sig
    include Traits.FilterMapable.ToList.S1 with type 'a t := 'a t
  end

  (* @feature module Specialize (with ToList and ToStream) *)
end

module SortedSet: sig
  module Poly: sig
    type 'a t

    val empty: 'a t

    val of_list: 'a list -> 'a t
    val to_list: 'a t -> 'a list

    val is_empty: 'a t -> bool
    val size: 'a t -> int

    val add: 'a t -> v:'a -> bool * 'a t
    val replace: 'a t -> v:'a -> 'a t
    val remove: 'a t -> v:'a -> bool * 'a t

    val contains: 'a t -> v:'a -> bool

    (* @feature Traits *)
  end

  module Make(E: Traits.Comparable.Basic.S0): sig
    type t

    val empty: t

    val of_list: E.t list -> t
    val to_list: t -> E.t list

    val is_empty: t -> bool
    val size: t -> int

    val add: t -> v:E.t -> bool * t
    val replace: t -> v:E.t -> t
    val remove: t -> v:E.t -> bool * t

    val contains: t -> v:E.t -> bool

    (* @feature Traits *)
  end
end

module SortedMap: sig
  module Poly: sig
    type ('a, 'b) t

    val empty: ('a, 'b) t
    val singleton: k:'a -> v:'b -> ('a, 'b) t

    (* val of_list_unique: ('a * 'b) list -> ('a, 'b) t *)
    (* val try_of_list_unique: ('a * 'b) list -> ('a, 'b) t option *)
    val of_list_first: ('a * 'b) list -> ('a, 'b) t
    val of_list_last: ('a * 'b) list -> ('a, 'b) t
    val of_list_reduce: ('a * 'b) list -> f:('a -> 'b -> 'b -> 'b) -> ('a, 'b) t
    val to_list: ('a, 'b) t -> ('a * 'b) list

    val is_empty: ('a, 'b) t -> bool
    val size: ('a, 'b) t -> int

    val add: ('a, 'b) t -> k:'a -> v:'b -> bool * ('a, 'b) t
    val replace: ('a, 'b) t -> k:'a -> v:'b -> ('a, 'b) t
    val remove: ('a, 'b) t -> k:'a -> bool * ('a, 'b) t

    val try_get: ('a, 'b) t -> k:'a -> 'b option
    val get: ('a, 'b) t -> k:'a -> 'b

    (* @feature [try_](smallest|largest): ('a, 'b) t -> ('a, 'b) [option] returning (k, v) with smallest (largest) k *)

    (* @feature Traits *)
  end

  module Make(K: Traits.Comparable.Basic.S0): sig
    type 'a t

    val empty: 'a t
    val singleton: k:K.t -> v:'a -> 'a t

    (* @feature [try_]of_list_unique, of_list_reduce *)
    val of_list_first: (K.t * 'a) list -> 'a t
    val of_list_last: (K.t * 'a) list -> 'a t
    val of_list_reduce: (K.t * 'a) list -> f:(K.t -> 'a -> 'a -> 'a) -> 'a t
    val to_list: 'a t -> (K.t * 'a) list

    val is_empty: 'a t -> bool
    val size: 'a t -> int

    val add: 'a t -> k:K.t -> v:'a -> bool * 'a t
    val replace: 'a t -> k:K.t -> v:'a -> 'a t
    val remove: 'a t -> k:K.t -> bool * 'a t

    val try_get: 'a t -> k:K.t -> 'a option
    val get: 'a t -> k:K.t -> 'a

    (* @feature Traits *)
  end
end

module Heap: sig
  module Poly: sig
    type 'a t

    val empty: 'a t

    (* val of_list: 'a list -> 'a t *)
    (* val to_list: 'a t -> 'a list *)

    (* val is_empty: 'a t -> bool *)
    (* val size: 'a t -> int *)

    val add: 'a t -> v:'a -> 'a t
    val pop_max: 'a t -> 'a t
    val max: 'a t -> 'a
  end

  module Make(E: Traits.Comparable.Basic.S0): sig
    type t

    val empty: t

    val add: t -> v:E.t -> t
    val pop_max: t -> t
    val max: t -> E.t
  end
end

module PriorityQueue: sig
  module Poly: sig
    type ('a, 'b) t

    val empty: ('a, 'b) t

    val is_empty: ('a, 'b) t -> bool

    val add: ('a, 'b) t -> k:'a -> v:'b -> ('a, 'b) t
    val pop_max: ('a, 'b) t -> ('a, 'b) t
    val max: ('a, 'b) t -> 'a * 'b
  end

  module Make(K: Traits.Comparable.Basic.S0): sig
    type 'a t

    val empty: 'a t

    val is_empty: 'a t -> bool

    val add: 'a t -> k:K.t -> v:'a -> 'a t
    val pop_max: 'a t -> 'a t
    val max: 'a t -> K.t * 'a
  end
end

(* @feature SortedList, UniqueList? *)
(* @feature Double-ended queue *)
(* @feature HashSet, HashMap *)
(* @feature SortedMultiSet, SortedMultiMap, HashMultiSet, HashMultiMap *)
(* [Sorted|Hash][Multi]Index (a Map where the keys are computed from the values (think "vertex_by_name")) *)

(* Specializations of collection containers *)

module IntRange: sig
  type t

  include Concepts.Identifiable.S0 with type t := t
  (* @feature Add Comparable to make it Able
  Warning: compare r1 r2 should always be equal to List.compare (to_list r1) (to_list r2), so Compare.Poly will not work. *)

  val empty: t
  val make: ?start:int -> ?step:int -> int -> t

  val to_list: t -> int list
  val to_array: t -> int array

  include Traits.Foldable.S0 with type elt := int and type t := t
  include Traits.Foldable.Short.S0 with type elt := int and type t := t

  module ToList: sig
    include Traits.FilterMapable.ToList.S0 with type elt := int and type t := t
    include Traits.Scanable.ToList.S0 with type elt := int and type t := t
    include Traits.Scanable.Short.ToList.S0 with type elt := int and type t := t
  end
end

module IntList: sig
  include module type of List.Specialize(Int)
  include module type of List.SpecializeEquatable(Int) with type t := t
  include module type of List.SpecializeRepresentable(Int) with type t := t
end

module FloatList: sig
  include module type of List.Specialize(Float)
  include module type of List.SpecializeEquatable(Float) with type t := t
end

module StringList: sig
  include module type of List.Specialize(String)
  include module type of List.SpecializeEquatable(String) with type t := t

  val join: ?sep:string -> t -> string
end

module IntSortedSet: sig
  include module type of SortedSet.Make(Int)
end

module FloatSortedSet: sig
  include module type of SortedSet.Make(Float)
end

module StringSortedSet: sig
  include module type of SortedSet.Make(String)
end

module CharSortedSet: sig
  include module type of SortedSet.Make(Char)
end

module IntSortedMap: sig
  include module type of SortedMap.Make(Int)
end

module FloatSortedMap: sig
  include module type of SortedMap.Make(Float)
end

module StringSortedMap: sig
  include module type of SortedMap.Make(String)
end

module CharSortedMap: sig
  include module type of SortedMap.Make(Char)
end

(* @feature XxxList when Xxx is a Ringoid: add sum, product *)
(* @feature BoolList (with all, exists, etc.) *)
(* @feature OptionList (with first_some, values (ie filter_some)) *)
(* @feature ListList, ArrayArray, StreamStream with val flatten: 'a t t -> 'a t *)
(* @feature LazyList.to_list_lazy *)

(* Input/output *)

module Format: sig
  type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6

  (* From Pervasives:
  type ('a, 'b, 'c, 'd) format4 = ('a, 'b, 'c, 'c, 'c, 'd) format6
  type ('a, 'b, 'c) format = ('a, 'b, 'c, 'c, 'c, 'c) format6 *)

  val with_result: ('b, unit, string, string, string, 'a) t -> f:(string -> 'a) -> 'b

  val apply: ('a, unit, string, string, string, string) t -> 'a

  val to_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> string

  val of_string: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('a, 'b, 'c, 'd, 'e, 'f) t

  val concat: ('a, 'b, 'c, 'd, 'e, 'f) t -> ('f, 'b, 'c, 'e, 'g, 'h) t -> ('a, 'b, 'c, 'd, 'g, 'h) t

  val with_scan_result: ('a, Pervasives.OCamlStandard.Scanf.Scanning.scanbuf, 'b, 'c -> 'd, 'a -> 'e, 'e) t -> f:'c -> string -> 'd
end

module InChannel: sig
  type t = Pervasives.OCamlStandard.Pervasives.in_channel

  (* @feature val lines: string Stream.t *)
end

module InFile: sig
  type t

  (* @todo Open modes *)
  val with_file: string -> f:(t -> 'a) -> 'a
  val with_channel: string -> f:(InChannel.t -> 'a) -> 'a

  val channel: t -> InChannel.t

  val seek: t -> pos:int64 -> unit
  val pos: t -> int64
  val size: t -> int64
end

module OutChannel: sig
  type t = Pervasives.OCamlStandard.Pervasives.out_channel

  val print: ?flush:bool -> t -> ('a, t, unit, unit, unit, unit) Format.t -> 'a
  val output: t -> bytes -> unit
  val flush: t -> unit
end

module OutFile: sig
  type t

  (* @todo Open modes *)
  val with_file: string -> f:(t -> 'a) -> 'a
  val with_channel: string -> f:(OutChannel.t -> 'a) -> 'a

  val channel: t -> OutChannel.t

  val seek: t -> pos:int64 -> unit
  val pos: t -> int64
  val size: t -> int64
end

module StdIn: sig
  val channel: InChannel.t
end

module StdOut: sig
  val channel: OutChannel.t
  val print: ?flush:bool -> ('a, OutChannel.t, unit, unit, unit, unit) Format.t -> 'a
  val output: bytes -> unit
  val flush: unit -> unit
end

module StdErr: sig
  val channel: OutChannel.t
  val print: ?flush:bool -> ('a, OutChannel.t, unit, unit, unit, unit) Format.t -> 'a
  val output: bytes -> unit
  val flush: unit -> unit
end

(* Testing *)

module Testing: sig
  module Result: sig
    module Status: sig
      type failure

      type t =
        | Success
        | Failure of failure
        | Error of exn * CallStack.t option

      val to_string: t -> string
    end

    type single = {
      label: string;
      status: Status.t;
    }

    module Counts: sig
      type t = {
        successes: int;
        failures: int;
        errors: int;
      }
    end

    type group = {
      name: string;
      children: t list;
      counts: Counts.t;
    }

    and t =
      | Single of single
      | Group of group
  end

  module Test: sig
    type t

    val run: ?record_backtrace:bool -> t -> Result.t
  end

  val command_line_main: argv:string list -> Test.t -> Exit.t

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
end

(** Modules to be opened *)

module Standard: sig
  (** This modules defines aliases for all standard modules in :mod:`General`: *)

  module Testing = Testing

  module Array = Array
  module BigInt = BigInt
  module Bool = Bool
  module Bytes = Bytes
  module CallStack = CallStack
  module Char = Char
  module Exception = Exception
  module Exit = Exit
  module Float = Float
  module Format = Format
  module Function1 = Function1
  module Function2 = Function2
  module Function3 = Function3
  module Function4 = Function4
  module Function5 = Function5
  module Heap = Heap
  module InChannel = InChannel
  module InFile = InFile
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Lazy = Lazy
  module List = List
  module NativeInt = NativeInt
  module Option = Option
  module OutChannel = OutChannel
  module OutFile = OutFile
  module PriorityQueue = PriorityQueue
  module Reference = Reference
  module SortedMap = SortedMap
  module SortedSet = SortedSet
  module StdErr = StdErr
  module StdIn = StdIn
  module StdOut = StdOut
  module Stream = Stream
  module String = String
  module Tuple2 = Tuple2
  module Tuple3 = Tuple3
  module Tuple4 = Tuple4
  module Tuple5 = Tuple5
  module Unit = Unit

  module IntRange = IntRange

  module FloatOption = FloatOption
  module IntOption = IntOption
  module StringOption = StringOption

  module FloatReference = FloatReference
  module IntReference = IntReference
  module StringReference = StringReference

  module FloatList = FloatList
  module IntList = IntList
  module StringList = StringList

  module CharSortedSet = CharSortedSet
  module FloatSortedSet = FloatSortedSet
  module IntSortedSet = IntSortedSet
  module StringSortedSet = StringSortedSet

  module CharSortedMap = CharSortedMap
  module FloatSortedMap = FloatSortedMap
  module IntSortedMap = IntSortedMap
  module StringSortedMap = StringSortedMap

  (** It also includes :mod:`General.Pervasives`. *)

  include module type of Pervasives[@remove_aliases]
  with module Array := Array
  and module Bytes := Bytes
  and module Char := Char
  
# 1650 "General.cppo.mli"
  and module Format := Format
  and module Int32 := Int32
  and module Int64 := Int64
  and module Lazy := Lazy
  and module List := List
  and module Stream := Stream
  and module String := String
  [@@autodoc.hide]
end

module Abbr: sig
  (** This modules defines abbreviated aliases for all standard modules in :mod:`General`: *)

  module Tst = Testing

  module Ar = Array
  module BigInt = BigInt
  module Bo = Bool
  module By = Bytes
  module CallStack = CallStack
  module Ch = Char
  module Exit = Exit
  module Exn = Exception
  module Fl = Float
  module Frmt = Format
  module Fun1 = Function1
  module Fun2 = Function2
  module Fun3 = Function3
  module Fun4 = Function4
  module Fun5 = Function5
  module Heap = Heap
  module InCh = InChannel
  module InFile = InFile
  module Int = Int
  module Int32 = Int32
  module Int64 = Int64
  module Laz = Lazy
  module Li = List
  module NativeInt = NativeInt
  module Opt = Option
  module OutCh = OutChannel
  module OutFile = OutFile
  module PriQu = PriorityQueue
  module Ref = Reference
  module SoMap = SortedMap
  module SoSet = SortedSet
  module StdErr = StdErr
  module StdIn = StdIn
  module StdOut = StdOut
  module Str = String
  module Strm = Stream
  module Tu2 = Tuple2
  module Tu3 = Tuple3
  module Tu4 = Tuple4
  module Tu5 = Tuple5
  module Unit = Unit

  module IntRa = IntRange

  module FlOpt = FloatOption
  module IntOpt = IntOption
  module StrOpt = StringOption

  module FlRef = FloatReference
  module IntRef = IntReference
  module StrRef = StringReference

  module FlLi = FloatList
  module IntLi = IntList
  module StrLi = StringList

  module ChSoSet = CharSortedSet
  module FlSoSet = FloatSortedSet
  module IntSoSet = IntSortedSet
  module StrSoSet = StringSortedSet

  module ChSoMap = CharSortedMap
  module FlSoMap = FloatSortedMap
  module IntSoMap = IntSortedMap
  module StrSoMap = StringSortedMap

  (** It also includes :mod:`General.Pervasives`. *)

  include module type of Pervasives[@remove_aliases]
  with module Int32 := Int32
  and module Int64 := Int64
  [@@autodoc.hide]
end

(* @todo Remove from interface, or make a functor, to avoid linking tests in client applications *)
module Tests: sig
  val test: Testing.Test.t
end [@@autodoc.hide]
