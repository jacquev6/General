# 1 "General.cppo.ml"
module Reset = struct













  
# 5 "General.cppo.ml"
  module ResetPervasives = struct
# 1 "Reset/ResetPervasives.ml"
(* Exceptions *)
# 2 "Reset/ResetPervasives.ml"
 let raise = ` Please_use_General__Exception__raise  
# 3 "Reset/ResetPervasives.ml"
 let raise_notrace = ` Please_use_General__Exception__raise_without_backtrace  
# 4 "Reset/ResetPervasives.ml"
 let invalid_arg = ` Please_use_General__Exception__invalid_argument  
# 5 "Reset/ResetPervasives.ml"
 let failwith = ` Please_use_General__Exception__failure  
# 6 "Reset/ResetPervasives.ml"
(* exception Exit *)

(* Comparisons *)
# 9 "Reset/ResetPervasives.ml"
 let (=) = ` Please_use_General__Equate__Poly__equal  
# 10 "Reset/ResetPervasives.ml"
 let (<>) = ` Please_use_General__Equate__Poly__different  
# 11 "Reset/ResetPervasives.ml"
 let (<) = ` Please_use_General__Compare__Poly__less_than  
# 12 "Reset/ResetPervasives.ml"
 let (>) = ` Please_use_General__Compare__Poly__greater_than  
# 13 "Reset/ResetPervasives.ml"
 let (<=) = ` Please_use_General__Compare__Poly__less_or_equal  
# 14 "Reset/ResetPervasives.ml"
 let (>=) = ` Please_use_General__Compare__Poly__greater_or_equal  
# 15 "Reset/ResetPervasives.ml"
 let compare = ` Please_use_General__Compare__Poly__compare  
# 16 "Reset/ResetPervasives.ml"
 let min = ` Please_use_General__Compare__Poly__min  
# 17 "Reset/ResetPervasives.ml"
 let max = ` Please_use_General__Compare__Poly__max  
# 18 "Reset/ResetPervasives.ml"
 let (==) = ` Please_use_General__Equate__Phys__equal  
# 19 "Reset/ResetPervasives.ml"
 let (!=) = ` Please_use_General__Equate__Phys__different  

# 21 "Reset/ResetPervasives.ml"
(* Boolean operations *)
# 22 "Reset/ResetPervasives.ml"
 let not = ` Please_use_General__Bool__not  
# 23 "Reset/ResetPervasives.ml"
 let (&&) = ` Please_use_General__Bool__and_  
# 24 "Reset/ResetPervasives.ml"
 let (||) = ` Please_use_General__Bool__or_  
# 25 "Reset/ResetPervasives.ml"
[@@@ocaml.warning "-3"]
# 26 "Reset/ResetPervasives.ml"
 let (&) = ` Please_use_General__Bool__and_  
# 27 "Reset/ResetPervasives.ml"
 let (or) = ` Please_use_General__Bool__or_  
# 28 "Reset/ResetPervasives.ml"
[@@@ocaml.warning "+3"]

(* Debugging *)
(* Nothing to reset *)

(* Composition operators *)
# 34 "Reset/ResetPervasives.ml"
 let (|>) = ` Please_use_General__Function1__rev_apply  
# 35 "Reset/ResetPervasives.ml"
 let (@@) = ` Please_use_General__Function1__apply  

# 37 "Reset/ResetPervasives.ml"
(* Integer arithmetics *)
# 38 "Reset/ResetPervasives.ml"
 let (~-) = ` Please_use_General__Int__negate  
# 39 "Reset/ResetPervasives.ml"
 let (~+) = ` Please_use_General__Function1__identity  
# 40 "Reset/ResetPervasives.ml"
 let succ = ` Please_use_General__Int__succ  
# 41 "Reset/ResetPervasives.ml"
 let pred = ` Please_use_General__Int__pred  
# 42 "Reset/ResetPervasives.ml"
 let (+) = ` Please_use_General__Int__add  
# 43 "Reset/ResetPervasives.ml"
 let (-) = ` Please_use_General__Int__substract  
# 44 "Reset/ResetPervasives.ml"
 let ( * ) = ` Please_use_General__Int__multiply  
# 45 "Reset/ResetPervasives.ml"
 let (/) = ` Please_use_General__Int__divide  
# 46 "Reset/ResetPervasives.ml"
 let (mod) = ` Please_use_General__Int__modulo  
# 47 "Reset/ResetPervasives.ml"
 let abs = ` Please_use_General__Int__abs  
# 48 "Reset/ResetPervasives.ml"
 let max_int = ` Please_use_General__Int__greatest  
# 49 "Reset/ResetPervasives.ml"
 let min_int = ` Please_use_General__Int__smallest  

# 51 "Reset/ResetPervasives.ml"
(* Bitwise operations *)
# 52 "Reset/ResetPervasives.ml"
 let (land) = ` Please_use_General__Int__Bitwise__logical_and  
# 53 "Reset/ResetPervasives.ml"
 let (lor) = ` Please_use_General__Int__Bitwise__logical_or  
# 54 "Reset/ResetPervasives.ml"
 let (lxor) = ` Please_use_General__Int__Bitwise__logical_xor  
# 55 "Reset/ResetPervasives.ml"
 let lnot = ` Please_use_General__Int__Bitwise__logical_not  
# 56 "Reset/ResetPervasives.ml"
 let (lsl) = ` Please_use_General__Int__Bitwise__logical_shift_left  
# 57 "Reset/ResetPervasives.ml"
 let (lsr) = ` Please_use_General__Int__Bitwise__logical_shift_right  
# 58 "Reset/ResetPervasives.ml"
 let (asr) = ` Please_use_General__Int__Bitwise__arithmetic_shift_right  

# 60 "Reset/ResetPervasives.ml"
(* Floating-point arithmetic *)
# 61 "Reset/ResetPervasives.ml"
 let (~-.) = ` Please_use_General__Float__negate  
# 62 "Reset/ResetPervasives.ml"
 let (~+.) = ` Please_use_General__Function1__identity  
# 63 "Reset/ResetPervasives.ml"
 let (+.) = ` Please_use_General__Float__add  
# 64 "Reset/ResetPervasives.ml"
 let (-.) = ` Please_use_General__Float__substract  
# 65 "Reset/ResetPervasives.ml"
 let ( *. ) = ` Please_use_General__Float__multiply  
# 66 "Reset/ResetPervasives.ml"
 let (/.) = ` Please_use_General__Float__divide  
# 67 "Reset/ResetPervasives.ml"
 let ( ** ) = ` Please_use_General__Float__exponentiate  
# 68 "Reset/ResetPervasives.ml"
 let sqrt = ` Please_use_General__Float__sqrt  
# 69 "Reset/ResetPervasives.ml"
 let exp = ` Please_use_General__Float__exp  
# 70 "Reset/ResetPervasives.ml"
 let log = ` Please_use_General__Float__log  
# 71 "Reset/ResetPervasives.ml"
 let log10 = ` Please_use_General__Float__log10  
# 72 "Reset/ResetPervasives.ml"
 let expm1 = ` Please_use_General__Float__expm1  
# 73 "Reset/ResetPervasives.ml"
 let log1p = ` Please_use_General__Float__log1p  
# 74 "Reset/ResetPervasives.ml"
 let cos = ` Please_use_General__Float__cos  
# 75 "Reset/ResetPervasives.ml"
 let sin = ` Please_use_General__Float__sin  
# 76 "Reset/ResetPervasives.ml"
 let tan = ` Please_use_General__Float__tan  
# 77 "Reset/ResetPervasives.ml"
 let acos = ` Please_use_General__Float__acos  
# 78 "Reset/ResetPervasives.ml"
 let asin = ` Please_use_General__Float__asin  
# 79 "Reset/ResetPervasives.ml"
 let atan = ` Please_use_General__Float__atan  
# 80 "Reset/ResetPervasives.ml"
 let atan2 = ` Please_use_General__Float__atan2  
# 81 "Reset/ResetPervasives.ml"
 let hypot = ` Please_use_General__Float__hypot  
# 82 "Reset/ResetPervasives.ml"
 let cosh = ` Please_use_General__Float__cosh  
# 83 "Reset/ResetPervasives.ml"
 let sinh = ` Please_use_General__Float__sinh  
# 84 "Reset/ResetPervasives.ml"
 let tanh = ` Please_use_General__Float__tanh  
# 85 "Reset/ResetPervasives.ml"
 let ceil = ` Please_use_General__Float__ceil  
# 86 "Reset/ResetPervasives.ml"
 let floor = ` Please_use_General__Float__floor  
# 87 "Reset/ResetPervasives.ml"
 let abs_float = ` Please_use_General__Float__abs  
# 88 "Reset/ResetPervasives.ml"
 let copysign = ` Please_use_General__Float__copy_sign  
# 89 "Reset/ResetPervasives.ml"
 let mod_float = ` Please_use_General__Float__modulo  
# 90 "Reset/ResetPervasives.ml"
 let frexp = ` Please_use_General__Float__to_parts  
# 91 "Reset/ResetPervasives.ml"
 let ldexp = ` Please_use_General__Float__of_parts  
# 92 "Reset/ResetPervasives.ml"
 let modf = ` Please_use_General__Float__to_fractional_and_integral  
# 93 "Reset/ResetPervasives.ml"
 let float = ` Please_use_General__Float__of_int  
# 94 "Reset/ResetPervasives.ml"
 let float_of_int = ` Please_use_General__Float__of_int  
# 95 "Reset/ResetPervasives.ml"
 let truncate = ` Please_use_General__Int__of_float  
# 96 "Reset/ResetPervasives.ml"
 let int_of_float = ` Please_use_General__Int__of_float  
# 97 "Reset/ResetPervasives.ml"
 let infinity = ` Please_use_General__Float__infinity  
# 98 "Reset/ResetPervasives.ml"
 let neg_infinity = ` Please_use_General__Float__negative_infinity  
# 99 "Reset/ResetPervasives.ml"
 let nan = ` Please_use_General__Float__not_a_number  
# 100 "Reset/ResetPervasives.ml"
 let max_float = ` Please_use_General__Float__smallest  
# 101 "Reset/ResetPervasives.ml"
 let min_float = ` Please_use_General__Float__greatest  
# 102 "Reset/ResetPervasives.ml"
 let epsilon_float = ` Please_use_General__Float__epsilon  
# 103 "Reset/ResetPervasives.ml"
 type fpclass = [` Please_use_General__Float__Class__t ] 
# 104 "Reset/ResetPervasives.ml"
 let classify_float = ` Please_use_General__Float__Class__of_float  

# 106 "Reset/ResetPervasives.ml"
(* String operations *)
# 107 "Reset/ResetPervasives.ml"
 let (^) = ` Please_use_General__String__concat  

# 109 "Reset/ResetPervasives.ml"
(* Character operations *)
# 110 "Reset/ResetPervasives.ml"
 let int_of_char = ` Please_use_General__Char__of_int  
# 111 "Reset/ResetPervasives.ml"
 let char_of_int = ` Please_use_General__Char__to_int  

# 113 "Reset/ResetPervasives.ml"
(* Unit operations *)
# 114 "Reset/ResetPervasives.ml"
 let ignore = ` Please_use_General__Unit__ignore  

# 116 "Reset/ResetPervasives.ml"
(* String conversion functions *)
# 117 "Reset/ResetPervasives.ml"
 let string_of_bool = ` Please_use_General__Bool__to_string  
# 118 "Reset/ResetPervasives.ml"
 let bool_of_string = ` Please_use_General__Bool__of_string  
# 122 "Reset/ResetPervasives.ml"
 let string_of_int = ` Please_use_General__Int__to_string  
# 123 "Reset/ResetPervasives.ml"
 let int_of_string = ` Please_use_General__Int__of_string  
# 127 "Reset/ResetPervasives.ml"
 let string_of_float = ` Please_use_General__Float__of_string  
# 128 "Reset/ResetPervasives.ml"
 let float_of_string = ` Please_use_General__Float__to_string  

# 133 "Reset/ResetPervasives.ml"
(* Pair operations *)
# 134 "Reset/ResetPervasives.ml"
 let fst = ` Please_use_General__Tuple2__get_0  
# 135 "Reset/ResetPervasives.ml"
 let snd = ` Please_use_General__Tuple2__get_1  

# 137 "Reset/ResetPervasives.ml"
(* List operations *)
# 138 "Reset/ResetPervasives.ml"
 let (@) = ` Please_use_General__List__concat  

# 140 "Reset/ResetPervasives.ml"
(* Input/output *)
# 141 "Reset/ResetPervasives.ml"
 type in_channel = [` Please_use_General__InChannel__t ] 
# 142 "Reset/ResetPervasives.ml"
 type out_channel = [` Please_use_General__OutChannel__t ] 
# 143 "Reset/ResetPervasives.ml"
 let stdin = ` Please_use_General__StdIn__channel  
# 144 "Reset/ResetPervasives.ml"
 let stdout = ` Please_use_General__StdOut__channel  
# 145 "Reset/ResetPervasives.ml"
 let stderr = ` Please_use_General__StdErr__channel  

# 147 "Reset/ResetPervasives.ml"
(* Output functions on standard output *)
# 148 "Reset/ResetPervasives.ml"
 let print_char = ` Please_use_General__StdOut__print  
# 149 "Reset/ResetPervasives.ml"
 let print_string = ` Please_use_General__StdOut__print  
# 150 "Reset/ResetPervasives.ml"
 let print_bytes = ` Please_use_General__StdOut__print  
# 151 "Reset/ResetPervasives.ml"
 let print_int = ` Please_use_General__StdOut__print  
# 152 "Reset/ResetPervasives.ml"
 let print_float = ` Please_use_General__StdOut__print  
# 153 "Reset/ResetPervasives.ml"
 let print_endline = ` Please_use_General__StdOut__print  
# 154 "Reset/ResetPervasives.ml"
 let print_newline = ` Please_use_General__StdOut__print  

# 156 "Reset/ResetPervasives.ml"
(* Output functions on standard error *)
# 157 "Reset/ResetPervasives.ml"
 let prerr_char = ` Please_use_General__StdErr__print  
# 158 "Reset/ResetPervasives.ml"
 let prerr_string = ` Please_use_General__StdErr__print  
# 159 "Reset/ResetPervasives.ml"
 let prerr_bytes = ` Please_use_General__StdErr__print  
# 160 "Reset/ResetPervasives.ml"
 let prerr_int = ` Please_use_General__StdErr__print  
# 161 "Reset/ResetPervasives.ml"
 let prerr_float = ` Please_use_General__StdErr__print  
# 162 "Reset/ResetPervasives.ml"
 let prerr_endline = ` Please_use_General__StdErr__print  
# 163 "Reset/ResetPervasives.ml"
 let prerr_newline = ` Please_use_General__StdErr__print  

# 165 "Reset/ResetPervasives.ml"
(* Input functions on standard input *)
# 166 "Reset/ResetPervasives.ml"
 let read_line = ` Please_use_General__todo  
# 167 "Reset/ResetPervasives.ml"
 let read_int = ` Please_use_General__todo  
# 168 "Reset/ResetPervasives.ml"
(* @todo Remove "ifdef" in this module: put everything in our Pervasives even if it's not in OCamlStandard.Pervasives *)
# 172 "Reset/ResetPervasives.ml"
 let read_float = ` Please_use_General__todo  

# 177 "Reset/ResetPervasives.ml"
(* General output functions *)
# 178 "Reset/ResetPervasives.ml"
 type open_flag = [` Please_use_General__todo ] 
# 179 "Reset/ResetPervasives.ml"
 let open_out = ` Please_use_General__OutFile__with_file  
# 180 "Reset/ResetPervasives.ml"
 let open_out_bin = ` Please_use_General__OutFile__with_file  
# 181 "Reset/ResetPervasives.ml"
 let open_out_gen = ` Please_use_General__OutFile__with_file  
# 182 "Reset/ResetPervasives.ml"
 let flush = ` Please_use_General__OutChannel__flush  
# 183 "Reset/ResetPervasives.ml"
 let flush_all = ` Please_use_General__todo  
# 184 "Reset/ResetPervasives.ml"
 let output_char = ` Please_use_General__OutChannel__print  
# 185 "Reset/ResetPervasives.ml"
 let output_string = ` Please_use_General__OutChannel__print  
# 186 "Reset/ResetPervasives.ml"
 let output_bytes = ` Please_use_General__OutChannel__output  
# 187 "Reset/ResetPervasives.ml"
 let output = ` Please_use_General__OutChannel__output  
# 188 "Reset/ResetPervasives.ml"
 let output_substring = ` Please_use_General__OutChannel__output  
# 189 "Reset/ResetPervasives.ml"
 let output_byte = ` Please_use_General__OutChannel__output  
# 190 "Reset/ResetPervasives.ml"
 let output_binary_int = ` Please_use_General__OutChannel__output  
# 191 "Reset/ResetPervasives.ml"
 let output_value = ` Please_use_General__OutChannel__output  
# 192 "Reset/ResetPervasives.ml"
 let seek_out = ` Please_use_General__OutFile__seek  
# 193 "Reset/ResetPervasives.ml"
 let pos_out = ` Please_use_General__OutFile__pos  
# 194 "Reset/ResetPervasives.ml"
 let out_channel_length = ` Please_use_General__OutFile__size  
# 195 "Reset/ResetPervasives.ml"
 let close_out = ` Please_use_General__OutFile__with_file  
# 196 "Reset/ResetPervasives.ml"
 let close_out_noerr = ` Please_use_General__todo  
# 197 "Reset/ResetPervasives.ml"
 let set_binary_mode_out = ` Please_use_General__todo  

# 199 "Reset/ResetPervasives.ml"
(* General input functions *)
# 200 "Reset/ResetPervasives.ml"
 let open_in = ` Please_use_General__InFile__with_file  
# 201 "Reset/ResetPervasives.ml"
 let open_in_bin = ` Please_use_General__InFile__with_file  
# 202 "Reset/ResetPervasives.ml"
 let open_in_gen = ` Please_use_General__InFile__with_file  
# 203 "Reset/ResetPervasives.ml"
 let input_char = ` Please_use_General__todo  
# 204 "Reset/ResetPervasives.ml"
 let input_line = ` Please_use_General__todo  
# 205 "Reset/ResetPervasives.ml"
 let input = ` Please_use_General__todo  
# 206 "Reset/ResetPervasives.ml"
 let really_input = ` Please_use_General__todo  
# 207 "Reset/ResetPervasives.ml"
 let really_input_string = ` Please_use_General__todo  
# 208 "Reset/ResetPervasives.ml"
 let input_byte = ` Please_use_General__todo  
# 209 "Reset/ResetPervasives.ml"
 let input_binary_int = ` Please_use_General__todo  
# 210 "Reset/ResetPervasives.ml"
 let input_value = ` Please_use_General__todo  
# 211 "Reset/ResetPervasives.ml"
 let seek_in = ` Please_use_General__InFile__seek  
# 212 "Reset/ResetPervasives.ml"
 let pos_in = ` Please_use_General__InFile__pos  
# 213 "Reset/ResetPervasives.ml"
 let in_channel_length = ` Please_use_General__InFile__size  
# 214 "Reset/ResetPervasives.ml"
 let close_in = ` Please_use_General__InFile__with_file  
# 215 "Reset/ResetPervasives.ml"
 let close_in_noerr = ` Please_use_General__todo  
# 216 "Reset/ResetPervasives.ml"
 let set_binary_mode_in = ` Please_use_General__todo  

# 218 "Reset/ResetPervasives.ml"
(* Operations on large files *)
# 219 "Reset/ResetPervasives.ml"
 module LargeFile = struct 
  
# 220 "Reset/ResetPervasives.ml"
   let seek_out = ` Please_use_General__OutFile__seek  
  
# 221 "Reset/ResetPervasives.ml"
   let pos_out = ` Please_use_General__OutFile__pos  
  
# 222 "Reset/ResetPervasives.ml"
   let out_channel_length = ` Please_use_General__OutFile__size  
  
# 223 "Reset/ResetPervasives.ml"
   let seek_in = ` Please_use_General__InFile__seek  
  
# 224 "Reset/ResetPervasives.ml"
   let pos_in = ` Please_use_General__InFile__pos  
  
# 225 "Reset/ResetPervasives.ml"
   let in_channel_length = ` Please_use_General__InFile__size  
# 226 "Reset/ResetPervasives.ml"
end

(* References *)
# 229 "Reset/ResetPervasives.ml"
 type 'a ref = [` Please_use_General__Reference__t ] 
# 230 "Reset/ResetPervasives.ml"
 let ref = ` Please_use_General__Reference__of_contents  
# 231 "Reset/ResetPervasives.ml"
 let (!) = ` Please_use_General__Reference__contents  
# 232 "Reset/ResetPervasives.ml"
 let (:=) = ` Please_use_General__Reference__assign  
# 233 "Reset/ResetPervasives.ml"
 let incr = ` Please_use_General__IntReference__increment  
# 234 "Reset/ResetPervasives.ml"
 let decr = ` Please_use_General__IntReference__decrement  

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
 let string_of_format = ` Please_use_General__Format__to_string  
# 246 "Reset/ResetPervasives.ml"
 let format_of_string = ` Please_use_General__Format__of_string  
# 247 "Reset/ResetPervasives.ml"
 let (^^) = ` Please_use_General__Format__concat  

# 249 "Reset/ResetPervasives.ml"
(* Program termination *)
# 250 "Reset/ResetPervasives.ml"
 let exit = ` Please_use_General__Exit__exit  
# 251 "Reset/ResetPervasives.ml"
 let at_exit = ` Please_use_General__Exit__at_exit  

# 253 "Reset/ResetPervasives.ml"
(* The following is for system use only. Do not call directly. *)
# 254 "Reset/ResetPervasives.ml"
 let valid_float_lexem = ` Please_use_General__Standard__OCamlStandard__Pervasives__valid_float_lexem  
# 255 "Reset/ResetPervasives.ml"
 let unsafe_really_input = ` Please_use_General__Standard__OCamlStandard__Pervasives__unsafe_really_input  
# 256 "Reset/ResetPervasives.ml"
 let do_at_exit = ` Please_use_General__Standard__OCamlStandard__Pervasives__do_at_exit  
  
# 7 "General.cppo.ml"
  end

  module ResetStandardLibrary = struct
# 1 "Reset/ResetStandardLibrary.ml"
 module OCamlStandard = struct 
  
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
 module Pervasives = struct end 

# 90 "Reset/ResetStandardLibrary.ml"
 module Arg = struct end 
# 91 "Reset/ResetStandardLibrary.ml"
 module Array = struct 
  
# 92 "Reset/ResetStandardLibrary.ml"
   let get =  OCamlStandard.Array.get 
  
# 93 "Reset/ResetStandardLibrary.ml"
   let set =  OCamlStandard.Array.set 
# 94 "Reset/ResetStandardLibrary.ml"
end
# 95 "Reset/ResetStandardLibrary.ml"
 module ArrayLabels = struct end 
# 99 "Reset/ResetStandardLibrary.ml"
 module Buffer = struct end 
# 100 "Reset/ResetStandardLibrary.ml"
 module Bytes = struct end 
# 101 "Reset/ResetStandardLibrary.ml"
 module BytesLabels = struct end 
# 102 "Reset/ResetStandardLibrary.ml"
 module Callback = struct end 
# 103 "Reset/ResetStandardLibrary.ml"
 module Char = struct end 
# 104 "Reset/ResetStandardLibrary.ml"
 module Complex = struct end 
# 105 "Reset/ResetStandardLibrary.ml"
 module Digest = struct end 
# 109 "Reset/ResetStandardLibrary.ml"
 module Filename = struct end 
# 113 "Reset/ResetStandardLibrary.ml"
 module Format = struct end 
# 114 "Reset/ResetStandardLibrary.ml"
 module Gc = struct end 
# 115 "Reset/ResetStandardLibrary.ml"
 module Genlex = struct end 
# 116 "Reset/ResetStandardLibrary.ml"
 module Hashtbl = struct end 
# 117 "Reset/ResetStandardLibrary.ml"
 module Int32 = struct end 
# 118 "Reset/ResetStandardLibrary.ml"
 module Int64 = struct end 
# 119 "Reset/ResetStandardLibrary.ml"
 module Lazy = struct end 
# 120 "Reset/ResetStandardLibrary.ml"
 module Lexing = struct end 
# 121 "Reset/ResetStandardLibrary.ml"
 module List = struct end 
# 122 "Reset/ResetStandardLibrary.ml"
 module ListLabels = struct end 
# 123 "Reset/ResetStandardLibrary.ml"
 module Map = struct end 
# 124 "Reset/ResetStandardLibrary.ml"
 module Marshal = struct end 
# 125 "Reset/ResetStandardLibrary.ml"
 module MoreLabels = struct end 
# 126 "Reset/ResetStandardLibrary.ml"
 module Nativeint = struct end 
# 127 "Reset/ResetStandardLibrary.ml"
 module Oo = struct end 
# 128 "Reset/ResetStandardLibrary.ml"
 module Parsing = struct end 
# 129 "Reset/ResetStandardLibrary.ml"
 module Printexc = struct end 
# 130 "Reset/ResetStandardLibrary.ml"
 module Printf = struct end 
# 131 "Reset/ResetStandardLibrary.ml"
 module Queue = struct end 
# 132 "Reset/ResetStandardLibrary.ml"
 module Random = struct end 
# 133 "Reset/ResetStandardLibrary.ml"
 module Scanf = struct end 
# 137 "Reset/ResetStandardLibrary.ml"
 module Set = struct end 
# 138 "Reset/ResetStandardLibrary.ml"
 module Sort = struct end 
# 142 "Reset/ResetStandardLibrary.ml"
 module Stack = struct end 
# 143 "Reset/ResetStandardLibrary.ml"
 module StdLabels = struct end 
# 144 "Reset/ResetStandardLibrary.ml"
 module Stream = struct end 
# 145 "Reset/ResetStandardLibrary.ml"
 module String = struct 
  
# 146 "Reset/ResetStandardLibrary.ml"
   let get =  OCamlStandard.String.get 
  
# 147 "Reset/ResetStandardLibrary.ml"
   let set =  OCamlStandard.Bytes.set 
# 148 "Reset/ResetStandardLibrary.ml"
end
# 149 "Reset/ResetStandardLibrary.ml"
 module StringLabels = struct end 
# 150 "Reset/ResetStandardLibrary.ml"
 module Sys = struct end 
# 154 "Reset/ResetStandardLibrary.ml"
 module Weak = struct end 

# 156 "Reset/ResetStandardLibrary.ml"
 module Num = struct end 
# 157 "Reset/ResetStandardLibrary.ml"
 module Big_int = struct end 
# 158 "Reset/ResetStandardLibrary.ml"
 module Arith_status = struct end 
  
# 11 "General.cppo.ml"
  end

# 14 "General.cppo.ml"
end

open Reset.ResetPervasives
open Reset.ResetStandardLibrary

module OCSP = OCamlStandard.Pervasives

module Equate = struct
# 1 "Equate.ml"
module Poly = struct
  let equal = OCSP.(=)
  let different = OCSP.(<>)

  module O = struct
    let (=) = OCSP.(=)
    let (<>) = OCSP.(<>)
  end
end

module Phys = struct
  let equal = OCSP.(==)
  let different = OCSP.(!=)
end
# 23 "General.cppo.ml"
end

module Compare = struct
# 1 "Compare.ml"
type t = LT | EQ | GT

let of_standard compare =
  fun x y ->
    match compare x y with
      | 0 -> EQ
      | c when OCSP.(<) c 0 -> LT
      | _ -> GT

module Poly = struct
  let compare x y = of_standard OCSP.compare x y
  let less_than = OCSP.(<)
  let less_or_equal = OCSP.(<=)
  let greater_or_equal = OCSP.(>=)
  let greater_than = OCSP.(>)

  let between x ~low ~high =
    OCSP.(&&) (less_than low x) (greater_than high x)

  let between_or_equal x ~low ~high =
    OCSP.(&&) (less_or_equal low x) (greater_or_equal high x)

  let min = OCSP.min
  let max = OCSP.max

  let min_max x y =
    match compare x y with LT -> (x, y) | GT | EQ -> (y, x)

  module O = struct
    let (<) = OCSP.(<)
    let (<=) = OCSP.(<=)
    let (>=) = OCSP.(>=)
    let (>) = OCSP.(>)
  end
end
# 27 "General.cppo.ml"
end

module Shorten = struct
# 1 "Shorten.ml"
type t =
  | GoOn
  | ShortCircuit
# 31 "General.cppo.ml"
end

module Foundations = struct
  module Format = struct
# 1 "Foundations/Format.ml"
module OCSPr = OCamlStandard.Printf
module OCSSc = OCamlStandard.Scanf

type ('a, 'b, 'c, 'd, 'e, 'f) t = ('a, 'b, 'c, 'd, 'e, 'f) OCSP.format6

let with_result format ~f =
  OCSPr.ksprintf f format

let apply format =
  OCSPr.sprintf format

let of_string = OCSP.format_of_string
let to_string = OCSP.string_of_format
let concat = OCSP.(^^)

let with_scan_result format ~f s =
  OCSSc.sscanf s format f
  
# 36 "General.cppo.ml"
  end

  module Lazy = struct
# 1 "Foundations/Lazy.ml"
type 'a t = 'a lazy_t

module OCSL = OCamlStandard.Lazy

let value = OCSL.force

let is_value = OCSL.is_val

let map x ~f =
  lazy (f (value x))
  
# 40 "General.cppo.ml"
  end

  module Exception = struct
# 1 "Foundations/Exception.ml"
type t = exn

module OCSPE = OCamlStandard.Printexc

let register_printer = OCSPE.register_printer

include Equate.Poly

exception MatchFailure = Match_failure
exception AssertFailure = Assert_failure
exception InvalidArgument = Invalid_argument
exception Failure = Failure
exception NotFound = Not_found
exception OutOfMemory = Out_of_memory
exception StackOverflow = Stack_overflow
exception SysError = Sys_error
exception EndOfFile = End_of_file
exception DivisionByZero = Division_by_zero
exception SysBlockedIO = Sys_blocked_io
exception UndefinedRecursiveModule = Undefined_recursive_module

exception Exit = OCSP.Exit

let raise = OCSP.raise
let raise_without_backtrace = OCSP.raise_notrace

let invalid_argument format =
  Format.with_result
    ~f:(fun message -> raise (InvalidArgument message))
    format

let failure format =
  Format.with_result
    ~f:(fun message -> raise (Failure message))
    format

let to_string = OCSPE.to_string
let repr = to_string

let name = OCSPE.exn_slot_name

let record_backtraces = OCSPE.record_backtrace
let recording_backtraces = OCSPE.backtrace_status

let most_recent_backtrace () =
  if recording_backtraces () then Some (OCSPE.get_raw_backtrace ()) else None

let or_none x =
  try
    Some (Lazy.value x)
  with
    | _ -> None
  
# 44 "General.cppo.ml"
  end

  module Functions = struct
# 1 "Foundations/Functions.ml"
module Function1 = struct
  type ('a, 'z) t = 'a -> 'z

  let identity x =
    x

  let apply f x =
    f x

  let rev_apply x f =
    f x

  let compose f g =
    fun x -> f (g x)

  module O = struct
    let (@@) = apply
    let (|>) = rev_apply
    let (%) = compose
  end
end

module Function2 = struct
  type ('a, 'b, 'z) t = 'a -> 'b -> 'z

  let flip f =
    fun x y ->
      f y x

  let curry f =
    fun x y ->
      f (x, y)

  let uncurry f =
    fun (x, y) ->
      f x y
end

module Function3 = struct
  type ('a, 'b, 'c, 'z) t = 'a -> 'b -> 'c -> 'z

  let flip f =
    fun x y z ->
      f z y x

  let curry f =
    fun x y z ->
      f (x, y, z)

  let uncurry f =
    fun (x, y, z) ->
      f x y z
end

module Function4 = struct
  type ('a, 'b, 'c, 'd, 'z) t = 'a -> 'b -> 'c -> 'd -> 'z

  let flip f =
    fun x y z u ->
      f u z y x

  let curry f =
    fun x y z u ->
      f (x, y, z, u)

  let uncurry f =
    fun (x, y, z, u) ->
      f x y z u
end

module Function5 = struct
  type ('a, 'b, 'c, 'd, 'e, 'z) t = 'a -> 'b -> 'c -> 'd -> 'e -> 'z

  let flip f =
    fun x y z u v ->
      f v u z y x

  let curry f =
    fun x y z u v ->
      f (x, y, z, u, v)

  let uncurry f =
    fun (x, y, z, u, v) ->
      f x y z u v
end
  
# 48 "General.cppo.ml"
  end

  module Int = struct
# 1 "Foundations/Int.ml"
type t = int

let zero = 0
let one = 1
let smallest = OCSP.min_int
let greatest = OCSP.max_int

let of_int = Functions.Function1.identity
let to_int = Functions.Function1.identity
let of_float = OCSP.int_of_float
let to_float = OCSP.float_of_int
let of_string = OCSP.int_of_string
let try_of_string s =
  Exception.or_none (lazy (of_string s))
let to_string = OCSP.string_of_int

let repr = OCSP.string_of_int

let add = OCSP.(+)
let substract = OCSP.(-)
let negate = OCSP.(~-)
let multiply = OCSP.( * )
let divide = OCSP.(/)
let square x = multiply x x
let abs = OCSP.abs
let modulo = OCSP.(mod)
let pred = OCSP.pred
let succ = OCSP.succ

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let (~-) = OCSP.(~-)
  let (~+) = OCSP.(~+)
  let (+) = OCSP.(+)
  let (-) = OCSP.(-)
  let ( * ) = OCSP.( * )
  let (/) = OCSP.(/)
  let (mod) = OCSP.(mod)
end

include (Compare.Poly: module type of Compare.Poly with module O := O)
include (Equate.Poly: module type of Equate.Poly with module O := O)

module Bitwise = struct
  let logical_and = OCSP.(land)
  let logical_or = OCSP.(lor)
  let logical_xor = OCSP.(lxor)
  let logical_not = OCSP.(lnot)
  let logical_shift_left n ~shift = OCSP.(n lsl shift)
  let logical_shift_right n ~shift = OCSP.(n lsr shift)
  let arithmetic_shift_right n ~shift = OCSP.(n asr shift)
end
  
# 52 "General.cppo.ml"
  end

  module Bool = struct
# 1 "Foundations/Bool.ml"
type t = bool

let of_string = OCSP.bool_of_string
let try_of_string s =
  Exception.or_none (lazy (of_string s))
let to_string = OCSP.string_of_bool

let repr = OCSP.string_of_bool

let xor x y =
  match (x, y) with
    | (true, false) | (false, true) -> true
    | (true, true) | (false, false) -> false

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let not = OCSP.not
  external (&&): bool -> bool -> bool = "%sequand"
  external (||): bool -> bool -> bool = "%sequor"
  let xor = xor
end

include (Compare.Poly: module type of Compare.Poly with module O:= O)
include (Equate.Poly: module type of Equate.Poly with module O:= O)

let not = OCSP.not
let and_ = OCSP.(&&)
let or_ = OCSP.(||)
  
# 56 "General.cppo.ml"
  end

  module Option = struct
# 1 "Foundations/Option.ml"
type 'a t = 'a option

let equal x y ~equal_a =
  match (x, y) with
    | (None, None) -> true
    | (None, Some _) | (Some _, None) -> false
    | (Some x, Some y) -> equal_a x y

let compare x y ~compare_a =
  match (x, y) with
    | (None, None) -> Compare.EQ
    | (None, Some _) -> Compare.LT
    | (Some _, None) -> Compare.GT
    | (Some x, Some y) -> compare_a x y

let repr x ~repr_a =
  match x with
    | None -> "None"
    | Some x -> Format.apply "Some %s" (repr_a x)

let none = None

let some x =
  Some x

let some_if condition value =
  if condition then Some (Lazy.value value) else None

let some_if' condition value =
  if condition then Some value else None

let value_def x ~def =
  match x with
    | Some x -> x
    | None -> def

let value ?(exc=Failure "Option.value") x =
  match x with
    | Some x -> x
    | None -> OCSP.raise exc

(* @todo Why does (o |> value) complain about missing ?exc, but (ss |> StrLi.join) doesn't complain about ?sep ? *)

let or_failure format =
  Format.with_result
    ~f:(fun message ->
      function
      | None ->
        Exception.(raise (Failure message))
      | Some x ->
        x
    )
    format

let map x ~f =
  match x with
    | None -> None
    | Some x -> Some (f x)

let value_map x ~def ~f =
  match x with
    | None -> def
    | Some x -> f x

let is_some = function
  | None -> false
  | Some _ -> true

let is_none = function
  | None -> true
  | Some _ -> false

let iter x ~f =
  match x with
    | None -> ()
    | Some x -> f x

let filter x ~f =
  match x with
    | None -> None
    | Some x -> some_if' (f x) x

let filter_map x ~f =
  match x with
    | None -> None
    | Some x -> (f x)
  
# 60 "General.cppo.ml"
  end

  module List = struct
# 1 "Foundations/List.ml"
module OCSA = OCamlStandard.Array

type 'a t = 'a list

open Functions.Function1.O
open Bool.O

(* @feature Add a 'Small' module with the same interface but non-terminal-recursive implementations *)

let empty = []
let singleton x = [x]
let prepend x xs = x::xs
let of_list = Functions.Function1.identity
let to_list = Functions.Function1.identity
(* @todo Test everything for stack overflow. Including to/of_array. *)
let of_array = OCSA.to_list
let to_array = OCSA.of_list

let is_empty = function
  | [] -> true
  | _ -> false

let try_head = function
  | [] -> None
  | x::_ -> Some x

let try_tail = function
  | [] -> None
  | _::xs -> Some xs

let head xs =
  try_head xs
  |> Option.or_failure "List.head"

let tail xs =
  try_tail xs
  |> Option.or_failure "List.tail"

let reverse xs =
  let rec aux ys = function
    | [] -> ys
    | x::xs -> aux (x::ys) xs
  in
  aux [] xs

let rev_concat xs ys =
  let rec aux ys = function
    | [] -> ys
    | x::xs -> aux (x::ys) xs
  in
  aux ys xs

let concat xs ys =
  rev_concat (reverse xs) ys

module O = struct
  let (@) = concat
end


let map xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs -> let y = f x in aux (y::ys) xs
  in
  aux [] xs

let map_acc ~acc xs ~f =
  let rec aux acc ys = function
    | [] -> reverse ys
    | x::xs -> let (acc, y) = f ~acc x in aux acc (y::ys) xs
  in
  aux acc [] xs

let map_i xs ~f =
  map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


let flat_map xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs -> let y = f x in aux (rev_concat y ys) xs
  in
  aux [] xs

let flat_map_acc ~acc xs ~f =
  let rec aux acc ys = function
    | [] -> reverse ys
    | x::xs -> let (acc, y) = f ~acc x in aux acc (rev_concat y ys) xs
  in
  aux acc [] xs

let flat_map_i xs ~f =
  flat_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


let filter xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs ->
      let b = f x in
      aux (if b then x::ys else ys) xs
  in
  aux [] xs

let filter_acc ~acc xs ~f =
  let rec aux acc ys = function
    | [] -> reverse ys
    | x::xs ->
      let (acc, b) = f ~acc x in
      aux acc (if b then x::ys else ys) xs
  in
  aux acc [] xs

let filter_i xs ~f =
  filter_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


let filter_map xs ~f =
  let rec aux ys = function
    | [] -> reverse ys
    | x::xs ->
      let y = f x in
      let ys = match y with
        | Some y -> y::ys
        | None -> ys
      in
      aux ys xs
  in
  aux [] xs

let filter_map_acc ~acc xs ~f =
  let rec aux acc ys = function
    | [] -> reverse ys
    | x::xs ->
      let (acc, y) = f ~acc x in
      let ys = match y with
        | Some y -> y::ys
        | None -> ys
      in
      aux acc ys xs
  in
  aux acc [] xs

let filter_map_i xs ~f =
  filter_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


let fold ~init xs ~f =
  let rec aux y = function
    | [] -> y
    | x::xs -> let y = f y x in aux y xs
  in
  aux init xs

let fold_acc ~acc ~init xs ~f =
  let rec aux acc y = function
    | [] -> y
    | x::xs -> let (acc, y) = f ~acc y x in aux acc y xs
  in
  aux acc init xs

let fold_i ~init xs ~f =
  fold_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> (Int.succ i, f ~i y x))


let try_reduce_acc ~acc xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold_acc ~acc xs ~init ~f)

let try_reduce xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold xs ~init ~f)

let try_reduce_i xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold_i xs ~init ~f)


let reduce_acc ~acc xs ~f =
  try_reduce_acc ~acc xs ~f
  |> Option.or_failure "List.reduce_acc"

let reduce xs ~f =
  try_reduce xs ~f
  |> Option.or_failure "List.reduce"

let reduce_i xs ~f =
  try_reduce_i xs ~f
  |> Option.or_failure "List.reduce_i"


let scan ~init xs ~f =
  let rec aux y ys = function
    | [] -> reverse (y::ys)
    | x::xs -> let y = f y x in aux y (y::ys) xs
  in
  aux init [] xs

let scan_acc ~acc ~init xs ~f =
  let rec aux acc y ys = function
    | [] -> reverse (y::ys)
    | x::xs -> let (acc, y) = f ~acc y x in aux acc y (y::ys) xs
  in
  aux acc init [] xs

let scan_i ~init xs ~f =
  scan_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> (Int.succ i, f ~i y x))


let iter xs ~f =
  let rec aux = function
    | [] -> ()
    | x::xs -> let () = f x in aux xs
  in
  aux xs

let iter_acc ~acc xs ~f =
  let rec aux acc = function
    | [] -> ()
    | x::xs -> let acc = f ~acc x in aux acc xs
  in
  aux acc xs

let iter_i xs ~f =
  iter_acc ~acc:0 xs ~f:(fun ~acc:i x -> f ~i x; Int.succ i)


let count xs ~f =
  fold xs ~init:0 ~f:(fun n x -> let b = f x in if b then Int.succ n else n)

let count_acc ~acc xs ~f =
  fold_acc ~acc xs ~init:0 ~f:(fun ~acc n x -> let (acc, b) = f ~acc x in (acc, if b then Int.succ n else n))

let count_i xs ~f =
  fold_i xs ~init:0 ~f:(fun ~i n x -> let b = f ~i x in if b then Int.succ n else n)


let try_find xs ~f =
  let rec aux = function
    | [] -> None
    | x::xs -> let b = f x in if b then Some x else aux xs
  in
  aux xs

let try_find_acc ~acc xs ~f =
  let rec aux acc = function
    | [] -> None
    | x::xs -> let (acc, b) = f ~acc x in if b then Some x else aux acc xs
  in
  aux acc xs

let try_find_i xs ~f =
  try_find_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


let find xs ~f =
  try_find xs ~f
  |> Option.value ~exc:Exception.NotFound

let find_acc ~acc xs ~f =
  try_find_acc ~acc xs ~f
  |> Option.value ~exc:Exception.NotFound

let find_i xs ~f =
  try_find_i xs ~f
  |> Option.value ~exc:Exception.NotFound


let there_exists xs ~f =
  try_find xs ~f
  |> Option.is_some

let there_exists_acc ~acc xs ~f =
  try_find_acc ~acc xs ~f
  |> Option.is_some

let there_exists_i xs ~f =
  try_find_i xs ~f
  |> Option.is_some


let for_all xs ~f =
  not (there_exists xs ~f:(not % f))

let for_all_acc ~acc xs ~f =
  not (there_exists_acc ~acc xs ~f:(fun ~acc x -> let (acc, b) = f ~acc x in (acc, not b)))

let for_all_i xs ~f =
  not (there_exists_i xs ~f:(fun ~i x -> not (f ~i x)))


let try_find_map xs ~f =
  let rec aux = function
    | [] -> None
    | x::xs -> let b = f x in if Option.is_some b then b else aux xs
  in
  aux xs

let try_find_map_acc ~acc xs ~f =
  let rec aux acc = function
    | [] -> None
    | x::xs -> let (acc, b) = f ~acc x in if Option.is_some b then b else aux acc xs
  in
  aux acc xs

let try_find_map_i xs ~f =
  try_find_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (Int.succ i, f ~i x))


let find_map xs ~f =
  try_find_map xs ~f
  |> Option.value ~exc:Exception.NotFound

let find_map_acc ~acc xs ~f =
  try_find_map_acc ~acc xs ~f
  |> Option.value ~exc:Exception.NotFound

let find_map_i xs ~f =
  try_find_map_i xs ~f
  |> Option.value ~exc:Exception.NotFound


let fold_short ~init xs ~f =
  let rec aux y = function
    | [] -> y
    | x::xs ->
      let (s, y) = f y x in
      match s with
        | Shorten.GoOn -> aux y xs
        | Shorten.ShortCircuit -> y
  in
  aux init xs

let fold_short_acc ~acc ~init xs ~f =
  let rec aux acc y = function
    | [] -> y
    | x::xs ->
      let (acc, s, y) = f ~acc y x in
      match s with
        | Shorten.GoOn -> aux acc y xs
        | Shorten.ShortCircuit -> y
  in
  aux acc init xs

let fold_short_i ~init xs ~f =
  fold_short_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> let (s, y) = f ~i y x in (Int.succ i, s, y))


let try_reduce_short_acc ~acc xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold_short_acc ~acc xs ~init ~f)

let try_reduce_short xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold_short xs ~init ~f)

let try_reduce_short_i xs ~f =
  match xs with
    | [] -> None
    | init::xs -> Some (fold_short_i xs ~init ~f)


let reduce_short_acc ~acc xs ~f =
  try_reduce_short_acc ~acc xs ~f
  |> Option.or_failure "List.reduce_short_acc"

let reduce_short xs ~f =
  try_reduce_short xs ~f
  |> Option.or_failure "List.reduce_short"

let reduce_short_i xs ~f =
  try_reduce_short_i xs ~f
  |> Option.or_failure "List.reduce_short_i"


let scan_short ~init xs ~f =
  let rec aux y ys = function
    | [] -> reverse (y::ys)
    | x::xs ->
      let (s, y) = f y x in
      match s with
        | Shorten.GoOn -> aux y (y::ys) xs
        | Shorten.ShortCircuit -> reverse (y::ys)
  in
  aux init [] xs

let scan_short_acc ~acc ~init xs ~f =
  let rec aux acc y ys = function
    | [] -> reverse (y::ys)
    | x::xs ->
      let (acc, s, y) = f ~acc y x in
      match s with
        | Shorten.GoOn -> aux acc y (y::ys) xs
        | Shorten.ShortCircuit -> reverse (y::ys)
  in
  aux acc init [] xs

let scan_short_i ~init xs ~f =
  scan_short_acc ~acc:0 ~init xs ~f:(fun ~acc:i y x -> let (s, y) = f ~i y x in (Int.succ i, s, y))


let iter_short xs ~f =
  let rec aux = function
    | [] -> ()
    | x::xs ->
      match f x with
        | Shorten.GoOn -> aux xs
        | Shorten.ShortCircuit -> ()
  in
  aux xs

let iter_short_acc ~acc xs ~f =
  let rec aux acc = function
    | [] -> ()
    | x::xs ->
      let (acc, s) = f ~acc x in
      match s with
        | Shorten.GoOn -> aux acc xs
        | Shorten.ShortCircuit -> ()
  in
  aux acc xs

let iter_short_i xs ~f =
  iter_short_acc ~acc:0 xs ~f:(fun ~acc:i x -> let s = f ~i x in (Int.succ i, s))


let contains xs x ~equal_a =
  there_exists xs ~f:(equal_a x)

module Poly = struct
  let contains xs x =
    let rec aux = function
      | [] -> false
      | x'::_ when Equate.Poly.equal x' x -> true
      | _::xs -> aux xs
    in
    aux xs
end

let size xs =
  let rec aux s = function
    | [] -> s
    | _::xs -> aux (Int.succ s) xs
  in
  aux 0 xs

let join_string_list ?(sep="") xs =
  xs
  |> try_reduce ~f:(fun a b -> Format.apply "%s%s%s" a sep b)
  |> Option.value_def ~def:""

let repr xs ~repr_a =
  xs
  |> map ~f:repr_a
  |> join_string_list ~sep:"; "
  |> Format.apply "[%s]"


module Two = struct
  let to_pair_list xs ys =
    let rec aux zs = function
      | ([], []) ->
        reverse zs
      | (x::xs, y::ys) ->
        aux ((x, y)::zs) (xs, ys)
      | _ ->
        Exception.invalid_argument "List.Two.to_pair_list"
    in
    aux [] (xs, ys)

  let to_pair_list_short xs ys =
    let rec aux zs = function
      | ([], _)
      | (_, []) ->
        reverse zs
      | (x::xs, y::ys) ->
        aux ((x, y)::zs) (xs, ys)
    in
    aux [] (xs, ys)
end


(* @todo Remove *)
module OCLL = OCamlStandard.ListLabels

let equal xs ys ~equal_a =
  try
    OCLL.for_all2 ~f:equal_a xs ys
  with
    | Invalid_argument _ -> false

(* @todo Make terminal recursive *)
let rec cartesian_product xs ys =
  match xs with
    | [] -> []
    | x::xs -> OCLL.append (OCLL.map ys ~f:(fun y -> (x, y))) (cartesian_product xs ys)
  
# 64 "General.cppo.ml"
  end

  module CallStack = struct
# 1 "Foundations/CallStack.ml"
module OCSPE = OCamlStandard.Printexc

type t = OCSPE.raw_backtrace

let current ?(max_size=Int.greatest) () =
  OCSPE.get_callstack max_size

let to_string = OCSPE.raw_backtrace_to_string
let repr = to_string

module Location = struct
  type t = OCSPE.location = {
    filename: string;
    line_number: int;
    start_char: int;
    end_char: int;
  }

  let repr {filename; line_number; start_char; end_char} =
    Format.apply "{filename=%S; line_number=%n; start_char=%n; end_char=%n}" filename line_number start_char end_char

  module O = struct
    include Equate.Poly.O
    include Compare.Poly.O
  end

  include (Equate.Poly: module type of Equate.Poly with module O := O)
  include (Compare.Poly: module type of Compare.Poly with module O := O)
end

module Frame = struct
  type t = OCSPE.backtrace_slot

  let is_raise = OCSPE.Slot.is_raise

  let location = OCSPE.Slot.location

  let format = OCSPE.Slot.format
end

let frames bt =
  match OCSPE.backtrace_slots bt with
    | None -> [] (*BISECT-IGNORE*) (* Would require compiling without tag debug *)
    | Some frames -> List.of_array frames
  
# 68 "General.cppo.ml"
  end

  module Float = struct
# 1 "Foundations/Float.ml"
type t = float

let zero = 0.
let one = 1.
let pi = OCSP.(4. *. atan 1.)
let e = OCSP.exp 1.
let smallest = OCSP.min_float
let greatest = OCSP.max_float
let epsilon = OCSP.epsilon_float
let infinity = OCSP.infinity
let negative_infinity = OCSP.neg_infinity
let not_a_number = OCSP.nan

let of_int = OCSP.float_of_int
let to_int = OCSP.int_of_float
let of_float = Functions.Function1.identity
let to_float = Functions.Function1.identity
let of_string = OCSP.float_of_string
let try_of_string s =
  Exception.or_none (lazy (of_string s))
let to_string = OCSP.string_of_float

let of_parts ~significand ~exponent = OCSP.ldexp significand exponent
let to_parts = OCSP.frexp

let to_fractional_and_integral = OCSP.modf

let repr = OCSP.string_of_float

let add = OCSP.(+.)
let substract = OCSP.(-.)
let negate = OCSP.(~-.)
let multiply = OCSP.( *. )
let divide = OCSP.(/.)
let square x = multiply x x
let abs = OCSP.abs_float
let modulo = OCSP.mod_float

let sqrt = OCSP.sqrt

let exp = OCSP.exp
let log = OCSP.log
let log10 = OCSP.log10
let expm1 = OCSP.expm1
let log1p = OCSP.log1p

let cos = OCSP.cos
let sin = OCSP.sin
let tan = OCSP.tan
let acos = OCSP.acos
let asin = OCSP.asin
let atan = OCSP.atan
let atan2 ~y ~x = OCSP.atan2 y x
let hypot = OCSP.hypot
let cosh = OCSP.cosh
let sinh = OCSP.sinh
let tanh = OCSP.tanh

let ceil = OCSP.ceil
let floor = OCSP.floor
let copy_sign x ~sign = OCSP.copysign x sign

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let (~-) = OCSP.(~-.)
  let (~+) = OCSP.(~+.)
  let (+) = OCSP.(+.)
  let (-) = OCSP.(-.)
  let ( * ) = OCSP.( *. )
  let (/) = OCSP.(/.)
  let (mod) = OCSP.mod_float
end

include (Compare.Poly: module type of Compare.Poly with module O := O)
include (Equate.Poly: module type of Equate.Poly with module O := O)

let approx_equal ?(precision=1e-10) a b =
  less_than (abs (substract a b)) precision

module O_dot = struct
  let (~-.) = OCSP.(~-.)
  let (~+.) = OCSP.(~+.)
  let (+.) = OCSP.(+.)
  let (-.) = OCSP.(-.)
  let ( *. ) = OCSP.( *. )
  let (/.) = OCSP.(/.)
  let ( ** ) = OCSP.( ** )
end

module Class = struct
  type t =
    | Normal
    | SubNormal
    | Zero
    | Infinite
    | NotANumber

  let of_float x =
    match OCSP.classify_float x with
      | OCSP.FP_normal -> Normal
      | OCSP.FP_subnormal -> SubNormal
      | OCSP.FP_zero -> Zero
      | OCSP.FP_infinite -> Infinite
      | OCSP.FP_nan -> NotANumber

  let repr = function
    | Normal -> "Normal"
    | SubNormal -> "SubNormal"
    | Zero -> "Zero"
    | Infinite -> "Infinite"
    | NotANumber -> "NotANumber"

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)
end
  
# 72 "General.cppo.ml"
  end

  module Reference = struct
# 1 "Foundations/Reference.ml"
type 'a t = 'a OCSP.ref = {
  mutable contents: 'a;
}

let of_contents = OCSP.ref
let contents = OCSP.(!)
let assign = OCSP.(:=)

module O = struct
  let ref = OCSP.ref
  let (!) = OCSP.(!)
  let (:=) = OCSP.(:=)
end
  
# 76 "General.cppo.ml"
  end

  module String = struct
# 1 "Foundations/String.ml"
type t = string

module OCSS = OCamlStandard.String
module OCSB = OCamlStandard.Bytes
open Int.O
open Bool.O
open Functions.Function1.O
open Reference.O

let repr x =
  Format.apply "%S" x

let to_string = Functions.Function1.identity
let of_string = Functions.Function1.identity
let try_of_string = Option.some

let of_bytes = OCSB.to_string
let to_bytes = OCSB.of_string

let get = OCSS.get
let set = OCSB.set

let concat = OCSP.(^)

module O = struct
  include Compare.Poly.O
  include Equate.Poly.O

  let (^) = OCSP.(^)
end

include (Compare.Poly: module type of Compare.Poly with module O := O)
include (Equate.Poly: module type of Equate.Poly with module O := O)

let size = OCSS.length

let of_char c =
  OCSS.make 1 c

let to_list s =
  let r = ref [] in
  for i = size s - 1 downto 0 do
    r := s.[i]::!r
  done;
  !r

let of_list xs =
  let len = List.size xs in
  let r = OCSB.create len in
  xs
  |> List.iter_i ~f:(fun ~i x ->
    OCSB.set r i x
  );
  of_bytes r

let substring s ~pos ~len =
  OCSS.sub s pos len

let prefix s ~len =
  substring s ~pos:0 ~len

let suffix s ~len =
  substring s ~pos:(size s - len) ~len

let has_prefix s ~pre =
  size s >= size pre
  && pre = prefix s ~len:(size pre)

let has_suffix s ~suf =
  size s >= size suf
  && suf = suffix s ~len:(size suf)

let drop_prefix' s ~len =
  substring s ~pos:len ~len:(size s - len)

let drop_suffix' s ~len =
  substring s ~pos:0 ~len:(size s - len)

let try_drop_suffix s ~suf =
  Option.some_if
    (has_suffix s ~suf)
    (lazy (drop_suffix' s ~len:(size suf)))

let try_drop_prefix s ~pre =
  Option.some_if
    (has_prefix s ~pre)
    (lazy (drop_prefix' s ~len:(size pre)))

let drop_suffix s ~suf =
  try_drop_suffix ~suf s
  |> Option.or_failure "String.drop_suffix"

let drop_prefix s ~pre =
  try_drop_prefix ~pre s
  |> Option.or_failure "String.drop_prefix"

let split s ~sep =
  let len = size sep in
  if len = 0 then Exception.invalid_argument "String.split: empty separator";
  let match_sep ~pos =
    pos >= 0
    && substring s ~pos ~len = sep
  in
  let rec aux ret last_pos = function
    | pos when match_sep ~pos ->
      aux ((substring s ~pos:(pos + len) ~len:(last_pos - pos -len))::ret) pos (pos - len)
    | pos when pos <= 0 ->
      (substring s ~pos:0 ~len:last_pos)::ret
    | pos ->
      aux ret last_pos (pos - 1)
  in
  match aux [] (size s) ((size s) - len) with
    | [""] -> []
    | parts -> parts

let fold ~init s ~f =
  s
  |> to_list
  |> List.fold ~init ~f

let filter s ~f =
  s
  |> to_list
  |> List.filter ~f
  |> of_list
  
# 80 "General.cppo.ml"
  end

  module IntRange = struct
# 1 "Foundations/IntRange.ml"
open Int.O
open Bool.O
open Functions.Function1.O

type full = {
  min: int;
  max: int;
  step: int;
}

type t =
  | Empty
  | Ascending of full
  | Descending of full

let empty = Empty

let make ?(start=0) ?(step=1) stop =
  (* We normalize everything here, so that to_list is simpler, and Equate.Poly is appropriate *)
  if (stop - start) * step <= 0 then
    Empty
  else if step > 0 then
    let min = start
    and max = stop - 1 - (stop - 1 - start) mod step in
    assert ((max - min) mod step = 0);
    Ascending {min; max; step}
  else
    let step = -step in
    let min = stop + 1 - (stop + 1 - start) mod step
    and max = start in
    assert ((max - min) mod step = 0);
    Descending {min; max; step}

let repr = function
  | Empty ->
    "[]"
  | Ascending {min; max; step} ->
    Format.apply "[%i to %i step %i]" min max step
  | Descending {min; max; step} ->
    Format.apply "[%i down to %i step -%i]" max min step

include Equate.Poly

let to_list = function
  | Empty -> []
  | Ascending {min; max; step} ->
    let rec aux xs x =
      assert (x >= min);
      if x = min then x::xs else aux (x::xs) (x - step)
    in
    aux [] max
  | Descending {min; max; step} ->
    let rec aux xs x =
      assert (x <= max);
      if x = max then x::xs else aux (x::xs) (x + step)
    in
    aux [] min

let to_array r =
  r |> to_list |> List.to_array

let fold ~init r ~f =
  r |> to_list |> List.fold ~init ~f

let fold_i ~init r ~f =
  r |> to_list |> List.fold_i ~init ~f

let fold_acc ~acc ~init r ~f =
  r |> to_list |> List.fold_acc ~acc ~init ~f

let reduce r ~f =
  r |> to_list |> List.reduce ~f

let reduce_i r ~f =
  r |> to_list |> List.reduce_i ~f

let reduce_acc ~acc r ~f =
  r |> to_list |> List.reduce_acc ~acc ~f

let try_reduce r ~f =
  r |> to_list |> List.try_reduce ~f

let try_reduce_i r ~f =
  r |> to_list |> List.try_reduce_i ~f

let try_reduce_acc ~acc r ~f =
  r |> to_list |> List.try_reduce_acc ~acc ~f

let iter r ~f =
  r |> to_list |> List.iter ~f

let iter_i r ~f =
  r |> to_list |> List.iter_i ~f

let iter_acc ~acc r ~f =
  r |> to_list |> List.iter_acc ~acc ~f

let count r ~f =
  r |> to_list |> List.count ~f

let count_i r ~f =
  r |> to_list |> List.count_i ~f

let count_acc ~acc r ~f =
  r |> to_list |> List.count_acc ~acc ~f

let fold_short ~init r ~f =
  r |> to_list |> List.fold_short ~init ~f

let fold_short_i ~init r ~f =
  r |> to_list |> List.fold_short_i ~init ~f

let fold_short_acc ~acc ~init r ~f =
  r |> to_list |> List.fold_short_acc ~acc ~init ~f

let reduce_short r ~f =
  r |> to_list |> List.reduce_short ~f

let reduce_short_i r ~f =
  r |> to_list |> List.reduce_short_i ~f

let reduce_short_acc ~acc r ~f =
  r |> to_list |> List.reduce_short_acc ~acc ~f

let try_reduce_short r ~f =
  r |> to_list |> List.try_reduce_short ~f

let try_reduce_short_i r ~f =
  r |> to_list |> List.try_reduce_short_i ~f

let try_reduce_short_acc ~acc r ~f =
  r |> to_list |> List.try_reduce_short_acc ~acc ~f

let iter_short r ~f =
  r |> to_list |> List.iter_short ~f

let iter_short_i r ~f =
  r |> to_list |> List.iter_short_i ~f

let iter_short_acc ~acc r ~f =
  r |> to_list |> List.iter_short_acc ~acc ~f

let for_all r ~f =
  r |> to_list |> List.for_all ~f

let for_all_i r ~f =
  r |> to_list |> List.for_all_i ~f

let for_all_acc ~acc r ~f =
  r |> to_list |> List.for_all_acc ~acc ~f

let there_exists r ~f =
  r |> to_list |> List.there_exists ~f

let there_exists_i r ~f =
  r |> to_list |> List.there_exists_i ~f

let there_exists_acc ~acc r ~f =
  r |> to_list |> List.there_exists_acc ~acc ~f

let find r ~f =
  r |> to_list |> List.find ~f

let find_i r ~f =
  r |> to_list |> List.find_i ~f

let find_acc ~acc r ~f =
  r |> to_list |> List.find_acc ~acc ~f

let try_find r ~f =
  r |> to_list |> List.try_find ~f

let try_find_i r ~f =
  r |> to_list |> List.try_find_i ~f

let try_find_acc ~acc r ~f =
  r |> to_list |> List.try_find_acc ~acc ~f

let find_map r ~f =
  r |> to_list |> List.find_map ~f

let find_map_i r ~f =
  r |> to_list |> List.find_map_i ~f

let find_map_acc ~acc r ~f =
  r |> to_list |> List.find_map_acc ~acc ~f

let try_find_map r ~f =
  r |> to_list |> List.try_find_map ~f

let try_find_map_i r ~f =
  r |> to_list |> List.try_find_map_i ~f

let try_find_map_acc ~acc r ~f =
  r |> to_list |> List.try_find_map_acc ~acc ~f

module ToList = struct
  let map r ~f =
    r |> to_list |> List.map ~f

  let map_i r ~f =
    r |> to_list |> List.map_i ~f

  let map_acc ~acc r ~f =
    r |> to_list |> List.map_acc ~acc ~f

  let filter r ~f =
    r |> to_list |> List.filter ~f

  let filter_i r ~f =
    r |> to_list |> List.filter_i ~f

  let filter_acc ~acc r ~f =
    r |> to_list |> List.filter_acc ~acc ~f

  let filter_map r ~f =
    r |> to_list |> List.filter_map ~f

  let filter_map_i r ~f =
    r |> to_list |> List.filter_map_i ~f

  let filter_map_acc ~acc r ~f =
    r |> to_list |> List.filter_map_acc ~acc ~f

  let flat_map r ~f =
    r |> to_list |> List.flat_map ~f

  let flat_map_i r ~f =
    r |> to_list |> List.flat_map_i ~f

  let flat_map_acc ~acc r ~f =
    r |> to_list |> List.flat_map_acc ~acc ~f

  let scan ~init r ~f =
    r |> to_list |> List.scan ~init ~f

  let scan_i ~init r ~f =
    r |> to_list |> List.scan_i ~init ~f

  let scan_acc ~acc ~init r ~f =
    r |> to_list |> List.scan_acc ~acc ~init ~f

  let scan_short ~init r ~f =
    r |> to_list |> List.scan_short ~init ~f

  let scan_short_i ~init r ~f =
    r |> to_list |> List.scan_short_i ~init ~f

  let scan_short_acc ~acc ~init r ~f =
    r |> to_list |> List.scan_short_acc ~acc ~init ~f
end
  
# 84 "General.cppo.ml"
  end

  module Tuples = struct
# 1 "Foundations/Tuples.ml"
module Tuple2 = struct
  type ('a, 'b) t = 'a * 'b

  let make x y =
    (x, y)

  let get_0 (x, _) =
    x

  let get_1 (_, y) =
    y

  let flip (x, y) =
    (y, x)

  let compare (x, y) (x', y') ~compare_a ~compare_b =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> compare_b y y'
    )

  let equal (x, y) (x', y') ~equal_a ~equal_b =
    Bool.O.(equal_a x x' && equal_b y y')

  let repr (x, y) ~repr_a ~repr_b =
    Format.apply "(%s, %s)" (repr_a x) (repr_b y)
end

module Tuple3 = struct
  type ('a, 'b, 'c) t = 'a * 'b * 'c

  let make x y z =
    (x, y, z)

  let get_0 (x, _, _) =
    x

  let get_1 (_, y, _) =
    y

  let get_2 (_, _, z) =
    z

  let flip (x, y, z) =
    (z, y, x)

  let compare (x, y, z) (x', y', z') ~compare_a ~compare_b ~compare_c =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> (match compare_b y y' with
        | LT -> LT
        | GT -> GT
        | EQ -> compare_c z z'
      )
    )

  let equal (x, y, z) (x', y', z') ~equal_a ~equal_b ~equal_c =
    Bool.O.(equal_a x x' && equal_b y y' && equal_c z z')

  let repr (x, y, z) ~repr_a ~repr_b ~repr_c =
    Format.apply "(%s, %s, %s)" (repr_a x) (repr_b y) (repr_c z)
end

module Tuple4 = struct
  type ('a, 'b, 'c, 'd) t = 'a * 'b * 'c * 'd

  let make x y z u =
    (x, y, z, u)

  let get_0 (x, _, _, _) =
    x

  let get_1 (_, y, _, _) =
    y

  let get_2 (_, _, z, _) =
    z

  let get_3 (_, _, _, u) =
    u

  let flip (x, y, z, u) =
    (u, z, y, x)

  let compare (x, y, z, u) (x', y', z', u') ~compare_a ~compare_b ~compare_c ~compare_d =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> (match compare_b y y' with
        | LT -> LT
        | GT -> GT
        | EQ -> (match compare_c z z' with
          | LT -> LT
          | GT -> GT
          | EQ -> compare_d u u'
        )
      )
    )

  let equal (x, y, z, u) (x', y', z', u') ~equal_a ~equal_b ~equal_c ~equal_d =
    Bool.O.(equal_a x x' && equal_b y y' && equal_c z z' && equal_d u u')

  let repr (x, y, z, u) ~repr_a ~repr_b ~repr_c ~repr_d =
    Format.apply "(%s, %s, %s, %s)" (repr_a x) (repr_b y) (repr_c z) (repr_d u)
end

module Tuple5 = struct
  type ('a, 'b, 'c, 'd, 'e) t = 'a * 'b * 'c * 'd * 'e

  let make x y z u v =
    (x, y, z, u, v)

  let get_0 (x, _, _, _, _) =
    x

  let get_1 (_, y, _, _, _) =
    y

  let get_2 (_, _, z, _, _) =
    z

  let get_3 (_, _, _, u, _) =
    u

  let get_4 (_, _, _, _, v) =
    v

  let flip (x, y, z, u, v) =
    (v, u, z, y, x)

  let compare (x, y, z, u, v) (x', y', z', u', v') ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> (match compare_b y y' with
        | LT -> LT
        | GT -> GT
        | EQ -> (match compare_c z z' with
          | LT -> LT
          | GT -> GT
          | EQ -> (match compare_d u u' with
            | LT -> LT
            | GT -> GT
            | EQ -> compare_e v v'
          )
        )
      )
    )

  let equal (x, y, z, u, v) (x', y', z', u', v') ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e =
    Bool.O.(equal_a x x' && equal_b y y' && equal_c z z' && equal_d u u' && equal_e v v')

  let repr (x, y, z, u, v) ~repr_a ~repr_b ~repr_c ~repr_d ~repr_e =
    Format.apply "(%s, %s, %s, %s, %s)" (repr_a x) (repr_b y) (repr_c z) (repr_d u) (repr_e v)
end
  
# 88 "General.cppo.ml"
  end

  module Exit = struct
# 1 "Foundations/Exit.ml"
type t =
  | Success
  | Failure of int

let of_int = function
  | 0 -> Success
  | n -> Failure n

let to_int = function
  | Success -> 0
  | Failure n -> n

let exit status =
  OCSP.exit (to_int status)

let at_exit = OCSP.at_exit
  
# 92 "General.cppo.ml"
  end

  module Stream = struct
# 1 "Foundations/Stream.ml"
module OCSS = OCamlStandard.Stream

open Reference.O
open Int.O
open Functions.Function1.O

type 'a t = 'a OCSS.t

let empty = OCSS.sempty

let of_list = OCSS.of_list

let singleton = OCSS.ising

let to_list xs =
  let ys = ref [] in
  OCSS.iter (fun x ->
    ys := x::!ys
  ) xs;
  List.reverse !ys

let concat = OCSS.iapp

let prepend = OCSS.icons

let try_next xs =
  OCSS.peek xs
  |> Option.map ~f:(fun x ->
    OCSS.junk xs;
    x
  )




# 56 "Foundations/Stream.ml"
let map_next xs ~f =
  OCSS.peek xs
  |> Option.map ~f:(fun x ->
    OCSS.junk xs;
    f x
  )

# 63 "Foundations/Stream.ml"
 
let map xs ~f = 
  let aux _ = 
     map_next  xs ~f 
  in 
  OCSS.from aux 

let  map_acc  ~acc xs ~f = 
  let acc = ref acc in 
  let aux _ = 
     map_next  xs ~f:(fun x -> 
      let (acc', y) = f ~acc:!acc x in 
      acc := acc'; 
      y 
    ) 
  in 
  OCSS.from aux 

let  map_i  xs ~f = 
   map_acc  ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x)) 


# 66 "Foundations/Stream.ml"
let filter_next xs ~f =
  let rec aux () =
    OCSS.peek xs
    |> Option.filter_map ~f:(fun x ->
      OCSS.junk xs;
      if f x then
        Some x
      else
        aux ()
    )
  in
  aux ()

# 79 "Foundations/Stream.ml"
 
let filter xs ~f = 
  let aux _ = 
     filter_next  xs ~f 
  in 
  OCSS.from aux 

let  filter_acc  ~acc xs ~f = 
  let acc = ref acc in 
  let aux _ = 
     filter_next  xs ~f:(fun x -> 
      let (acc', y) = f ~acc:!acc x in 
      acc := acc'; 
      y 
    ) 
  in 
  OCSS.from aux 

let  filter_i  xs ~f = 
   filter_acc  ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x)) 


# 82 "Foundations/Stream.ml"
let filter_map_next xs ~f =
  let rec aux () =
    OCSS.peek xs
    |> Option.filter_map ~f:(fun x ->
      OCSS.junk xs;
      match f x with
        | None -> aux ()
        | y -> y
    )
  in
  aux ()

# 94 "Foundations/Stream.ml"
 
let filter_map xs ~f = 
  let aux _ = 
     filter_map_next  xs ~f 
  in 
  OCSS.from aux 

let  filter_map_acc  ~acc xs ~f = 
  let acc = ref acc in 
  let aux _ = 
     filter_map_next  xs ~f:(fun x -> 
      let (acc', y) = f ~acc:!acc x in 
      acc := acc'; 
      y 
    ) 
  in 
  OCSS.from aux 

let  filter_map_i  xs ~f = 
   filter_map_acc  ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x)) 



# 99 "Foundations/Stream.ml"
let flat_map xs ~f =
  let current = ref None in
  let rec aux n =
    if Option.is_none !current then current := map_next xs ~f;
    match !current with
      | None -> None
      | Some ys -> begin
        match OCSS.peek ys with
          | None -> current := None; aux n
          | x -> OCSS.junk ys; x
      end
  in
  OCSS.from aux

let flat_map_acc ~acc xs ~f =
  let acc = ref acc
  and current = ref None in
  let rec aux n =
    if Option.is_none !current then current := map_next xs ~f:(fun x -> let (acc', y) = f ~acc:!acc x in acc := acc'; y);
    match !current with
      | None -> None
      | Some ys -> begin
        match OCSS.peek ys with
          | None -> current := None; aux n
          | x -> OCSS.junk ys; x
      end
  in
  OCSS.from aux

let flat_map_i xs ~f =
  flat_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x))


module ToList = struct
  let map xs ~f =
    let rec aux ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x -> aux ((f x)::ys)
    in
    aux []

  let map_acc ~acc xs ~f =
    let rec aux acc ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x ->
          let (acc, y) = f ~acc x in
          aux acc (y::ys)
    in
    aux acc []

  let map_i xs ~f =
    map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x))


  let filter xs ~f =
    let rec aux ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x ->
          let ys = if f x then x::ys else ys in
          aux ys
    in
    aux []

  let filter_acc ~acc xs ~f =
    let rec aux acc ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x ->
          let (acc, b) = f ~acc x in
          let ys = if b then x::ys else ys in
          aux acc ys
    in
    aux acc []

  let filter_i xs ~f =
    filter_acc ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x))


  let filter_map xs ~f =
    let rec aux ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x ->
          let ys =
            match f x with
              | Some y -> y::ys
              | None -> ys
          in
          aux ys
    in
    aux []

  let filter_map_acc ~acc xs ~f =
    let rec aux acc ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x ->
          let (acc, y) = f ~acc x in
          let ys =
            match y with
              | Some y -> y::ys
              | None -> ys
          in
          aux acc ys
    in
    aux acc []

  let filter_map_i xs ~f =
    filter_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x))


  let flat_map xs ~f =
    let rec aux ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x -> aux (List.rev_concat (f x) ys)
    in
    aux []

  let flat_map_acc ~acc xs ~f =
    let rec aux acc ys =
      match try_next xs with
        | None -> List.reverse ys
        | Some x ->
          let (acc, y) = f ~acc x in
          aux acc (List.rev_concat y ys)
    in
    aux acc []

  let flat_map_i xs ~f =
    flat_map_acc ~acc:0 xs ~f:(fun ~acc:i x -> (i + 1, f ~i x))
end
  
# 96 "General.cppo.ml"
  end

  module Unit = struct
# 1 "Foundations/Unit.ml"
type t = unit

let ignore = OCSP.ignore
  
# 100 "General.cppo.ml"
  end

  module PervasivesWhitelist = struct
# 1 "Foundations/PervasivesWhitelist.ml"
include Bool.O
include Float.O_dot
include Functions.Function1.O
include Int.O
include List.O
include String.O
include Reference.O

include Equate.Poly.O
include Compare.Poly.O

let ignore = Unit.ignore

let identity = Functions.Function1.identity
  
# 104 "General.cppo.ml"
  end
end

module Ubiquitous = struct
  include Reset.ResetPervasives
  include Reset.ResetStandardLibrary
  include Foundations.PervasivesWhitelist
end

module Pervasives = Ubiquitous

open Ubiquitous

open Foundations

module Testing = struct
# 1 "Testing.ml"
open Foundations

module OCSS = OCamlStandard.Sys
module OCSPf = OCamlStandard.Printf (* @todo Put StdOut in Foundations *)

module Result = struct
  module Status = struct
    type failure =
      | NotEqual of (string * string)
      | NoException of exn
      | NoExceptionNamed of string
      | WrongException of exn * exn * CallStack.t option
      | WrongExceptionNamed of string * exn * CallStack.t option
      | Custom of string

    let failure_repr = function
      | NotEqual (x, y) ->
        Format.apply "NotEqual (%S, %S)" x y
      | NoException exc ->
        Format.apply "NoException %s" (Exception.repr exc)
      | NoExceptionNamed exc ->
        Format.apply "NoExceptionNamed %S" exc
      | WrongException (expected, exc, bt) ->
        Format.apply "WrongException (%s, %s, %s)" (Exception.repr expected) (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)
      | WrongExceptionNamed (expected, exc, bt) ->
        Format.apply "WrongExceptionNamed (%S, %s, %s)" expected (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)
      | Custom x ->
        Format.apply "Custom %S" x

    type t =
      | Success
      | Failure of failure
      | Error of exn * CallStack.t option

    let repr = function
      | Success ->
        "Success"
      | Failure reason ->
        Format.apply "Failure (%s)" (failure_repr reason)
      | Error (exc, bt) ->
        Format.apply "Error (%s, %s)" (Exception.repr exc) (Option.repr ~repr_a:CallStack.to_string bt)

    let to_string = function
        | Success ->
          "OK"
        | Failure (NotEqual (expected, actual)) ->
          (* @todo split lines, quote each line, display very explicitly. Unless both values are single line. Quote anyway *)
          Format.apply "FAILED: expected %s, but got %s" expected actual
        | Failure (NoException expected) ->
          Format.apply "FAILED: expected exception %s not raised" (Exception.to_string expected)
        | Failure (NoExceptionNamed expected) ->
          Format.apply "FAILED: expected exception %s not raised" expected
        | Failure (WrongException (expected, exc, None)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" (Exception.to_string expected) (Exception.to_string exc)
        | Failure (WrongException (expected, exc, Some bt)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised\n%s" (Exception.to_string expected) (Exception.to_string exc) (CallStack.to_string bt)
        | Failure (WrongExceptionNamed (expected, exc, None)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised (no backtrace)" expected (Exception.to_string exc)
        | Failure (WrongExceptionNamed (expected, exc, Some bt)) ->
          Format.apply "FAILED: expected exception %s not raised, but exception %s raised\n%s" expected (Exception.to_string exc) (CallStack.to_string bt)
        | Failure (Custom message) ->
          Format.apply "FAILED: %s" message
        | Error (exc, None) ->
          Format.apply "ERROR: exception %s raised (no backtrace)" (Exception.to_string exc)
        | Error (exc, Some bt) ->
          Format.apply "ERROR: exception %s raised\n%s" (Exception.to_string exc) (CallStack.to_string bt)
  end

  type single = {
    label: string;
    status: Status.t;
  }

  module Counts = struct
    type t = {
      successes: int;
      failures: int;
      errors: int;
    }

    let zero = {successes=0; failures=0; errors=0}

    let of_status = function
      | Status.Success -> {successes=1; failures=0; errors=0}
      | Status.Failure _ -> {successes=0; failures=1; errors=0}
      | Status.Error _ -> {successes=0; failures=0; errors=1}

    let add {successes; failures; errors} {successes=successes'; failures=failures'; errors=errors'} =
      Int.O.{
        successes = successes + successes';
        failures = failures + failures';
        errors = errors + errors';
      }

    let repr {successes; failures; errors} =
      Format.apply "{successes=%i; failures=%i; errors=%i}" successes failures errors
  end

  type group = {
    name: string;
    children: t list;
    counts: Counts.t;
  }

  and t =
    | Single of single
    | Group of group

  let rec repr = function
    | Single {label; status} ->
      Format.apply "Single {label=%S; status=%s}" label (Status.repr status)
    | Group {name; children; counts} ->
      Format.apply "Group {name=%S; children=%s; counts=%s}" name (List.repr ~repr_a:repr children) (Counts.repr counts)

  let equal x y =
    Equate.Poly.equal x y

  let to_indented_strings ~verbose =
    let rec aux indent = function
      | Single {label; status} ->
        if verbose || status <> Status.Success then
          (* @todo Indent potential backtrace or anything else that could span several lines *)
          [Format.apply "%s%S: %s" indent label (Status.to_string status)]
        else
          []
      | Group {name; children; counts={Counts.successes; failures; errors}} ->
        let children =
          children
          |> List.flat_map ~f:(aux (indent ^ "  "))
        and line =
          if Int.O.(failures + errors = 0) then
            Format.apply "%s%S (Successes: %i)" indent name successes
          else
            Format.apply "%s%S (Successes: %i, failures: %i, errors: %i)" indent name successes failures errors
        in
        if verbose || Int.O.(failures + errors <> 0) then
          line::children
        else
          [line]
    in
    function result ->
      result
      |> aux ""
end

exception TestFailure of Result.Status.failure

module Test = struct
  type single = {
    label: string;
    check: unit lazy_t;
  }

  type group = {
    name: string;
    tests: t list;
  }

  and t =
    | Single of single
    | Group of group

  let run ?(record_backtrace=true) test =
    Exception.record_backtraces record_backtrace;
    let rec aux = function
      | Group {name; tests} ->
        let children = List.map ~f:aux tests in
        let counts =
          children
          |> List.fold ~init:Result.Counts.zero ~f:(fun counts result ->
            let counts' = match result with
              | Result.Single {Result.status; _} -> Result.Counts.of_status status
              | Result.Group {Result.counts; _} -> counts
            in
            Result.Counts.add counts counts'
          )
        in
        Result.Group {Result.name; children; counts}
      | Single {label; check} ->
        try
          Lazy.value check;
          Result.Single {Result.label; status=Result.Status.Success}
        with
          | TestFailure reason ->
            Result.Single {Result.label; status=Result.Status.Failure reason}
          | exc ->
            Result.Single {Result.label; status=Result.Status.Error (exc, Exception.most_recent_backtrace ())}
    in
    aux test
end

(* Running *)

(*BISECT-IGNORE-BEGIN*) (* Test code *)
let command_line_main ~argv test =
  let verbose =
    match argv with
      | [_; "--verbose"] -> true
      | _ -> false
  in
  let result = Test.run test in
  result
  |> Result.to_indented_strings ~verbose
  |> List.iter ~f:(OCSPf.printf "%s\n");
  match result with
    | Result.Single {Result.status=Result.Status.Success; _}
    | Result.Group {Result.counts={Result.Counts.failures=0; errors=0; _}; _} ->
      Exit.Success
    | _ -> Exit.Failure 1
(*BISECT-IGNORE-END*)

(* Test factories *)

let (>::) name tests =
  Test.(Group {name; tests})

let (>:) label check =
  Test.(Single {label; check})

let (~::) format =
  Format.with_result ~f:(>::) format

let (~:) format =
  Format.with_result ~f:(>:) format

(* Checks *)

let javascript = String.has_suffix OCSS.argv.(0) ~suf:".js"

let fail format =
  Format.with_result
    ~f:(fun message ->
      Exception.raise (TestFailure (Result.Status.Custom message))
    )
    format

exception NoExceptionRaised
let expect_exception ~expected x =
  try
    ignore (Lazy.value x);
    Exception.raise NoExceptionRaised
  with
    | NoExceptionRaised -> Exception.raise (TestFailure (Result.Status.NoException expected))
    | actual when Exception.equal actual expected -> ()
    | exc -> Exception.raise (TestFailure (Result.Status.WrongException (expected, exc, Exception.most_recent_backtrace ())))

let expect_exception_named ~expected x =
  try
    ignore (Lazy.value x);
    Exception.raise NoExceptionRaised
  with
    | NoExceptionRaised -> Exception.raise (TestFailure (Result.Status.NoExceptionNamed expected))
    | actual when String.equal (Exception.name actual) expected -> ()
    | exc -> Exception.raise (TestFailure (Result.Status.WrongExceptionNamed (expected, exc, Exception.most_recent_backtrace ())))

let check ~repr ~equal ~expected actual =
  if not (equal expected actual) then
    Exception.raise (TestFailure (Result.Status.NotEqual (repr expected, repr actual)))

let check_poly ~repr ~expected actual =
  check ~repr ~equal:Equate.Poly.equal ~expected actual

let check_bool ~expected actual =
  check ~repr:Bool.repr ~equal:Bool.equal ~expected actual

let check_true actual =
  check_bool ~expected:true actual

let check_false actual =
  check_bool ~expected:false actual

let check_string ~expected actual =
  check ~repr:String.repr ~equal:String.equal ~expected actual

(* @todo check_char (difficulty: Char is in Implementation, not Foundation) *)

let check_int ~expected actual =
  check ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_42 actual =
  check ~repr:Int.repr ~equal:Int.equal ~expected:42 actual

let check_float ?precision ~expected actual =
  check ~repr:Float.repr ~equal:(Float.approx_equal ?precision) ~expected actual

let check_float_in ~low ~high actual =
  if actual < low || actual > high then
    (* @todo Add a specific Result.Status *)
    Exception.raise (TestFailure (Result.Status.Custom "not in"))

let check_float_exact ~expected actual =
  check ~repr:Float.repr ~equal:Float.equal ~expected actual

let check_option ~repr ~equal ~expected actual =
  check ~repr:(Option.repr ~repr_a:repr) ~equal:(Option.equal ~equal_a:equal) ~expected actual

let check_some ~repr ~equal ~expected actual =
  check_option ~repr ~equal ~expected:(Some expected) actual

let check_none ~repr ~equal actual =
  check_option ~repr ~equal ~expected:None actual

let check_option_poly ~repr ~expected actual =
  check_option ~repr ~equal:Equate.Poly.equal ~expected actual

let check_some_poly ~repr ~expected actual =
  check_option_poly ~repr ~expected:(Some expected) actual

let check_none_poly ~repr actual =
  check_option_poly ~repr ~expected:None actual

let check_int_option ~expected actual =
  check_option ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_some_int ~expected actual =
  check_int_option ~expected:(Some expected) actual

let check_some_42 actual =
  check_some_int ~expected:42 actual

let check_none_int actual =
  check_int_option ~expected:None actual

let check_string_option ~expected actual =
  check_option ~repr:String.repr ~equal:String.equal ~expected actual

let check_some_string ~expected actual =
  check_string_option ~expected:(Some expected) actual

let check_none_string actual =
  check_string_option ~expected:None actual

let check_list ~repr ~equal ~expected actual =
  check ~repr:(List.repr ~repr_a:repr) ~equal:(List.equal ~equal_a:equal) ~expected actual

let check_list_poly ~repr ~expected actual =
  check_list ~repr ~equal:Equate.Poly.equal ~expected actual

let check_string_list ~expected actual =
  check_list ~repr:String.repr ~equal:String.equal ~expected actual

let check_int_list ~expected actual =
  check_list ~repr:Int.repr ~equal:Int.equal ~expected actual

let check_tuple2 ~repr_a ~repr_b ~equal_a ~equal_b ~expected actual =
  check
    ~repr:(Tuples.Tuple2.repr ~repr_a ~repr_b)
    ~equal:(Tuples.Tuple2.equal ~equal_a ~equal_b)
    ~expected actual

let check_int_tuple2 ~expected actual =
  check_tuple2
    ~repr_a:Int.repr ~repr_b:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal
    ~expected actual

let check_tuple3 ~repr_a ~repr_b ~repr_c ~equal_a ~equal_b ~equal_c ~expected actual =
  check
    ~repr:(Tuples.Tuple3.repr ~repr_a ~repr_b ~repr_c)
    ~equal:(Tuples.Tuple3.equal ~equal_a ~equal_b ~equal_c)
    ~expected actual

let check_int_tuple3 ~expected actual =
  check_tuple3
    ~repr_a:Int.repr ~repr_b:Int.repr ~repr_c:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal ~equal_c:Int.equal
    ~expected actual

let check_tuple4 ~repr_a ~repr_b ~repr_c ~repr_d ~equal_a ~equal_b ~equal_c ~equal_d ~expected actual =
  check
    ~repr:(Tuples.Tuple4.repr ~repr_a ~repr_b ~repr_c ~repr_d)
    ~equal:(Tuples.Tuple4.equal ~equal_a ~equal_b ~equal_c ~equal_d)
    ~expected actual

let check_int_tuple4 ~expected actual =
  check_tuple4
    ~repr_a:Int.repr ~repr_b:Int.repr ~repr_c:Int.repr ~repr_d:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal ~equal_c:Int.equal ~equal_d:Int.equal
    ~expected actual

let check_tuple5 ~repr_a ~repr_b ~repr_c ~repr_d ~repr_e ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e ~expected actual =
  check
    ~repr:(Tuples.Tuple5.repr ~repr_a ~repr_b ~repr_c ~repr_d ~repr_e)
    ~equal:(Tuples.Tuple5.equal ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e)
    ~expected actual

let check_int_tuple5 ~expected actual =
  check_tuple5
    ~repr_a:Int.repr ~repr_b:Int.repr ~repr_c:Int.repr ~repr_d:Int.repr ~repr_e:Int.repr
    ~equal_a:Int.equal ~equal_b:Int.equal ~equal_c:Int.equal ~equal_d:Int.equal ~equal_e:Int.equal
    ~expected actual
# 121 "General.cppo.ml"
end

module Traits = struct
  module Representable = struct
module type S0 = sig
  type t
  val repr: t -> string
end
module type S1 = sig
  type 'a t
  val repr: 'a t -> repr_a:('a -> string) -> string
end
module type S2 = sig
  type ('a, 'b) t
  val repr: ('a, 'b) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> string
end
module type S3 = sig
  type ('a, 'b, 'c) t
  val repr: ('a, 'b, 'c) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> string
end
module type S4 = sig
  type ('a, 'b, 'c, 'd) t
  val repr: ('a, 'b, 'c, 'd) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> repr_d:('d -> string) -> string
end
module type S5 = sig
  type ('a, 'b, 'c, 'd, 'e) t
  val repr: ('a, 'b, 'c, 'd, 'e) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> repr_d:('d -> string) -> repr_e:('e -> string) -> string
end
module Specialize1(M: S1)(A: S0): S0 with type t = A.t M.t = struct
  type t = A.t M.t
  let repr x =
    M.repr x ~repr_a:A.repr
end
module Specialize2(M: S2)(A: S0)(B: S0): S0 with type t = (A.t, B.t) M.t = struct
  type t = (A.t, B.t) M.t
  let repr x =
    M.repr x ~repr_a:A.repr ~repr_b:B.repr
end
module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
  type t = (A.t, B.t, C.t) M.t
  let repr x =
    M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr
end
module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
  type t = (A.t, B.t, C.t, D.t) M.t
  let repr x =
    M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr
end
module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
  type t = (A.t, B.t, C.t, D.t, E.t) M.t
  let repr x =
    M.repr x ~repr_a:A.repr ~repr_b:B.repr ~repr_c:C.repr ~repr_d:D.repr ~repr_e:E.repr
end

# 6 "Traits/Representable.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type Element = S0

    module type S0 = sig
      type t

      val repr: (t * string) list
    end

    module type S1 = sig
      module A: Element

      type 'a t

      val repr: (A.t t * string) list
    end

    module type S2 = sig
      module A: Element
      module B: Element

      type ('a, 'b) t

      val repr: ((A.t, B.t) t * string) list
    end

    module type S3 = sig
      module A: Element
      module B: Element
      module C: Element

      type ('a, 'b, 'c) t

      val repr: ((A.t, B.t, C.t) t * string) list
    end

    module type S4 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element

      type ('a, 'b, 'c, 'd) t

      val repr: ((A.t, B.t, C.t, D.t) t * string) list
    end

    module type S5 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      type ('a, 'b, 'c, 'd, 'e) t

      val repr: ((A.t, B.t, C.t, D.t, E.t) t * string) list
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Representable" >:: (
      E.repr
      |> List.map ~f:(fun (v, expected) ->
        ~: "repr %s" expected (lazy (check_string ~expected (repr v)))
      )
    )
  end

  module Make1(M: S1)(E: Examples.S1 with type 'a t := 'a M.t) =
    Make0(Specialize1(M)(E.A))(E)

  module Make2(M: S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) =
    Make0(Specialize2(M)(E.A)(E.B))(E)

  module Make3(M: S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) =
    Make0(Specialize3(M)(E.A)(E.B)(E.C))(E)

  module Make4(M: S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) =
    Make0(Specialize4(M)(E.A)(E.B)(E.C)(E.D))(E)

  module Make5(M: S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) =
    Make0(Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E))(E)
end
  
# 126 "General.cppo.ml"
  end

  module Equatable = struct
module Basic = struct
  module type S0 = sig
    type t
    val equal: t -> t -> bool
  end
  module type S1 = sig
    type 'a t
    val equal: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
  end
  module type S2 = sig
    type ('a, 'b) t
    val equal: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
  end
  module type S3 = sig
    type ('a, 'b, 'c) t
    val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
  end
  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
  end
  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
  end
  module Specialize1(M: S1)(A: S0): S0 with type t = A.t M.t = struct
    type t = A.t M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal
  end
  module Specialize2(M: S2)(A: S0)(B: S0): S0 with type t = (A.t, B.t) M.t = struct
    type t = (A.t, B.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal
  end
  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
    type t = (A.t, B.t, C.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal
  end
  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal
  end
  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    let equal x y =
      M.equal x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal ~equal_e:E.equal
  end
end
module Operators = struct
  module type S0 = sig
    type t
    val ( = ): t -> t -> bool
    val ( <> ): t -> t -> bool
  end
  module Make0(M: sig
    type t
    val equal: t -> t -> bool
    val different: t -> t -> bool
  end) = struct
    let ( = ) = M.equal
    let ( <> ) = M.different
  end
end
module type S0 = sig
  include Basic.S0
  val different: t -> t -> bool
  module O: Operators.S0 with type t := t
end
module type S1 = sig
  include Basic.S1
  val different: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
end
module type S2 = sig
  include Basic.S2
  val different: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
end
module type S3 = sig
  include Basic.S3
  val different: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
end
module type S4 = sig
  include Basic.S4
  val different: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
end
module type S5 = sig
  include Basic.S5
  val different: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
end
module Specialize1(M: S1)(A: Basic.S0): S0 with type t = A.t M.t = struct
  module Self = struct
    include Basic.Specialize1(M)(A)
    let different x y =
      M.different x y ~equal_a:A.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0): S0 with type t = (A.t, B.t) M.t = struct
  module Self = struct
    include Basic.Specialize2(M)(A)(B)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
  module Self = struct
    include Basic.Specialize3(M)(A)(B)(C)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
  module Self = struct
    include Basic.Specialize4(M)(A)(B)(C)(D)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
  module Self = struct
    include Basic.Specialize5(M)(A)(B)(C)(D)(E)
    let different x y =
      M.different x y ~equal_a:A.equal ~equal_b:B.equal ~equal_c:C.equal ~equal_d:D.equal ~equal_e:E.equal
  end
  module O = Operators.Make0(Self)
  include Self
end

# 6 "Traits/Equatable.ml"
module Different = struct
  module Make0(M: sig
    type t

    val equal: t -> t
      -> bool
  end) = struct
    open M

    let different x y =
      not (equal x y)
  end

  module Make1(M: sig
    type 'a t

    val equal: 'a t -> 'a t
      -> equal_a:('a -> 'a -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a =
      not (equal x y ~equal_a)
  end

  module Make2(M: sig
    type ('a, 'b) t

    val equal: ('a, 'b) t -> ('a, 'b) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b =
      not (equal x y ~equal_a ~equal_b)
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> equal_c:('c -> 'c -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b ~equal_c =
      not (equal x y ~equal_a ~equal_b ~equal_c)
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> equal_c:('c -> 'c -> bool)
      -> equal_d:('d -> 'd -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b ~equal_c ~equal_d =
      not (equal x y ~equal_a ~equal_b ~equal_c ~equal_d)
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> equal_a:('a -> 'a -> bool)
      -> equal_b:('b -> 'b -> bool)
      -> equal_c:('c -> 'c -> bool)
      -> equal_d:('d -> 'd -> bool)
      -> equal_e:('e -> 'e -> bool)
      -> bool
  end) = struct
    open M

    let different x y ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e =
      not (equal x y ~equal_a ~equal_b ~equal_c ~equal_d ~equal_e)
  end
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val equal: t list list
      val different: (t * t) list
    end

    module type Element = sig
      include Basic.S0
      include Representable.S0 with type t := t
    end

    module type S1 = sig
      module A: Element

      type 'a t

      val equal: A.t t list list
      val different: (A.t t * A.t t) list
    end

    module type S2 = sig
      module A: Element
      module B: Element

      type ('a, 'b) t

      val equal: (A.t, B.t) t list list
      val different: ((A.t, B.t) t * (A.t, B.t) t) list
    end

    module type S3 = sig
      module A: Element
      module B: Element
      module C: Element

      type ('a, 'b, 'c) t

      val equal: (A.t, B.t, C.t) t list list
      val different: ((A.t, B.t, C.t) t * (A.t, B.t, C.t) t) list
    end

    module type S4 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element

      type ('a, 'b, 'c, 'd) t

      val equal: (A.t, B.t, C.t, D.t) t list list
      val different: ((A.t, B.t, C.t, D.t) t * (A.t, B.t, C.t, D.t) t) list
    end

    module type S5 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      type ('a, 'b, 'c, 'd, 'e) t

      val equal: (A.t, B.t, C.t, D.t, E.t) t list list
      val different: ((A.t, B.t, C.t, D.t, E.t) t * (A.t, B.t, C.t, D.t, E.t) t) list
    end
  end

  module Make0(M: sig
    include S0
    include Representable.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M
    open M.O

    let test = "Equatable" >:: (
      E.equal
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "equal %s %s" rx ry (lazy (check_true (equal x y)));
            ~: "different %s %s" rx ry (lazy (check_false (different x y)));
            ~: "%s = %s" rx ry (lazy (check_true (x = y)));
            ~: "%s <> %s" rx ry (lazy (check_false (x <> y)));

            ~: "equal %s %s" ry rx (lazy (check_true (equal y x)));
            ~: "different %s %s" ry rx (lazy (check_false (different y x)));
            ~: "%s = %s" ry rx (lazy (check_true (y = x)));
            ~: "%s <> %s" ry rx (lazy (check_false (y <> x)));
          ]
        )
      )
    ) @ (
      E.different
      |> List.flat_map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "equal %s %s" rx ry (lazy (check_false (equal x y)));
          ~: "different %s %s" rx ry (lazy (check_true (different x y)));
          ~: "%s = %s" rx ry (lazy (check_false (x = y)));
          ~: "%s <> %s" rx ry (lazy (check_true (x <> y)));

          ~: "equal %s %s" ry rx (lazy (check_false (equal y x)));
          ~: "different %s %s" ry rx (lazy (check_true (different y x)));
          ~: "%s = %s" ry rx (lazy (check_false (y = x)));
          ~: "%s <> %s" ry rx (lazy (check_true (y <> x)));
        ]
      )
    )
  end

  module Make1(M: sig
    include S1
    include Representable.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t) = Make0(struct
    include Specialize1(M)(E.A)
    include (Representable.Specialize1(M)(E.A): Representable.S0 with type t := t)
  end)(E)

  module Make2(M: sig
    include S2
    include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
  end)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t) = Make0(struct
    include Specialize2(M)(E.A)(E.B)
    include (Representable.Specialize2(M)(E.A)(E.B): Representable.S0 with type t := t)
  end)(E)

  module Make3(M: sig
    include S3
    include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t) = Make0(struct
    include Specialize3(M)(E.A)(E.B)(E.C)
    include (Representable.Specialize3(M)(E.A)(E.B)(E.C): Representable.S0 with type t := t)
  end)(E)

  module Make4(M: sig
    include S4
    include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t) = Make0(struct
    include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
    include (Representable.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Representable.S0 with type t := t)
  end)(E)

  module Make5(M: sig
    include S5
    include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t) = Make0(struct
    include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
    include (Representable.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Representable.S0 with type t := t)
  end)(E)
end
  
# 130 "General.cppo.ml"
  end

  module Comparable = struct
module Basic = struct
  module type S0 = sig
    type t
    val compare: t -> t -> Compare.t
  end
  module type S1 = sig
    type 'a t
    val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
  end
  module type S2 = sig
    type ('a, 'b) t
    val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
  end
  module type S3 = sig
    type ('a, 'b, 'c) t
    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
  end
  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
  end
  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
  end
  module Specialize1(M: S1)(A: S0): S0 with type t = A.t M.t = struct
    type t = A.t M.t
    let compare x y =
      M.compare x y ~compare_a:A.compare
  end
  module Specialize2(M: S2)(A: S0)(B: S0): S0 with type t = (A.t, B.t) M.t = struct
    type t = (A.t, B.t) M.t
    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare
  end
  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
    type t = (A.t, B.t, C.t) M.t
    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
  end
  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t) M.t
    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
  end
  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    let compare x y =
      M.compare x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
  end
end
module Operators = struct
  module type S0 = sig
    type t
    val ( < ): t -> t -> bool
    val ( <= ): t -> t -> bool
    val ( > ): t -> t -> bool
    val ( >= ): t -> t -> bool
  end
  module Make0(M: sig
    type t
    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool
  end) = struct
    let ( < ) = M.less_than
    let ( <= ) = M.less_or_equal
    let ( > ) = M.greater_than
    let ( >= ) = M.greater_or_equal
  end
end
module type S0 = sig
  include Basic.S0
  val less_than: t -> t -> bool
  val less_or_equal: t -> t -> bool
  val greater_than: t -> t -> bool
  val greater_or_equal: t -> t -> bool
  val between: t -> low:(t) -> high:(t) -> bool
  val between_or_equal: t -> low:(t) -> high:(t) -> bool
  val min: t -> t -> t
  val max: t -> t -> t
  val min_max: t -> t -> t * t
  module O: Operators.S0 with type t := t
end
module type S1 = sig
  include Basic.S1
  val less_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
  val less_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
  val greater_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
  val greater_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
  val between: 'a t -> low:('a t) -> high:('a t) -> compare_a:('a -> 'a -> Compare.t) -> bool
  val between_or_equal: 'a t -> low:('a t) -> high:('a t) -> compare_a:('a -> 'a -> Compare.t) -> bool
  val min: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t
  val max: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t
  val min_max: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t * 'a t
end
module type S2 = sig
  include Basic.S2
  val less_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
  val less_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
  val greater_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
  val greater_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
  val between: ('a, 'b) t -> low:(('a, 'b) t) -> high:(('a, 'b) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
  val between_or_equal: ('a, 'b) t -> low:(('a, 'b) t) -> high:(('a, 'b) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
  val min: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t
  val max: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t
  val min_max: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t * ('a, 'b) t
end
module type S3 = sig
  include Basic.S3
  val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
  val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
  val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
  val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
  val between: ('a, 'b, 'c) t -> low:(('a, 'b, 'c) t) -> high:(('a, 'b, 'c) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
  val between_or_equal: ('a, 'b, 'c) t -> low:(('a, 'b, 'c) t) -> high:(('a, 'b, 'c) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
  val min: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t
  val max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t
  val min_max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t * ('a, 'b, 'c) t
end
module type S4 = sig
  include Basic.S4
  val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
  val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
  val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
  val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
  val between: ('a, 'b, 'c, 'd) t -> low:(('a, 'b, 'c, 'd) t) -> high:(('a, 'b, 'c, 'd) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
  val between_or_equal: ('a, 'b, 'c, 'd) t -> low:(('a, 'b, 'c, 'd) t) -> high:(('a, 'b, 'c, 'd) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
  val min: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t
  val max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t
  val min_max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t * ('a, 'b, 'c, 'd) t
end
module type S5 = sig
  include Basic.S5
  val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
  val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
  val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
  val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
  val between: ('a, 'b, 'c, 'd, 'e) t -> low:(('a, 'b, 'c, 'd, 'e) t) -> high:(('a, 'b, 'c, 'd, 'e) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
  val between_or_equal: ('a, 'b, 'c, 'd, 'e) t -> low:(('a, 'b, 'c, 'd, 'e) t) -> high:(('a, 'b, 'c, 'd, 'e) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
  val min: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t
  val max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t
  val min_max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t * ('a, 'b, 'c, 'd, 'e) t
end
module Specialize1(M: S1)(A: Basic.S0): S0 with type t = A.t M.t = struct
  module Self = struct
    include Basic.Specialize1(M)(A)
    let less_than x y =
      M.less_than x y ~compare_a:A.compare
    let less_or_equal x y =
      M.less_or_equal x y ~compare_a:A.compare
    let greater_than x y =
      M.greater_than x y ~compare_a:A.compare
    let greater_or_equal x y =
      M.greater_or_equal x y ~compare_a:A.compare
    let between x ~low ~high =
      M.between x ~low ~high ~compare_a:A.compare
    let between_or_equal x ~low ~high =
      M.between_or_equal x ~low ~high ~compare_a:A.compare
    let min x y =
      M.min x y ~compare_a:A.compare
    let max x y =
      M.max x y ~compare_a:A.compare
    let min_max x y =
      M.min_max x y ~compare_a:A.compare
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0): S0 with type t = (A.t, B.t) M.t = struct
  module Self = struct
    include Basic.Specialize2(M)(A)(B)
    let less_than x y =
      M.less_than x y ~compare_a:A.compare ~compare_b:B.compare
    let less_or_equal x y =
      M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare
    let greater_than x y =
      M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare
    let greater_or_equal x y =
      M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare
    let between x ~low ~high =
      M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare
    let between_or_equal x ~low ~high =
      M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare
    let min x y =
      M.min x y ~compare_a:A.compare ~compare_b:B.compare
    let max x y =
      M.max x y ~compare_a:A.compare ~compare_b:B.compare
    let min_max x y =
      M.min_max x y ~compare_a:A.compare ~compare_b:B.compare
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0): S0 with type t = (A.t, B.t, C.t) M.t = struct
  module Self = struct
    include Basic.Specialize3(M)(A)(B)(C)
    let less_than x y =
      M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let less_or_equal x y =
      M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let greater_than x y =
      M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let greater_or_equal x y =
      M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let between x ~low ~high =
      M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let between_or_equal x ~low ~high =
      M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let min x y =
      M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let max x y =
      M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
    let min_max x y =
      M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0): S0 with type t = (A.t, B.t, C.t, D.t) M.t = struct
  module Self = struct
    include Basic.Specialize4(M)(A)(B)(C)(D)
    let less_than x y =
      M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let less_or_equal x y =
      M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let greater_than x y =
      M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let greater_or_equal x y =
      M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let between x ~low ~high =
      M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let between_or_equal x ~low ~high =
      M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let min x y =
      M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let max x y =
      M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
    let min_max x y =
      M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare
  end
  module O = Operators.Make0(Self)
  include Self
end
module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0): S0 with type t = (A.t, B.t, C.t, D.t, E.t) M.t = struct
  module Self = struct
    include Basic.Specialize5(M)(A)(B)(C)(D)(E)
    let less_than x y =
      M.less_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let less_or_equal x y =
      M.less_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let greater_than x y =
      M.greater_than x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let greater_or_equal x y =
      M.greater_or_equal x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let between x ~low ~high =
      M.between x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let between_or_equal x ~low ~high =
      M.between_or_equal x ~low ~high ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let min x y =
      M.min x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let max x y =
      M.max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
    let min_max x y =
      M.min_max x y ~compare_a:A.compare ~compare_b:B.compare ~compare_c:C.compare ~compare_d:D.compare ~compare_e:E.compare
  end
  module O = Operators.Make0(Self)
  include Self
end

# 6 "Traits/Comparable.ml"
(* @feature Descending, ascending *)

module GreaterLessThan = struct
  module Make0(M: sig
    type t

    val compare: t -> t
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y =
      match compare x y with
        | LT -> true
        | _ -> false

    let less_or_equal x y =
      match compare x y with
        | GT -> false
        | _ -> true

    let greater_than x y =
      match compare x y with
        | GT -> true
        | _ -> false

    let greater_or_equal x y =
      match compare x y with
        | LT -> false
        | _ -> true
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a =
      match compare x y ~compare_a with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a =
      match compare x y ~compare_a with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a =
      match compare x y ~compare_a with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a =
      match compare x y ~compare_a with
        | LT -> false
        | _ -> true
  end

  module Make2(M: sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | LT -> false
        | _ -> true
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | LT -> false
        | _ -> true
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | LT -> false
        | _ -> true
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | LT -> false
        | _ -> true
  end
end

module Between = struct
  module Make0(M: sig
    type t

    val less_than: t -> t
      -> bool
    val less_or_equal: t -> t
      -> bool
    val greater_than: t -> t
      -> bool
    val greater_or_equal: t -> t
      -> bool
  end) = struct
    open M

    let between x ~low ~high =
      less_than low x
      && greater_than high x

    let between_or_equal x ~low ~high =
      less_or_equal low x
      && greater_or_equal high x
  end

  module Make1(M: sig
    type 'a t

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
  end) = struct
    open M
    open Compare

    let between x ~low ~high ~compare_a =
      less_than low x ~compare_a
      && greater_than high x ~compare_a

    let between_or_equal x ~low ~high ~compare_a =
      less_or_equal low x ~compare_a
      && greater_or_equal high x ~compare_a
  end

  module Make2(M: sig
    type ('a, 'b) t

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
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b =
      less_than low x ~compare_a ~compare_b
      && greater_than high x ~compare_a ~compare_b

    let between_or_equal x ~low ~high ~compare_a ~compare_b =
      less_or_equal low x ~compare_a ~compare_b
      && greater_or_equal high x ~compare_a ~compare_b
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

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
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c =
      less_than low x ~compare_a ~compare_b ~compare_c
      && greater_than high x ~compare_a ~compare_b ~compare_c

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c =
      less_or_equal low x ~compare_a ~compare_b ~compare_c
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

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
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d =
      less_than low x ~compare_a ~compare_b ~compare_c ~compare_d
      && greater_than high x ~compare_a ~compare_b ~compare_c ~compare_d

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d =
      less_or_equal low x ~compare_a ~compare_b ~compare_c ~compare_d
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c ~compare_d
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

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
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      less_than low x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
      && greater_than high x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      less_or_equal low x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
  end
end

module MinMax = struct
  module Make0(M: sig
    type t

    val compare: t -> t
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y =
      match compare x y with LT -> x | GT | EQ -> y

    let max x y =
      match compare x y with GT -> x | LT | EQ -> y

    let min_max x y =
      match compare x y with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a =
      match compare x y ~compare_a with LT -> x | GT | EQ -> y

    let max x y ~compare_a =
      match compare x y ~compare_a with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a =
      match compare x y ~compare_a with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make2(M: sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with LT -> (x, y) | GT | EQ -> (y, x)
  end
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val ordered: t list list
      val equal: t list list
    end

    module type Element = sig
      include Basic.S0
      include Equatable.Basic.S0 with type t := t
      include Representable.S0 with type t := t
    end

    module type S1 = sig
      module A: Element

      type 'a t

      val ordered: A.t t list list
      val equal: A.t t list list
    end

    module type S2 = sig
      module A: Element
      module B: Element

      type ('a, 'b) t

      val ordered: (A.t, B.t) t list list
      val equal: (A.t, B.t) t list list
    end

    module type S3 = sig
      module A: Element
      module B: Element
      module C: Element

      type ('a, 'b, 'c) t

      val ordered: (A.t, B.t, C.t) t list list
      val equal: (A.t, B.t, C.t) t list list
    end

    module type S4 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element

      type ('a, 'b, 'c, 'd) t

      val ordered: (A.t, B.t, C.t, D.t) t list list
      val equal: (A.t, B.t, C.t, D.t) t list list
    end

    module type S5 = sig
      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      type ('a, 'b, 'c, 'd, 'e) t

      val ordered: (A.t, B.t, C.t, D.t, E.t) t list list
      val equal: (A.t, B.t, C.t, D.t, E.t) t list list
    end
  end

  module Make0(M: sig
    include S0
    include Representable.S0 with type t := t
    include Equatable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M
    open M.O

    let check_pair =
      check
        ~repr:(Tuples.Tuple2.repr ~repr_a:repr ~repr_b:repr)
        ~equal:(Tuples.Tuple2.equal ~equal_a:equal ~equal_b:equal)

    let check = check ~repr ~equal

    let test = "Comparable" >:: (
      E.ordered
      |> List.flat_map ~f:(fun xs ->
        List.fold ~init:(List.head xs, []) (List.tail xs) ~f:(fun (x, tests) y ->
          let rx = repr x and ry = repr y in
          let new_tests = [
            ~: "less_than %s %s" rx ry (lazy (check_true (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_false (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_true (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_false (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_false (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_true (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_false (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_true (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
          ] in
          (y, new_tests @ tests)
        )
        |> Tuples.Tuple2.get_1
      )
    ) @ (
      E.equal
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "less_than %s %s" rx ry (lazy (check_false (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_true (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_false (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_true (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:y (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:x (max x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_true (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_false (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_true (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_false (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:y (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:x (max y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, y) (min_max y x)));
          ]
        )
      )
    )
  end

  module Make1(M: sig
    include S1
    include Equatable.Basic.S1 with type 'a t := 'a t
    include Representable.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t): sig val test: Test.t end = Make0(struct
    include Specialize1(M)(E.A)
    include (Representable.Specialize1(M)(E.A): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize1(M)(E.A): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make2(M: sig
    include S2
    include Equatable.Basic.S2 with type ('a, 'b) t := ('a, 'b) t
    include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
  end)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig val test: Test.t end = Make0(struct
    include Specialize2(M)(E.A)(E.B)
    include (Representable.Specialize2(M)(E.A)(E.B): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize2(M)(E.A)(E.B): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make3(M: sig
    include S3
    include Equatable.Basic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig val test: Test.t end = Make0(struct
    include Specialize3(M)(E.A)(E.B)(E.C)
    include (Representable.Specialize3(M)(E.A)(E.B)(E.C): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize3(M)(E.A)(E.B)(E.C): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make4(M: sig
    include S4
    include Equatable.Basic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig val test: Test.t end = Make0(struct
    include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
    include (Representable.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make5(M: sig
    include S5
    include Equatable.Basic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig val test: Test.t end = Make0(struct
    include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
    include (Representable.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Equatable.Basic.S0 with type t := t)
  end)(E)
end
  
# 134 "General.cppo.ml"
  end

  module Displayable = struct
module type S0 = sig
  type t
  val to_string: t -> string
end

# 6 "Traits/Displayable.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val to_string: (t * string) list
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Displayable" >:: (
      E.to_string
      |> List.map ~f:(fun (v, expected) ->
        ~: "to_string %s" expected (lazy (check_string ~expected (to_string v)))
      )
    )
  end
end
  
# 138 "General.cppo.ml"
  end

  module Parsable = struct
module type S0 = sig
  type t
  val try_of_string: string -> t option
  val of_string: string -> t
end

# 6 "Traits/Parsable.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val of_string: (string * t) list
    end
  end

  module Make0(M: sig
    include S0
    include Equatable.Basic.S0 with type t := t
    include Representable.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "Parsable" >:: (
      E.of_string
      |> List.flat_map ~f:(fun (s, expected) ->
        [
          ~: "of_string %S" s (lazy (check ~repr ~equal ~expected (of_string s)));
          ~: "try_of_string %S" s (lazy (check_some ~repr ~equal ~expected (try_of_string s)));
        ]
      )
    )
  end
end
  
# 142 "General.cppo.ml"
  end

  module PredSucc = struct
# 1 "Traits/PredSucc.signatures.ml"
module type S0 = sig
  type t

  val succ: t -> t
  val pred: t -> t
end

# 3 "Traits/PredSucc.ml"
module Make0(M: sig
  type t

  val one: t

  val add: t -> t -> t
  val substract: t -> t -> t
end) = struct
  open M

  let pred x =
    substract x one

  let succ x =
    add x one
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t
      
      val succ: (t * t) list
    end
  end

  module Make0(M: sig
    include S0
    include Equatable.Basic.S0 with type t := t
    include Representable.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t) = struct
    open M

    let test = "PredSucc" >:: (
      E.succ
      |> List.flat_map ~f:(fun (p, s) ->
        let rp = repr p and rs = repr s in
        [
          ~: "succ %s" rp (lazy (check ~repr ~equal ~expected:s (succ p)));
          ~: "pred %s" rs (lazy (check ~repr ~equal ~expected:p (pred s)));
        ]
      )
    )
  end
end
  
# 146 "General.cppo.ml"
  end

  module OfStandardNumbers = struct
module type S0 = sig
  type t
  val of_int: int -> t
  val of_float: float -> t
end
  
# 150 "General.cppo.ml"
  end

  module ToStandardNumbers = struct
module type S0 = sig
  type t
  val to_int: t -> int
  val to_float: t -> float
end
  
# 154 "General.cppo.ml"
  end

  module Ringoid = struct
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
    val ( ~- ): t -> t
    val ( + ): t -> t -> t
    val ( - ): t -> t -> t
    val ( * ): t -> t -> t
    val ( / ): t -> t -> t
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
    let ( ~- ) = M.negate
    let ( + ) = M.add
    let ( - ) = M.substract
    let ( * ) = M.multiply
    let ( / ) = M.divide
    let ( ** ) = M.exponentiate
  end
end
module type S0 = sig
  include Basic.S0
  val square: t -> t
  val exponentiate: t -> int -> t
  module O: Operators.S0 with type t := t
end

# 6 "Traits/Ringoid.ml"
(* @todo Fix spelling of 'subtract' *)
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
    open Int.O

    let exponentiate x n =
      let rec aux y x n =
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
      in
      aux one x n
  end
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      val add_substract: (t * t * t) list
      val negate: (t * t) list
      val multiply: (t * t * t) list
      val divide: (t * t * t) list
      val exponentiate: (t * int * t) list
    end
  end

  module Make0(M: sig
    include S0
    include Representable.S0 with type t := t
    include Equatable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M
    open M.O

    module E = struct
      include E

      let add_substract = add_substract @ [
        (zero, zero, zero);
        (one, zero, one);
      ]

      let negate = negate @ [
        (zero, zero);
      ]

      let multiply = multiply @ [
        (zero, zero, zero);
        (one, zero, zero);
      ]

      let divide = divide @ [
        (zero, one, zero);
        (one, one, one);
      ]

      let exponentiate = exponentiate @ [
        (zero, 0, one);
        (zero, 1, zero);
        (zero, 7, zero);
        (one, 0, one);
        (one, 1, one);
        (one, 7, one);
      ]
    end

    let check = check ~repr ~equal

    let test = "Ringoid" >:: (
      E.add_substract
      |> List.flat_map ~f:(fun (x, y, z) ->
        let rx = repr x and ry = repr y and rz = repr z in
        [
          ~: "add %s %s" rx ry (lazy (check ~expected:z (add x y)));
          ~: "add %s %s" ry rx (lazy (check ~expected:z (add y x)));
          ~: "%s + %s" rx ry (lazy (check ~expected:z (x + y)));
          ~: "%s + %s" ry rx (lazy (check ~expected:z (y + x)));
          ~: "sub %s %s" rz ry (lazy (check ~expected:x (substract z y)));
          ~: "%s - %s" rz ry (lazy (check ~expected:x (z - y)));
          ~: "sub %s %s" rz rx (lazy (check ~expected:y (substract z x)));
          ~: "%s - %s" rz rx (lazy (check ~expected:y (z - x)));
        ]
      )
    ) @ (
      E.negate
      |> List.flat_map ~f:(fun (x, y) ->
        let rx = repr x and ry = repr y in
        [
          ~: "negate %s" rx (lazy (check ~expected:y (negate x)));
          ~: "negate %s" ry (lazy (check ~expected:x (negate y)));
          ~: "-%s" rx (lazy (check ~expected:y (-x)));
          ~: "-%s" ry (lazy (check ~expected:x (-y)));
          ~: "substract zero %s" rx (lazy (check ~expected:y (substract zero x)));
          ~: "substract zero %s" ry (lazy (check ~expected:x (substract zero y)));
          ~: "zero - %s" rx (lazy (check ~expected:y (zero - x)));
          ~: "zero - %s" ry (lazy (check ~expected:x (zero - y)));
          ~: "add %s %s" rx ry (lazy (check ~expected:zero (add x y)));
          ~: "add %s %s" ry rx (lazy (check ~expected:zero (add y x)));
          ~: "%s + %s" rx ry (lazy (check ~expected:zero (x + y)));
          ~: "%s + %s" ry rx (lazy (check ~expected:zero (y + x)));
          ~: "square %s" rx (lazy (check ~expected:(negate (multiply x y)) (square x)));
          ~: "square %s" ry (lazy (check ~expected:(negate (multiply x y)) (square y)));
        ]
      )
    ) @ (
      E.multiply
      |> List.flat_map ~f:(fun (x, y, expected) ->
        let rx = repr x and ry = repr y in
        [
          ~: "multiply %s %s" rx ry (lazy (check ~expected (multiply x y)));
          ~: "%s * %s" rx ry (lazy (check ~expected (x * y)));
        ]
      )
    ) @ (
      E.divide
      |> List.flat_map ~f:(fun (x, y, expected) ->
        let rx = repr x and ry = repr y in
        [
          ~: "divide %s %s" rx ry (lazy (check ~expected (divide x y)));
          ~: "%s / %s" rx ry (lazy (check ~expected (x / y)));
        ]
      )
    ) @ (
      E.exponentiate
      |> List.flat_map ~f:(fun (x, n, expected) ->
        let rx = repr x in
        [
          ~: "exponentiate %s %n" rx n (lazy (check ~expected (exponentiate x n)));
          ~: "%s ** %n" rx n (lazy (check ~expected (x ** n)));
        ]
      )
    )
  end
end
  
# 158 "General.cppo.ml"
  end

  module FilterMapable = struct
# 1 "Traits/FilterMapable.ml"
(* [ToList.|ToArray.|][filter|map|filter_map|flat_map][|_i|_acc] *)

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

# 5 "Traits/FilterMapable.ml"
module ToContainer(C: sig type 'a t end) = struct
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

  
# 8 "Traits/FilterMapable.ml"
  module Tests = struct
    open Testing

    module Make1(M: sig
      type 'a t

      val of_list: 'a list -> 'a t
    end)(ToContainer: sig
      include S1 with type 'a t := 'a M.t
    end)(Container: sig
      val of_list: 'a list -> 'a C.t
      val to_list: 'a C.t -> 'a list
    end) = struct
      open ToContainer

      let test = "FilterMapable.ToContainer" >:: [
        "map" >: (lazy (check_int_list ~expected:[2; 7; 4; 0] ([1; 6; 3; -1] |> M.of_list |> map ~f:((+) 1) |> Container.to_list)));
        "map_i" >: (lazy (check_int_list ~expected:[1; 7; 5; 2] ([1; 6; 3; -1] |> M.of_list |> map_i ~f:(fun ~i x -> i + x) |> Container.to_list)));
        "map_acc" >: (lazy (check_int_list ~expected:[43; 48; 255; 755] ([1; 6; 3; -1] |> M.of_list |> map_acc ~acc:42 ~f:(fun ~acc x -> (acc * x, x + acc)) |> Container.to_list)));
        "filter" >: (lazy (check_int_list ~expected:[3; 15; 9] ([1; 3; 4; 15; 9; 7] |> M.of_list |> filter ~f:(fun x -> x mod 3 = 0) |> Container.to_list)));
        "filter_i" >: (lazy (check_int_list ~expected:[3; 15] ([3; 4; 15; 9; 7] |> M.of_list |> filter_i ~f:(fun ~i x -> i mod 2 = 0 && x mod 3 = 0) |> Container.to_list)));
        "filter_acc" >: (lazy (check_int_list ~expected:[3; 9] ([2; 3; 4; 15; 9; 7] |> M.of_list |> filter_acc ~acc:42 ~f:(fun ~acc x -> (acc + x, acc mod 2 = 0 && x mod 3 = 0)) |> Container.to_list)));
        "filter_map" >: (lazy (check_int_list ~expected:[4; 16; 10] ([1; 3; 4; 15; 9; 7] |> M.of_list |> filter_map ~f:(fun x -> Option.some_if' (x mod 3 = 0) (x + 1)) |> Container.to_list)));
        "filter_map_i" >: (lazy (check_int_list ~expected:[4; 16] ([3; 4; 15; 9; 7] |> M.of_list |> filter_map_i ~f:(fun ~i x -> Option.some_if' (i mod 2 = 0 && x mod 3 = 0) (x + 1)) |> Container.to_list)));
        "filter_map_acc" >: (lazy (check_int_list ~expected:[4; 10] ([2; 3; 4; 15; 9; 7] |> M.of_list |> filter_map_acc ~acc:42 ~f:(fun ~acc x -> (acc + x, Option.some_if' (acc mod 2 = 0 && x mod 3 = 0) (x + 1))) |> Container.to_list)));
        "flat_map" >: (lazy (check_int_list
          ~expected:[1; 2; 4; 3; 6; 9; 4; 8; 12; 16]
          (
            [1; 2; 0; 3; 4]
            |> M.of_list
            |> flat_map ~f:(fun x ->
              IntRange.make x
              |> IntRange.ToList.map ~f:(fun n -> x * (n + 1))
              |> Container.of_list
            )
            |> Container.to_list
          )
        ));
        "flat_map_i" >: (lazy (check_int_list
          ~expected:[1; 3; 6; 6; 12; 18; 8; 16; 24; 32]
          (
            [1; 2; 0; 3; 4]
            |> M.of_list
            |> flat_map_i ~f:(fun ~i x ->
              IntRange.make x
              |> IntRange.ToList.map ~f:(fun n -> (x + i) * (n + 1))
              |> Container.of_list
            )
            |> Container.to_list
          )
        ));
        "flat_map_acc" >: (lazy (check_int_list
          ~expected:[43; 86; 88; 255; 258; 261; 1012; 1016; 1020; 1024]
          (
            [1; 2; 0; 3; 4]
            |> M.of_list
            |> flat_map_acc ~acc:42 ~f:(fun ~acc x ->
              let acc = acc * (x + 1)
              and ys =
                IntRange.make x
                |> IntRange.ToList.map ~f:(fun n -> acc + x * (n + 1))
                |> Container.of_list
              in
              (acc, ys)
            )
            |> Container.to_list
          )
        ));
      ]
    end
  end
end

module ToList = ToContainer(struct type 'a t = 'a list end)

module ToArray = ToContainer(struct type 'a t = 'a array end)

module Tests = struct
  open Testing

  module Make1(M: sig
    include S1

    val to_list: 'a t -> 'a list
    val of_list: 'a list -> 'a t
  end): sig
    val test: Test.t
  end = struct
    module T = ToContainer(M)
    include T.Tests.Make1(M)(M)(M)
  end
end
  
# 162 "General.cppo.ml"
  end

  module Foldable = struct
# 1 "Traits/Foldable.ml"
(* fold[_short][_right][_i|_acc] *)
(* [try_|]reduce[_short][_right][_i|_acc] *)

module Basic = struct
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
# 6 "Traits/Foldable.ml"
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

# 10 "Traits/Foldable.ml"
module Right = struct
  module Basic = struct
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
  
# 13 "Traits/Foldable.ml"
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
# 16 "Traits/Foldable.ml"
end

module Short = struct
  module Basic = struct
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
  
# 21 "Traits/Foldable.ml"
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

  
# 25 "Traits/Foldable.ml"
  module Right = struct
    module Basic = struct
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
    
# 28 "Traits/Foldable.ml"
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
  
# 31 "Traits/Foldable.ml"
  end
end
  
# 166 "General.cppo.ml"
  end

  module Scanable = struct
# 1 "Traits/Scanable.ml"
(* [ToList.|ToArray.|]scan[|_short][|_right][|_i|_acc] *)

(* @feature [try_|]scan_reduce[...] (like [try_|]reduce[...], but returning the intermediate results) *)

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

# 7 "Traits/Scanable.ml"
module ToContainer(C: sig type 'a t end) = struct
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
# 9 "Traits/Scanable.ml"
end

module ToList = ToContainer(struct type 'a t = 'a list end)

module ToArray = ToContainer(struct type 'a t = 'a array end)

module Right = struct
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

  
# 18 "Traits/Scanable.ml"
  module ToContainer(C: sig type 'a t end) = struct
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
  
# 20 "Traits/Scanable.ml"
  end

  module ToList = ToContainer(struct type 'a t = 'a list end)

  module ToArray = ToContainer(struct type 'a t = 'a array end)
end

module Short = struct
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

  
# 30 "Traits/Scanable.ml"
  module ToContainer(C: sig type 'a t end) = struct
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
  
# 32 "Traits/Scanable.ml"
  end

  module ToList = ToContainer(struct type 'a t = 'a list end)

  module ToArray = ToContainer(struct type 'a t = 'a array end)

  module Right = struct
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

    
# 41 "Traits/Scanable.ml"
    module ToContainer(C: sig type 'a t end) = struct
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
    
# 43 "Traits/Scanable.ml"
    end

    module ToList = ToContainer(struct type 'a t = 'a list end)

    module ToArray = ToContainer(struct type 'a t = 'a array end)
  end
end
  
# 170 "General.cppo.ml"
  end
end

module Concepts = struct
  module Identifiable = struct
module Operators = struct
  module type S0 = sig
    type t
    include Traits.Equatable.Operators.S0 with type t := t
  end
end
module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Traits.Equatable.S0 with type t := t and module O := O
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

# 6 "Concepts/Identifiable.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Traits.Equatable.Tests.Examples.S0 with type t := t
      include Traits.Representable.Tests.Examples.S0 with type t := t
    end

    module type Element = sig
      type t

      include Traits.Equatable.Tests.Examples.Element with type t := t
      include Traits.Representable.Tests.Examples.Element with type t := t
    end

    module type S1 = sig
      type 'a t

      module A: Element

      include Traits.Equatable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      include Traits.Representable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
    end

    module type S2 = sig
      type ('a, 'b) t

      module A: Element
      module B: Element

      include Traits.Equatable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      include Traits.Representable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
    end

    module type S3 = sig
      type ('a, 'b, 'c) t

      module A: Element
      module B: Element
      module C: Element

      include Traits.Equatable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      include Traits.Representable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t

      module A: Element
      module B: Element
      module C: Element
      module D: Element

      include Traits.Equatable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      include Traits.Representable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t

      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      include Traits.Equatable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      include Traits.Representable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
    end
  end


  
# 88 "Concepts/Identifiable.ml"
   
  module  Make0 (M:  S0 )(E: Examples. S0  with type   t :=   M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Traits.Equatable.Tests. Make0 (M)(E) in T.test); 
      (let module T = Traits.Representable.Tests. Make0 (M)(E) in T.test); 
    ] 
  end 
  
# 89 "Concepts/Identifiable.ml"
   
  module  Make1 (M:  S1 )(E: Examples. S1  with type  'a t :=  'a M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Traits.Equatable.Tests. Make1 (M)(E) in T.test); 
      (let module T = Traits.Representable.Tests. Make1 (M)(E) in T.test); 
    ] 
  end 
  
# 90 "Concepts/Identifiable.ml"
   
  module  Make2 (M:  S2 )(E: Examples. S2  with type  ('a, 'b) t :=  ('a, 'b) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Traits.Equatable.Tests. Make2 (M)(E) in T.test); 
      (let module T = Traits.Representable.Tests. Make2 (M)(E) in T.test); 
    ] 
  end 
  
# 91 "Concepts/Identifiable.ml"
   
  module  Make3 (M:  S3 )(E: Examples. S3  with type  ('a, 'b, 'c) t :=  ('a, 'b, 'c) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Traits.Equatable.Tests. Make3 (M)(E) in T.test); 
      (let module T = Traits.Representable.Tests. Make3 (M)(E) in T.test); 
    ] 
  end 
  
# 92 "Concepts/Identifiable.ml"
   
  module  Make4 (M:  S4 )(E: Examples. S4  with type  ('a, 'b, 'c, 'd) t :=  ('a, 'b, 'c, 'd) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Traits.Equatable.Tests. Make4 (M)(E) in T.test); 
      (let module T = Traits.Representable.Tests. Make4 (M)(E) in T.test); 
    ] 
  end 
  
# 93 "Concepts/Identifiable.ml"
   
  module  Make5 (M:  S5 )(E: Examples. S5  with type  ('a, 'b, 'c, 'd, 'e) t :=  ('a, 'b, 'c, 'd, 'e) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Traits.Equatable.Tests. Make5 (M)(E) in T.test); 
      (let module T = Traits.Representable.Tests. Make5 (M)(E) in T.test); 
    ] 
  end 

# 96 "Concepts/Identifiable.ml"
end
  
# 176 "General.cppo.ml"
  end

  module Able = struct
module Operators = struct
  module type S0 = sig
    type t
    include Identifiable.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t
  end
end
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

# 6 "Concepts/Able.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Identifiable.Tests.Examples.S0 with type t := t
      include Traits.Comparable.Tests.Examples.S0 with type t := t
    end

    module type Element = sig
      type t

      include Identifiable.Tests.Examples.Element with type t := t
      include Traits.Comparable.Tests.Examples.Element with type t := t
    end

    module type S1 = sig
      type 'a t

      module A: Element

      include Identifiable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
      include Traits.Comparable.Tests.Examples.S1 with type 'a t := 'a t and module A := A
    end

    module type S2 = sig
      type ('a, 'b) t

      module A: Element
      module B: Element

      include Identifiable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
      include Traits.Comparable.Tests.Examples.S2 with type ('a, 'b) t := ('a, 'b) t and module A := A and module B := B
    end

    module type S3 = sig
      type ('a, 'b, 'c) t

      module A: Element
      module B: Element
      module C: Element

      include Identifiable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
      include Traits.Comparable.Tests.Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t and module A := A and module B := B and module C := C
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t

      module A: Element
      module B: Element
      module C: Element
      module D: Element

      include Identifiable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
      include Traits.Comparable.Tests.Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t and module A := A and module B := B and module C := C and module D := D
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t

      module A: Element
      module B: Element
      module C: Element
      module D: Element
      module E: Element

      include Identifiable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
      include Traits.Comparable.Tests.Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t and module A := A and module B := B and module C := C and module D := D and module E := E
    end
  end


  
# 88 "Concepts/Able.ml"
   
  module  Make0 (M:  S0 )(E: Examples. S0  with type   t :=   M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Identifiable.Tests. Make0 (M)(E) in T.test); 
      (let module T = Traits.Comparable.Tests. Make0 (M)(E) in T.test); 
    ] 
  end 
  
# 89 "Concepts/Able.ml"
   
  module  Make1 (M:  S1 )(E: Examples. S1  with type  'a t :=  'a M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Identifiable.Tests. Make1 (M)(E) in T.test); 
      (let module T = Traits.Comparable.Tests. Make1 (M)(E) in T.test); 
    ] 
  end 
  
# 90 "Concepts/Able.ml"
   
  module  Make2 (M:  S2 )(E: Examples. S2  with type  ('a, 'b) t :=  ('a, 'b) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Identifiable.Tests. Make2 (M)(E) in T.test); 
      (let module T = Traits.Comparable.Tests. Make2 (M)(E) in T.test); 
    ] 
  end 
  
# 91 "Concepts/Able.ml"
   
  module  Make3 (M:  S3 )(E: Examples. S3  with type  ('a, 'b, 'c) t :=  ('a, 'b, 'c) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Identifiable.Tests. Make3 (M)(E) in T.test); 
      (let module T = Traits.Comparable.Tests. Make3 (M)(E) in T.test); 
    ] 
  end 
  
# 92 "Concepts/Able.ml"
   
  module  Make4 (M:  S4 )(E: Examples. S4  with type  ('a, 'b, 'c, 'd) t :=  ('a, 'b, 'c, 'd) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Identifiable.Tests. Make4 (M)(E) in T.test); 
      (let module T = Traits.Comparable.Tests. Make4 (M)(E) in T.test); 
    ] 
  end 
  
# 93 "Concepts/Able.ml"
   
  module  Make5 (M:  S5 )(E: Examples. S5  with type  ('a, 'b, 'c, 'd, 'e) t :=  ('a, 'b, 'c, 'd, 'e) M.t) = struct 
    let test = "Able" >:: [ 
      (let module T = Identifiable.Tests. Make5 (M)(E) in T.test); 
      (let module T = Traits.Comparable.Tests. Make5 (M)(E) in T.test); 
    ] 
  end 

# 96 "Concepts/Able.ml"
end
  
# 180 "General.cppo.ml"
  end

  module Number = struct
module Operators = struct
  module type S0 = sig
    type t
    include Traits.Equatable.Operators.S0 with type t := t
    include Traits.Ringoid.Operators.S0 with type t := t
  end
end
module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Traits.Displayable.S0 with type t := t
  include Traits.Equatable.S0 with type t := t and module O := O
  include Traits.Parsable.S0 with type t := t
  include Traits.Representable.S0 with type t := t
  include Traits.Ringoid.S0 with type t := t and module O := O
  include Traits.OfStandardNumbers.S0 with type t := t
end

# 6 "Concepts/Number.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Traits.Displayable.Tests.Examples.S0 with type t := t
      include Traits.Equatable.Tests.Examples.S0 with type t := t
      include Traits.Parsable.Tests.Examples.S0 with type t := t
      include Traits.Representable.Tests.Examples.S0 with type t := t
      include Traits.Ringoid.Tests.Examples.S0 with type t := t
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M

    module E = struct
      include E

      let equal = equal @ [
        [zero; of_int 0; of_float 0.; M.of_string "0"];
        [one; of_int 1; of_float 1.; M.of_string "1"];
      ]

      let different = different @ [
        (zero, one);
      ]
    end

    let test = "Number" >:: [
      (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Equatable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Parsable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Representable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Ringoid.Tests.Make0(M)(E) in T.test);
    ]
  end
end
  
# 184 "General.cppo.ml"
  end

  module RealNumber = struct
module Operators = struct
  module type S0 = sig
    type t
    include Number.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t
    val ( mod ): t -> t -> t
  end
end
module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include Number.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O
  include Traits.ToStandardNumbers.S0 with type t := t
  val abs: t -> t
  val modulo: t -> t -> t
end

# 6 "Concepts/RealNumber.ml"
module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Number.Tests.Examples.S0 with type t := t
      include Traits.Comparable.Tests.Examples.S0 with type t := t
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M

    module E = struct
      include E

      let ordered = ordered @ [
        [zero; one];
      ]
    end

    let check = check ~repr ~equal

    let test = "RealNumber" >:: [
      (let module T = Number.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
    ] @ (
      E.negate
      |> List.flat_map ~f:(fun (x, y) ->
        let abs_x = if greater_or_equal x zero then x else y
        and abs_y = if greater_or_equal y zero then y else x in
        [
          ~: "abs %s" (repr x) (lazy (check ~expected:abs_x (abs x)));
          ~: "abs %s" (repr y) (lazy (check ~expected:abs_y (abs y)));
        ]
      )
    ) @ [
      "to_int zero" >: (lazy (check_int ~expected:0 (to_int zero)));
      "to_float zero" >: (lazy (check_float_exact ~expected:0. (to_float zero)));
      "to_int one" >: (lazy (check_int ~expected:1 (to_int one)));
      "to_float one" >: (lazy (check_float_exact ~expected:1. (to_float one)));
    ]
  end
end
  
# 188 "General.cppo.ml"
  end

  module Integer = struct
# 1 "Concepts/Integer.signatures.ml"
module type S0 = sig
  type t

  include RealNumber.S0 with type t := t
  include Traits.PredSucc.S0 with type t := t

  (* @feature Bitwise? *)
  (* @feature gcd, lcm, quomod *)
end

# 3 "Concepts/Integer.ml"
module Tests = struct
  open Testing

  module Make0(M: S0)(E: sig
    include RealNumber.Tests.Examples.S0 with type t := M.t
    include Traits.PredSucc.Tests.Examples.S0 with type t := M.t
  end): sig val test: Test.t end = struct
    open M

    module E = struct
      include E

      let succ = succ @ [
        (zero, one);
      ]
    end

    let test = "Integer" >:: [
      (let module T = RealNumber.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.PredSucc.Tests.Make0(M)(E) in T.test);
    ]
  end
end
  
# 192 "General.cppo.ml"
  end
end

module Array = struct
# 1 "Implementation/Array.ml"
type 'a t = 'a array

module OCSA = OCamlStandard.Array


let empty = [||]

let singleton x = [|x|]

let repeat x ~size = OCSA.make size x

let of_list = OCSA.of_list

let to_list = OCSA.to_list

(* @todo Should we copy arrays here? *)
let of_array = Functions.Function1.identity

let to_array = Functions.Function1.identity

let get = OCSA.get

let set = OCSA.set

let size = OCSA.length
# 197 "General.cppo.ml"
end

module Exception = struct
# 1 "Implementation/Exception.ml"
(* The position of these symbols is tested below. Moving them requires fixing the tests *)
[@@@ocaml.warning "-8"]
let match_failure = lazy (let 0 = 1 in 0) (*BISECT-IGNORE*)
[@@@ocaml.warning "+8"]
let assert_failure = lazy (assert false)
(* End of symbols to not move *)

module OCSP = OCamlStandard.Pervasives
module OCSL = OCamlStandard.List

include Foundations.Exception

let failure_if condition format =
  Format.with_result
    ~f:(fun message -> if condition then raise (Failure message))
    format

let failure_unless condition format =
  Format.with_result
    ~f:(fun message -> if not condition then raise (Failure message))
    format

module Tests = struct
  open Testing

  exception TestException

  module Examples = struct
    let equal = [
      [Failure "foo"];
    ]

    let different = [
      (Failure "foo", Failure "bar");
      (Failure "foo", InvalidArgument "foo");
    ]

    let repr = [
      (DivisionByZero, "Division_by_zero");
    ]

    let to_string = repr
  end

  let test = "Exception" >:: [
    (let module T = Concepts.Identifiable.Tests.Make0(Foundations.Exception)(Examples) in T.test);
    (let module T = Traits.Displayable.Tests.Make0(Foundations.Exception)(Examples) in T.test);
    "raise" >: (lazy (expect_exception ~expected:TestException (lazy (raise TestException))));
    "raise_without_backtrace" >: (lazy (expect_exception ~expected:TestException (lazy (raise_without_backtrace TestException))));
    "failure" >: (lazy (expect_exception ~expected:(Failure "Foo bar 42") (lazy (failure "Foo %s %n" "bar" 42))));
    "invalid_argument" >: (lazy (expect_exception ~expected:(Invalid_argument "Grmbl baz 43") (lazy (invalid_argument "Grmbl %s %n" "baz" 43))));
    "Aliases" >:: [
      "MatchFailure = Match_failure" >: (lazy (expect_exception ~expected:(MatchFailure ("Implementation/Exception.ml", 3, 30)) match_failure));
      "AssertFailure = Assert_failure" >: (lazy (expect_exception ~expected:(AssertFailure ("Implementation/Exception.ml", 5, 26)) assert_failure));
      "InvalidArgument = Invalid_argument" >: (lazy (expect_exception ~expected:(InvalidArgument "List.nth") (lazy (OCSL.nth [] (-1)))));
      "Failure = Failure" >: (lazy (expect_exception ~expected:(Failure "foo") (lazy (OCSP.failwith "foo"))));
      "NotFound = Not_found" >: (lazy (expect_exception ~expected:NotFound (lazy (OCSL.find (fun _ -> true) [])))); (*BISECT-IGNORE*)
      (* "OutOfMemory = Out_of_memory" >: (lazy (expect_exception ~expected:OutOfMemory (lazy ()))); *)
      "StackOverflow = Stack_overflow" >: (lazy (expect_exception ~expected:StackOverflow (lazy (let rec f x = 1 + (f x) in f 0))));
      (* "SysError = Sys_error" >: (lazy (expect_exception ~expected:SysError (lazy ()))); *)
      (* "EndOfFile = End_of_file" >: (lazy (expect_exception ~expected:EndOfFile (lazy ()))); *)
      "DivisionByZero = Division_by_zero" >: (lazy (expect_exception ~expected:DivisionByZero (lazy (1 / 0))));
      (* "SysBlockedIO = Sys_blocked_io" >: (lazy (expect_exception ~expected:SysBlockedIO (lazy ()))); *)
      (* "UndefinedRecursiveModule = Undefined_recursive_module" >: (lazy (expect_exception ~expected:UndefinedRecursiveModule (lazy ()))); *)

      "Exit = Pervasives.Exit" >: (lazy (expect_exception ~expected:Exit (lazy (raise Exit))));
    ]
  ]
end
# 201 "General.cppo.ml"
end

module Format = struct
# 1 "Implementation/Format.ml"
include Foundations.Format
# 205 "General.cppo.ml"
end

module StandardInt = struct
# 1 "Implementation/StandardInt.ml"
module Make(M: sig
  type t

  val name: string
  val repr_suffix: string

  val zero: t
  val one: t
  (* val minus_one: t *)
  val neg: t -> t
  val add: t -> t -> t
  val sub: t -> t -> t
  val mul: t -> t -> t
  val div: t -> t -> t
  val rem: t -> t -> t
  val succ: t -> t
  val pred: t -> t
  val abs: t -> t
  val max_int: t
  val min_int: t
  (* val logand: t -> t -> t *)
  (* val logor: t -> t -> t *)
  (* val logxor: t -> t -> t *)
  (* val lognot: t -> t *)
  (* val shift_left: t -> int -> t *)
  (* val shift_right: t -> int -> t *)
  (* val shift_right_logical: t -> int -> t *)
  val of_int: int -> t
  val to_int: t -> int
  val of_float: float -> t
  val to_float: t -> float
  val of_string: string -> t
  val to_string: t -> string
  val compare: t -> t -> int
  val equal: t -> t -> bool
end): sig
  type t = M.t

  include Concepts.Integer.S0 with type t := t

  val smallest: t
  val greatest: t
end = struct
  module SelfA = struct
    open M

    type nonrec t = t

    let zero = zero
    let one = one
    let greatest = max_int
    let smallest = min_int

    let of_float = of_float
    let to_float = to_float
    let of_int = of_int
    let to_int = to_int
    let of_string = of_string
    let try_of_string s =
      Exception.or_none (lazy (of_string s))
    let to_string = to_string
    let repr n =
      Format.apply "%s%s" (to_string n) repr_suffix

    let abs = abs

    let succ = succ
    let pred = pred

    let negate = neg
    let add = add
    let substract = sub
    let multiply = mul
    let divide = div
    let modulo = rem

    let compare = Compare.of_standard compare
    let equal = equal
  end

  module SelfB = struct
    include Traits.Comparable.GreaterLessThan.Make0(SelfA)
    include Traits.Comparable.MinMax.Make0(SelfA)
    include Traits.Equatable.Different.Make0(SelfA)
    include Traits.Ringoid.Square.Make0(SelfA)

    include SelfA
  end

  module SelfC = struct
    include Traits.Ringoid.Exponentiate.Make0(struct
      include SelfB

      let exponentiate_negative_exponent ~exponentiate:_ _ n =
        Exception.invalid_argument "%s.exponentiate: Negative exponent: %i" M.name n
    end)
    include Traits.Comparable.Between.Make0(SelfB)

    include SelfB
  end

  module Self = struct
    module O = struct
      include Traits.Comparable.Operators.Make0(SelfC)
      include Traits.Equatable.Operators.Make0(SelfC)
      include Traits.Ringoid.Operators.Make0(SelfC)

      let (mod) = SelfC.modulo
    end

    include SelfC
  end

  include Self
end
# 209 "General.cppo.ml"
end

module Int32 = struct
# 1 "Implementation/Int32.ml"
module OCSI = OCamlStandard.Int32

module Self = StandardInt.Make(struct
  include OCSI

  let name = "Int32"
  let repr_suffix = "l"

  
# 10 "Implementation/Int32.ml"
  let equal = Equate.Poly.equal
# 12 "Implementation/Int32.ml"
end)

include Self

module Examples = struct
  let of_string = [
    ("43", 43l);
    ("-12", -12l);
  ]

  let repr = [
    (-3l, "-3l");
    (-0l, "0l");
    (0l, "0l");
    (1l, "1l");
    (15l, "15l");
  ]

  let to_string = [
    (-3l, "-3");
    (-0l, "0");
    (0l, "0");
    (1l, "1");
    (15l, "15");
  ]

  let equal = [
    [0l];
    [1l];
    [2l];
  ]

  let different = [
    (0l, 1l);
    (1l, -1l);
  ]

  let ordered = [
    [-10l; -5l; -1l; 0l; 1l; 2l; 5l];
  ]

  let add_substract = [
    (4l, 3l, 7l);
    (4l, -2l, 2l);
    (5l, -7l, -2l);
  ]

  let negate = [
    (4l, -4l);
    (-7l, 7l);
  ]

  let multiply = [
    (4l, 3l, 12l);
    (4l, -3l, -12l);
    (-4l, -3l, 12l);
  ]

  let divide = [
    (5l, 2l, 2l);
    (4l, 2l, 2l);
    (4l, 3l, 1l);
    (4l, 4l, 1l);
    (4l, 5l, 0l);
  ]

  let exponentiate = [
    (3l, 3, 27l);
    (2l, 7, 128l);
  ]

  let succ = [
    (1l, 2l);
    (42l, 43l);
    (-121l, -120l);
  ]
end

module Tests = struct
  open Testing

  let test = "Int32" >:: [
    (let module T = Concepts.Integer.Tests.Make0(Self)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(Self)(Examples) in T.test);
    "exponentiate 2l (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int32.exponentiate: Negative exponent: -4") (lazy (exponentiate 2l (-4)))));
  ]
end
# 213 "General.cppo.ml"
end

module Int64 = struct
# 1 "Implementation/Int64.ml"
module OCSI = OCamlStandard.Int64

module Self = StandardInt.Make(struct
  include OCSI

  let name = "Int64"
  let repr_suffix = "L"

  
# 10 "Implementation/Int64.ml"
  let equal = Equate.Poly.equal
# 12 "Implementation/Int64.ml"
end)

include Self

module Examples = struct
  let of_string = [
    ("43", 43L);
    ("-12", -12L);
  ]

  let repr = [
    (-3L, "-3L");
    (-0L, "0L");
    (0L, "0L");
    (1L, "1L");
    (15L, "15L");
  ]

  let to_string = [
    (-3L, "-3");
    (-0L, "0");
    (0L, "0");
    (1L, "1");
    (15L, "15");
  ]

  let equal = [
    [0L];
    [1L];
    [2L];
  ]

  let different = [
    (0L, 1L);
    (1L, -1L);
  ]

  let ordered = [
    [-10L; -5L; -1L; 0L; 1L; 2L; 5L];
  ]

  let add_substract = [
    (4L, 3L, 7L);
    (4L, -2L, 2L);
    (5L, -7L, -2L);
  ]

  let negate = [
    (4L, -4L);
    (-7L, 7L);
  ]

  let multiply = [
    (4L, 3L, 12L);
    (4L, -3L, -12L);
    (-4L, -3L, 12L);
  ]

  let divide = [
    (5L, 2L, 2L);
    (4L, 2L, 2L);
    (4L, 3L, 1L);
    (4L, 4L, 1L);
    (4L, 5L, 0L);
  ]

  let exponentiate = [
    (3L, 3, 27L);
    (2L, 7, 128L);
  ]

  let succ = [
    (1L, 2L);
    (42L, 43L);
    (-121L, -120L);
  ]
end

module Tests = struct
  open Testing

  let test = "Int64" >:: [
    (let module T = Concepts.Integer.Tests.Make0(Self)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(Self)(Examples) in T.test);
    "exponentiate 2L (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int64.exponentiate: Negative exponent: -4") (lazy (exponentiate 2L (-4)))));
  ]
end
# 217 "General.cppo.ml"
end

module Float = struct
# 1 "Implementation/Float.ml"
module SelfA = struct
  include Foundations.Float

  include Traits.Ringoid.Exponentiate.Make0(struct
    include Foundations.Float

    let exponentiate_negative_exponent ~exponentiate x n =
      exponentiate (divide 1. x) (-n)
  end)

  include Traits.Comparable.Between.Make0(Foundations.Float)
end

module SelfB = struct
  module O = struct
    include SelfA.O

    let ( ** ) = SelfA.exponentiate
  end

  include (SelfA: module type of SelfA[@remove_aliases] with module O := O)
end

include SelfB

module Examples = struct
  let repr = [
    (-3., "-3.");
    (-0., "-0.");
    (0., "0.");
    (1., "1.");
    (15., "15.");
  ]

  let to_string = repr

  let of_string = [
    ("0", 0.);
    ("1", 1.);
    ("1.0", 1.);
    ("-1", -1.);
    ("1_000", 1000.);
  ]

  let equal = [
    [0.];
    [1.];
    [2.];
    [infinity];
    [negative_infinity];
  ]

  let different = [
    (0., 1.);
    (1., -1.);
    (not_a_number, infinity);
    (not_a_number, negative_infinity);
    (not_a_number, 1.);
    (not_a_number, 0.);
    (not_a_number, not_a_number);
  ]

  let ordered = [
    [-10.; -5.; -1.; -0.2; 0.; 0.7; 1.; 2.; 5.];
  ]

  let add_substract = [
    (4., 3., 7.);
    (4., -2., 2.);
    (5., -7., -2.);
  ]

  let negate = [
    (4., -4.);
    (-7., 7.);
  ]

  let multiply = [
    (4., 3., 12.);
    (4., -3., -12.);
    (-4., -3., 12.);
  ]

  let divide = [
    (5., 2., 2.5);
    (4., 2., 2.);
    (1., 4., 0.25);
    (4., 4., 1.);
    (4., 5., 0.8);
  ]

  let exponentiate = [
    (3., 3, 27.);
    (2., 7, 128.);
    (0.5, 4, 0.0625);
    (2., -4, 0.0625);
  ]
end

module ClassExamples = struct
  open SelfB.Class

  let repr = [
    (Normal, "Normal");
    (SubNormal, "SubNormal");
    (Zero, "Zero");
    (Infinite, "Infinite");
    (NotANumber, "NotANumber");
  ]

  let equal = [
    [Normal];
    [SubNormal];
    [Zero];
    [Infinite];
    [NotANumber];
  ]

  let different = [
    (Normal, SubNormal);
  ]

  let ordered = [
    [Normal; SubNormal; Zero; Infinite; NotANumber];
  ]
end

module Tests = struct
  open Testing

  let test = "Float" >:: [
    (let module T = Concepts.RealNumber.Tests.Make0(SelfB)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(SelfB)(Examples) in T.test);
    "ceil" >:: (
      let make x expected =
        ~: "%f" x (lazy (check_float_exact ~expected (ceil x)))
      in
      [
        make (-1.) (-1.);
        make (-0.99) 0.;
        make (-0.1) 0.;
        make 0. 0.;
        make 0.01 1.;
        make 0.99 1.;
        make 1. 1.;
      ]
    );
    "Class" >:: [
      (let module T = Traits.Comparable.Tests.Make0(SelfB.Class)(ClassExamples) in T.test);
      (let module T = Traits.Equatable.Tests.Make0(SelfB.Class)(ClassExamples) in T.test);
      (let module T = Traits.Representable.Tests.Make0(SelfB.Class)(ClassExamples) in T.test);
      "of_float" >:: SelfB.Class.(
        let check = check ~repr ~equal in
        [
          "Normal" >: (lazy (check ~expected:Normal (of_float 1.)));
          "SubNormal" >: (lazy (check ~expected:SubNormal (of_float (1. /. greatest))));
          "Zero" >: (lazy (check ~expected:Zero (of_float 0.)));
          "Zero-" >: (lazy (check ~expected:Zero (of_float (-0.))));
          "Infinite+" >: (lazy (check ~expected:Infinite (of_float (1. /. 0.))));
          "Infinite+" >: (lazy (check ~expected:Infinite (of_float infinity)));
          "Infinite-" >: (lazy (check ~expected:Infinite (of_float (-1. /. 0.))));
          "Infinite-" >: (lazy (check ~expected:Infinite (of_float negative_infinity)));
          "NotANumber" >: (lazy (check ~expected:NotANumber (of_float (0. /. 0.))));
          "NotANumber" >: (lazy (check ~expected:NotANumber (of_float not_a_number)));
          "NotANumber-" >: (lazy (check ~expected:NotANumber (of_float (-0. /. 0.))));
        ]
      );
    ];
  ]
end
# 221 "General.cppo.ml"
end

module BigInt = struct
# 1 "Implementation/BigInt.ml"
module OCSB = OCamlStandard.Big_int

module SelfA = struct
  type t = OCSB.big_int

  let zero = OCSB.zero_big_int
  let one = OCSB.unit_big_int

  let of_int = OCSB.big_int_of_int
  let to_int = OCSB.int_of_big_int

  let of_float x =
    let of_small_float x =
      x
      |> Int64.of_float
      |> OCSB.big_int_of_int64
    and breakpoint =
      58 (* Any integer between 53 and 63 (included) works, because floats have 53 significant bits and int64s have 63 significant bits *)
    in
    let (significand, exponent) = Float.to_parts x in
    if exponent <= breakpoint then
      of_small_float x
    else
      OCSB.shift_left_big_int
        (of_small_float (Float.of_parts ~significand ~exponent:breakpoint))
        (exponent - breakpoint)

  let to_float = OCSB.float_of_big_int
  let of_string = OCSB.big_int_of_string
  let try_of_string s =
    Exception.or_none (lazy (of_string s))
  let to_string = OCSB.string_of_big_int

  let repr = to_string

  let abs = OCSB.abs_big_int

  let negate = OCSB.minus_big_int
  let add = OCSB.add_big_int
  let substract = OCSB.sub_big_int
  let multiply = OCSB.mult_big_int
  let divide = OCSB.div_big_int
  let modulo = OCSB.mod_big_int
  let square = OCSB.square_big_int
  let exponentiate x n =
    if n < 0 then
      Exception.invalid_argument "BigInt.exponentiate: Negative exponent: %i" n
    else
      OCSB.power_big_int_positive_int x n

  let pred = OCSB.pred_big_int
  let succ = OCSB.succ_big_int

  let equal = OCSB.eq_big_int

  let compare = Compare.of_standard OCSB.compare_big_int
  let less_than = OCSB.lt_big_int
  let less_or_equal = OCSB.le_big_int
  let greater_than = OCSB.gt_big_int
  let greater_or_equal = OCSB.ge_big_int
end

module SelfB = struct
  include SelfA

  include Traits.Comparable.Between.Make0(SelfA)
  include Traits.Comparable.MinMax.Make0(SelfA)
  include Traits.Equatable.Different.Make0(SelfA)
end

module Self = struct
  include SelfB

  module O = struct
    include Traits.Comparable.Operators.Make0(SelfB)
    include Traits.Equatable.Operators.Make0(SelfB)
    include Traits.Ringoid.Operators.Make0(SelfB)

    let (mod) = modulo
  end
end

include Self

module Examples = struct
  let i = OCSB.big_int_of_int
  let s = OCSB.big_int_of_string

  let succ = [
    (i 4, i 5);
    (i (-6), i (-5));
  ]

  let equal = [
    [i 4];
    [i (-10)];
  ]

  let ordered = [
    [i (-3); i (-1); zero; one; i 5];
  ]

  let exponentiate = [
    (i 10, 10, s "10000000000");
    (i 10, 40, s "10000000000000000000000000000000000000000");
  ]

  let divide = [
    (i 45, i 9, i 5);
  ]

  let multiply = [
    (i 7, i 3, i 21);
  ]

  let negate = [
    (i (-12), i 12);
  ]

  let add_substract = [
    (i 100, i 27, i 127);
  ]

  let repr = [
    (i 10, "10");
    (s "10000000000000000000000000000000000000000", "10000000000000000000000000000000000000000");
  ]

  let to_string = repr

  let different = [
    (i 10, i 11);
  ]

  let of_string = [
    ("100000", i 100000);
  ]
end

module Tests = struct
  open Testing

  let test = "BigInt" >:: [
    (let module T = Concepts.Integer.Tests.Make0(Self)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(Self)(Examples) in T.test);
    "exponentiate (of_int 2) (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "BigInt.exponentiate: Negative exponent: -4") (lazy (exponentiate (of_int 2) (-4)))));
    "of_float" >:: (
      let check ~expected x =
        check ~repr ~equal ~expected:(of_string expected) (of_float x)
      in
      let make_2p p expected =
        (* This tests only the most significant bit *)
        ~: "2 ^ %i" p (lazy (check ~expected (2. ** (Float.of_int p))))
      and make_2pm2q p q expected =
        (* This can test all bits if q = max 0 (p - 53) *)
        ~: "2 ^ %i - 2 ^ %i" p q (lazy (check ~expected (2. ** (Float.of_int p) -. 2. ** (Float.of_int q))))
      in
      [
        (* http://www.wolframalpha.com/input/?i=2^95+-+2^42 *)
        make_2pm2q 0 0 "0";
        make_2pm2q 1 0 "1";
        make_2pm2q 2 0 "3";
        make_2pm2q 3 0 "7";
        make_2pm2q 50 0 "1125899906842623";
        make_2pm2q 51 0 "2251799813685247";
        make_2pm2q 52 0 "4503599627370495";
        make_2pm2q 53 0 "9007199254740991";
        make_2pm2q 54 1 "18014398509481982";
        make_2pm2q 55 2 "36028797018963964";
        make_2pm2q 56 3 "72057594037927928";
        make_2pm2q 57 4 "144115188075855856";
        make_2pm2q 95 42 "39614081257132164398725464064";
        (* http://www.tsm-resources.com/alists/pow2.html *)
        make_2p 1 "2";
        make_2p 2 "4";
        make_2p 3 "8";
        make_2p 4 "16";
        make_2p 5 "32";
        make_2p 6 "64";
        make_2p 7 "128";
        make_2p 8 "256";
        make_2p 9 "512";
        make_2p 10 "1024";
        make_2p 11 "2048";
        make_2p 12 "4096";
        make_2p 13 "8192";
        make_2p 14 "16384";
        make_2p 15 "32768";
        make_2p 16 "65536";
        make_2p 17 "131072";
        make_2p 18 "262144";
        make_2p 19 "524288";
        make_2p 20 "1048576";
        make_2p 21 "2097152";
        make_2p 22 "4194304";
        make_2p 23 "8388608";
        make_2p 24 "16777216";
        make_2p 25 "33554432";
        make_2p 26 "67108864";
        make_2p 27 "134217728";
        make_2p 28 "268435456";
        make_2p 29 "536870912";
        make_2p 30 "1073741824";
        make_2p 31 "2147483648";
        make_2p 32 "4294967296";
        make_2p 33 "8589934592";
        make_2p 34 "17179869184";
        make_2p 35 "34359738368";
        make_2p 36 "68719476736";
        make_2p 37 "137438953472";
        make_2p 38 "274877906944";
        make_2p 39 "549755813888";
        make_2p 40 "1099511627776";
        make_2p 41 "2199023255552";
        make_2p 42 "4398046511104";
        make_2p 43 "8796093022208";
        make_2p 44 "17592186044416";
        make_2p 45 "35184372088832";
        make_2p 46 "70368744177664";
        make_2p 47 "140737488355328";
        make_2p 48 "281474976710656";
        make_2p 49 "562949953421312";
        make_2p 50 "1125899906842624";
        make_2p 51 "2251799813685248";
        make_2p 52 "4503599627370496";
        make_2p 53 "9007199254740992";
        make_2p 54 "18014398509481984";
        make_2p 55 "36028797018963968";
        make_2p 56 "72057594037927936";
        make_2p 57 "144115188075855872";
        make_2p 58 "288230376151711744";
        make_2p 59 "576460752303423488";
        make_2p 60 "1152921504606846976";
        make_2p 61 "2305843009213693952";
        make_2p 62 "4611686018427387904";
        make_2p 63 "9223372036854775808";
        make_2p 64 "18446744073709551616";
        make_2p 65 "36893488147419103232";
        make_2p 66 "73786976294838206464";
        make_2p 67 "147573952589676412928";
        make_2p 68 "295147905179352825856";
        make_2p 69 "590295810358705651712";
        make_2p 70 "1180591620717411303424";
        make_2p 71 "2361183241434822606848";
        make_2p 72 "4722366482869645213696";
        make_2p 73 "9444732965739290427392";
        make_2p 74 "18889465931478580854784";
        make_2p 75 "37778931862957161709568";
        make_2p 76 "75557863725914323419136";
        make_2p 77 "151115727451828646838272";
        make_2p 78 "302231454903657293676544";
        make_2p 79 "604462909807314587353088";
        make_2p 80 "1208925819614629174706176";
        make_2p 81 "2417851639229258349412352";
        make_2p 82 "4835703278458516698824704";
        make_2p 83 "9671406556917033397649408";
        make_2p 84 "19342813113834066795298816";
        make_2p 85 "38685626227668133590597632";
        make_2p 86 "77371252455336267181195264";
        make_2p 87 "154742504910672534362390528";
        make_2p 88 "309485009821345068724781056";
        make_2p 89 "618970019642690137449562112";
        make_2p 90 "1237940039285380274899124224";
        make_2p 91 "2475880078570760549798248448";
        make_2p 92 "4951760157141521099596496896";
        make_2p 93 "9903520314283042199192993792";
        make_2p 94 "19807040628566084398385987584";
        make_2p 95 "39614081257132168796771975168";
        make_2p 96 "79228162514264337593543950336";
        make_2p 97 "158456325028528675187087900672";
        make_2p 98 "316912650057057350374175801344";
        make_2p 99 "633825300114114700748351602688";
        make_2p 100 "1267650600228229401496703205376";
        make_2p 101 "2535301200456458802993406410752";
        make_2p 102 "5070602400912917605986812821504";
        make_2p 103 "10141204801825835211973625643008";
        make_2p 104 "20282409603651670423947251286016";
        make_2p 105 "40564819207303340847894502572032";
        make_2p 106 "81129638414606681695789005144064";
        make_2p 107 "162259276829213363391578010288128";
        make_2p 108 "324518553658426726783156020576256";
        make_2p 109 "649037107316853453566312041152512";
        make_2p 110 "1298074214633706907132624082305024";
        make_2p 111 "2596148429267413814265248164610048";
        make_2p 112 "5192296858534827628530496329220096";
        make_2p 113 "10384593717069655257060992658440192";
        make_2p 114 "20769187434139310514121985316880384";
        make_2p 115 "41538374868278621028243970633760768";
        make_2p 116 "83076749736557242056487941267521536";
        make_2p 117 "166153499473114484112975882535043072";
        make_2p 118 "332306998946228968225951765070086144";
        make_2p 119 "664613997892457936451903530140172288";
        make_2p 120 "1329227995784915872903807060280344576";
        make_2p 121 "2658455991569831745807614120560689152";
        make_2p 122 "5316911983139663491615228241121378304";
        make_2p 123 "10633823966279326983230456482242756608";
        make_2p 124 "21267647932558653966460912964485513216";
        make_2p 125 "42535295865117307932921825928971026432";
        make_2p 126 "85070591730234615865843651857942052864";
        make_2p 127 "170141183460469231731687303715884105728";
        make_2p 128 "340282366920938463463374607431768211456";
        make_2p 129 "680564733841876926926749214863536422912";
        make_2p 130 "1361129467683753853853498429727072845824";
        make_2p 131 "2722258935367507707706996859454145691648";
        make_2p 132 "5444517870735015415413993718908291383296";
        make_2p 133 "10889035741470030830827987437816582766592";
        make_2p 134 "21778071482940061661655974875633165533184";
        make_2p 135 "43556142965880123323311949751266331066368";
        make_2p 136 "87112285931760246646623899502532662132736";
        make_2p 137 "174224571863520493293247799005065324265472";
        make_2p 138 "348449143727040986586495598010130648530944";
        make_2p 139 "696898287454081973172991196020261297061888";
        make_2p 140 "1393796574908163946345982392040522594123776";
        make_2p 141 "2787593149816327892691964784081045188247552";
        make_2p 142 "5575186299632655785383929568162090376495104";
        make_2p 143 "11150372599265311570767859136324180752990208";
        make_2p 144 "22300745198530623141535718272648361505980416";
        make_2p 145 "44601490397061246283071436545296723011960832";
        make_2p 146 "89202980794122492566142873090593446023921664";
        make_2p 147 "178405961588244985132285746181186892047843328";
        make_2p 148 "356811923176489970264571492362373784095686656";
        make_2p 149 "713623846352979940529142984724747568191373312";
        make_2p 150 "1427247692705959881058285969449495136382746624";
        make_2p 151 "2854495385411919762116571938898990272765493248";
        make_2p 152 "5708990770823839524233143877797980545530986496";
        make_2p 153 "11417981541647679048466287755595961091061972992";
        make_2p 154 "22835963083295358096932575511191922182123945984";
        make_2p 155 "45671926166590716193865151022383844364247891968";
        make_2p 156 "91343852333181432387730302044767688728495783936";
        make_2p 157 "182687704666362864775460604089535377456991567872";
        make_2p 158 "365375409332725729550921208179070754913983135744";
        make_2p 159 "730750818665451459101842416358141509827966271488";
        make_2p 160 "1461501637330902918203684832716283019655932542976";
        make_2p 161 "2923003274661805836407369665432566039311865085952";
        make_2p 162 "5846006549323611672814739330865132078623730171904";
        make_2p 163 "11692013098647223345629478661730264157247460343808";
        make_2p 164 "23384026197294446691258957323460528314494920687616";
        make_2p 165 "46768052394588893382517914646921056628989841375232";
        make_2p 166 "93536104789177786765035829293842113257979682750464";
        make_2p 167 "187072209578355573530071658587684226515959365500928";
        make_2p 168 "374144419156711147060143317175368453031918731001856";
        make_2p 169 "748288838313422294120286634350736906063837462003712";
        make_2p 170 "1496577676626844588240573268701473812127674924007424";
        make_2p 171 "2993155353253689176481146537402947624255349848014848";
        make_2p 172 "5986310706507378352962293074805895248510699696029696";
        make_2p 173 "11972621413014756705924586149611790497021399392059392";
        make_2p 174 "23945242826029513411849172299223580994042798784118784";
        make_2p 175 "47890485652059026823698344598447161988085597568237568";
        make_2p 176 "95780971304118053647396689196894323976171195136475136";
        make_2p 177 "191561942608236107294793378393788647952342390272950272";
        make_2p 178 "383123885216472214589586756787577295904684780545900544";
        make_2p 179 "766247770432944429179173513575154591809369561091801088";
        make_2p 180 "1532495540865888858358347027150309183618739122183602176";
        make_2p 181 "3064991081731777716716694054300618367237478244367204352";
        make_2p 182 "6129982163463555433433388108601236734474956488734408704";
        make_2p 183 "12259964326927110866866776217202473468949912977468817408";
        make_2p 184 "24519928653854221733733552434404946937899825954937634816";
        make_2p 185 "49039857307708443467467104868809893875799651909875269632";
        make_2p 186 "98079714615416886934934209737619787751599303819750539264";
        make_2p 187 "196159429230833773869868419475239575503198607639501078528";
        make_2p 188 "392318858461667547739736838950479151006397215279002157056";
        make_2p 189 "784637716923335095479473677900958302012794430558004314112";
        make_2p 190 "1569275433846670190958947355801916604025588861116008628224";
        make_2p 191 "3138550867693340381917894711603833208051177722232017256448";
        make_2p 192 "6277101735386680763835789423207666416102355444464034512896";
        make_2p 193 "12554203470773361527671578846415332832204710888928069025792";
        make_2p 194 "25108406941546723055343157692830665664409421777856138051584";
        make_2p 195 "50216813883093446110686315385661331328818843555712276103168";
        make_2p 196 "100433627766186892221372630771322662657637687111424552206336";
        make_2p 197 "200867255532373784442745261542645325315275374222849104412672";
        make_2p 198 "401734511064747568885490523085290650630550748445698208825344";
        make_2p 199 "803469022129495137770981046170581301261101496891396417650688";
        make_2p 200 "1606938044258990275541962092341162602522202993782792835301376";
        make_2p 201 "3213876088517980551083924184682325205044405987565585670602752";
        make_2p 202 "6427752177035961102167848369364650410088811975131171341205504";
        make_2p 203 "12855504354071922204335696738729300820177623950262342682411008";
        make_2p 204 "25711008708143844408671393477458601640355247900524685364822016";
        make_2p 205 "51422017416287688817342786954917203280710495801049370729644032";
        make_2p 206 "102844034832575377634685573909834406561420991602098741459288064";
        make_2p 207 "205688069665150755269371147819668813122841983204197482918576128";
        make_2p 208 "411376139330301510538742295639337626245683966408394965837152256";
        make_2p 209 "822752278660603021077484591278675252491367932816789931674304512";
        make_2p 210 "1645504557321206042154969182557350504982735865633579863348609024";
        make_2p 211 "3291009114642412084309938365114701009965471731267159726697218048";
        make_2p 212 "6582018229284824168619876730229402019930943462534319453394436096";
        make_2p 213 "13164036458569648337239753460458804039861886925068638906788872192";
        make_2p 214 "26328072917139296674479506920917608079723773850137277813577744384";
        make_2p 215 "52656145834278593348959013841835216159447547700274555627155488768";
        make_2p 216 "105312291668557186697918027683670432318895095400549111254310977536";
        make_2p 217 "210624583337114373395836055367340864637790190801098222508621955072";
        make_2p 218 "421249166674228746791672110734681729275580381602196445017243910144";
        make_2p 219 "842498333348457493583344221469363458551160763204392890034487820288";
        make_2p 220 "1684996666696914987166688442938726917102321526408785780068975640576";
        make_2p 221 "3369993333393829974333376885877453834204643052817571560137951281152";
        make_2p 222 "6739986666787659948666753771754907668409286105635143120275902562304";
        (* http://www.wolframalpha.com/input/?i=2^1023 *)
        make_2p 1023 "89884656743115795386465259539451236680898848947115328636715040578866337902750481566354238661203768010560056939935696678829394884407208311246423715319737062188883946712432742638151109800623047059726541476042502884419075341171231440736956555270413618581675255342293149119973622969239858152417678164812112068608";
      ]
    );
  ]
end
# 225 "General.cppo.ml"
end

module Bool = struct
# 1 "Implementation/Bool.ml"
include Foundations.Bool

module Tests = struct
  open Testing

  module Examples = struct
    let repr = [
      (false, "false");
      (true, "true");
    ]

    let to_string = repr

    let of_string = [
      ("false", false);
      ("true", true);
    ]

    let equal = [
      [true];
      [false];
    ]

    let different = [
      (true, false);
    ]

    let ordered = [
      [false; true];
    ]
  end

  let test = "Bool" >:: [
    (let module T = Concepts.Able.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (let module T = Traits.Displayable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(Foundations.Bool)(Examples) in T.test);
    "not true" >: (lazy (check_false (not true)));
    "not false" >: (lazy (check_true (not false)));

    "and_ true true" >: (lazy (check_true (and_ true true)));
    "and_ false true" >: (lazy (check_false (and_ false true)));
    "and_ true false" >: (lazy (check_false (and_ true false)));
    "and_ false false" >: (lazy (check_false (and_ false false)));
    "true && true" >: (lazy (check_true (true && true)));
    "true && false" >: (lazy (check_false (true && false)));
    "false && whatever" >:(lazy (check_false (false && (Exception.failure "Don't call me")))); (*BISECT-IGNORE*)

    "or_ true true" >: (lazy (check_true (or_ true true)));
    "or_ false true" >: (lazy (check_true (or_ false true)));
    "or_ true false" >: (lazy (check_true (or_ true false)));
    "or_ false false" >: (lazy (check_false (or_ false false)));
    "true || whatever" >:(lazy (check_true (true || (Exception.failure "Don't call me")))); (*BISECT-IGNORE*)
    "false || true" >: (lazy (check_true (false || true)));
    "false || false" >: (lazy (check_false (false || false)));

    "xor true true" >: (lazy (check_false (xor true true)));
    "xor false true" >: (lazy (check_true (xor false true)));
    "xor true false" >: (lazy (check_true (xor true false)));
    "xor false false" >: (lazy (check_false (xor false false)));
  ]
end
# 229 "General.cppo.ml"
end

module Bytes = struct
# 1 "Implementation/Bytes.ml"
module OCSB = OCamlStandard.Bytes

type t = bytes

let of_string = OCSB.of_string
let to_string = OCSB.to_string

let get = OCSB.get
let set = OCSB.set

let size = OCSB.length

let empty = OCSB.empty

let make ~len =
  OCSB.create len
# 233 "General.cppo.ml"
end

module Int = struct
# 1 "Implementation/Int.ml"
module SelfA = struct
  include Foundations.Int

  include Traits.Ringoid.Exponentiate.Make0(struct
    include Foundations.Int

    let exponentiate_negative_exponent ~exponentiate:_ _ n =
      Exception.invalid_argument "Int.exponentiate: Negative exponent: %i" n
  end)
end

module SelfB = struct
  module O = struct
    include SelfA.O

    let ( ** ) = SelfA.exponentiate
  end

  include (SelfA: module type of SelfA[@remove_aliases] with module O := O)
end

include SelfB

module Examples = struct
  let repr = [
    (-3, "-3");
    (-0, "0");
    (0, "0");
    (1, "1");
    (15, "15");
  ]

  let to_string = repr

  let of_string = [
    ("0", 0);
    ("1", 1);
    ("-1", -1);
    ("1_000", 1000);
  ]

  let equal = [
    [0];
    [1];
    [2];
  ]

  let different = [
    (0, 1);
    (1, -1);
  ]

  let ordered = [
    [-10; -5; -1; 0; 1; 2; 5];
  ]

  let add_substract = [
    (4, 3, 7);
    (4, -2, 2);
    (5, -7, -2);
  ]

  let negate = [
    (4, -4);
    (-7, 7);
  ]

  let multiply = [
    (4, 3, 12);
    (4, -3, -12);
    (-4, -3, 12);
  ]

  let divide = [
    (5, 2, 2);
    (4, 2, 2);
    (4, 3, 1);
    (4, 4, 1);
    (4, 5, 0);
  ]

  let exponentiate = [
    (3, 3, 27);
    (2, 7, 128);
  ]

  let succ = [
    (1, 2);
    (42, 43);
    (-121, -120);
  ]
end

module Tests = struct
  open Testing

  let test = "Int" >:: [
    (let module T = Concepts.Integer.Tests.Make0(SelfB)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(SelfB)(Examples) in T.test);
    "exponentiate 2 (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "Int.exponentiate: Negative exponent: -4") (lazy (exponentiate 2 (-4)))));
  ]
end
# 237 "General.cppo.ml"
end

module List = struct
# 1 "Implementation/List.ml"
module Self = struct
  include Traits.Equatable.Different.Make1(Foundations.List)
  include Foundations.List
end

include Self

module Specialize(A: sig type t end) = struct
  type t = A.t list

  include (Self: module type of Self with type 'a t := 'a Self.t)

  module ToList = struct
    let map = map
    let map_acc = map_acc
    let map_i = map_i
    let filter = filter
    let filter_acc = filter_acc
    let filter_i = filter_i
    let filter_map = filter_map
    let filter_map_acc = filter_map_acc
    let filter_map_i = filter_map_i
    let flat_map = flat_map
    let flat_map_acc = flat_map_acc
    let flat_map_i = flat_map_i
    let scan = scan
    let scan_acc = scan_acc
    let scan_i = scan_i
    let scan_short = scan_short
    let scan_short_acc = scan_short_acc
    let scan_short_i = scan_short_i
  end
end

module SpecializeEquatable(A: Traits.Equatable.Basic.S0) = struct
  type t = A.t list

  let contains xs x =
    Self.contains xs x ~equal_a:A.equal
end

module SpecializeRepresentable(A: Traits.Representable.S0) = struct
  type t = A.t list

  let repr xs =
    Self.repr xs ~repr_a:A.repr
end

module Examples = struct
  module A = Foundations.Int

  let repr = [
    ([], "[]");
    ([1], "[1]");
    ([1; 2; 3], "[1; 2; 3]");
  ]

  let equal = [
    [empty; []];
    [[1]];
    [[1; 2; 3]];
  ]

  let different = [
    ([], [1]);
    ([1], [2]);
    ([1; 1; 1], [1; 1; 2]);
    ([1; 1; 1], [1; 1; 1; 1]);
  ]
end

module Tests = struct
  open Testing

  let test = "List" >:: [
    (let module T = Traits.Representable.Tests.Make1(Self)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make1(Self)(Examples) in T.test);
    (let module T = Traits.FilterMapable.Tests.Make1(Self) in T.test);
    "reverse" >: (lazy (check_string_list ~expected:["3"; "2"; "1"] (reverse ["1"; "2"; "3"])));
    "concat" >: (lazy (check_int_list ~expected:[1; 2; 3; 4; 5; 6] (concat [1; 2; 3] [4; 5; 6])));
    "prepend" >: (lazy (check_int_list ~expected:[1; 2; 3] (prepend 1 [2; 3])));
    "try_head" >: (lazy (check_some_int ~expected:1 (try_head [1; 2; 3])));
    "try_head []" >: (lazy (check_none_int (try_head [])));
    "try_tail" >: (lazy (check_some ~repr:(repr ~repr_a:Int.repr) ~equal:(equal ~equal_a:Int.equal) ~expected:[2; 3] (try_tail [1; 2; 3])));
    "try_tail []" >: (lazy (check_none ~repr:(repr ~repr_a:Float.repr) ~equal:(equal ~equal_a:Float.equal) (try_tail [])));
    "head" >: (lazy (check_int ~expected:1 (head [1; 2; 3])));
    "head []" >: (lazy (expect_exception ~expected:(Exception.Failure "List.head") (lazy (head []))));
    "tail" >: (lazy (check_int_list ~expected:[2; 3] (tail [1; 2; 3])));
    "tail []" >: (lazy (expect_exception ~expected:(Exception.Failure "List.tail") (lazy (tail []))));
    "fold []" >: (lazy (check_int ~expected:0 (fold ~init:0 ~f:(fun _ -> Exception.failure "Don't call me") []))); (*BISECT-IGNORE*)
    "fold" >: (lazy (check_string ~expected:"init-3-4" (fold ~init:"init" ~f:(Format.apply "%s-%d") [3; 4])));
    "reduce [0]" >: (lazy (check_int ~expected:0 (reduce ~f:(fun _ -> Exception.failure "Don't call me") [0]))); (*BISECT-IGNORE*)
    "reduce" >: (lazy (check_int ~expected:4096 (reduce ~f:Int.exponentiate [2; 3; 4])));
    "try_reduce" >: (lazy (check_some_int ~expected:4096 (try_reduce ~f:Int.exponentiate [2; 3; 4])));
    "try_reduce []" >: (lazy (check_none_int (try_reduce ~f:Int.exponentiate [])));
    "iter" >: (lazy (check_int ~expected:4096 (let p = ref 2 in iter ~f:(fun n -> p := Int.exponentiate !p n) [3; 4]; !p)));
  ]
end
# 241 "General.cppo.ml"
end

module CallStack = struct
# 1 "Implementation/CallStack.ml"
(* The position of these symbols is tested below. Moving them requires fixing the tests *)
let rec stack = function
  | 0 -> [Some (Foundations.CallStack.current ())]
  | n -> None::(stack (n - 1))

let stack =
  stack 2
  |> List.filter_map ~f:identity
  |> List.head
(* End of symbols to not move *)

include Foundations.CallStack

module Tests = struct
  open Testing

  module Examples = struct
    let to_string = [
      (
        stack,
        if javascript then
          "" (*BISECT-IGNORE*)
        else
          "Raised by primitive operation at file \"Implementation/CallStack.ml\", line 3, characters 15-49\n\
          Called from file \"Implementation/CallStack.ml\", line 4, characters 15-30\n\
          Called from file \"Implementation/CallStack.ml\", line 4, characters 15-30\n\
          Called from file \"Implementation/CallStack.ml\", line 7, characters 2-9\n"
      );
    ]

    let repr = to_string
  end

  module LocationExamples = struct
    let repr = [
      (
        {Location.filename="Implementation/CallStack.ml"; line_number=3; start_char=15; end_char=49},
        "{filename=\"Implementation/CallStack.ml\"; line_number=3; start_char=15; end_char=49}"
      );
    ]
  end

  let test = "CallStack" >:: [
    (let module T = Traits.Displayable.Tests.Make0(Foundations.CallStack)(Examples) in T.test);
    (let module T = Traits.Representable.Tests.Make0(Foundations.CallStack)(Examples) in T.test);
    "frames" >: (lazy (check_int ~expected:(if javascript then 0 else 4) (stack |> frames |> List.size))); (*BISECT-IGNORE*)
    "Location" >:: [
      (* (let module T = Traits.Comparable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
      (* (let module T = Traits.Equatable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test); *)
      (let module T = Traits.Representable.Tests.Make0(Foundations.CallStack.Location)(LocationExamples) in T.test);
    ];
    "Frame" >:: (
      match frames stack with
        | [] -> [] (*BISECT-IGNORE*)
        | frame::_ -> Frame.[
            "format 0" >: (lazy (check_some_string ~expected:"Raised by primitive operation at file \"Implementation/CallStack.ml\", line 3, characters 15-49" (format 0 frame)));
            "format 1" >: (lazy (check_some_string ~expected:"Called from file \"Implementation/CallStack.ml\", line 3, characters 15-49" (format 1 frame)));
            "location" >: (lazy (check_some ~repr:Location.repr ~equal:Location.equal ~expected:{Location.filename="Implementation/CallStack.ml"; line_number=3; start_char=15; end_char=49} (location frame)))
          ]
    );
  ]
end
# 245 "General.cppo.ml"
end

module Char = struct
# 1 "Implementation/Char.ml"
module OCSP = OCamlStandard.Pervasives
module OCSS = OCamlStandard.String

type t = char

let of_int = OCSP.char_of_int
let to_int = OCSP.int_of_char

let repeat c ~len =
  OCSS.make len c

let to_string c =
  OCSS.make 1 c

let repr c =
  to_string c

(* @todo include Equate.Poly *)
let equal = Equate.Poly.equal
include Compare.Poly
# 249 "General.cppo.ml"
end

module Exit = struct
# 1 "Implementation/Exit.ml"
include Foundations.Exit
# 253 "General.cppo.ml"
end

module Functions = struct
# 1 "Implementation/Functions.ml"
include Foundations.Functions

module Tests = struct
  open Testing

  let test = "Functions" >:: [
    "Function1" >:: Function1.[
      "identity 42" >: (lazy (check_42 (identity 42)));
      "apply" >: (lazy (check_42 (apply (( * ) 2) 21)));
      "rev_apply" >: (lazy (check_42 (rev_apply 21 (( * ) 2))));
      "compose" >: (lazy (check_string ~expected:"42" ((compose (Format.apply "%d") (( * ) 2)) 21)));
    ];
    "Function2" >:: Function2.[
      "flip" >: (lazy (check_int ~expected:128 ((flip Int.exponentiate) 7 2)));
      "curry" >: (lazy (check_int ~expected:5 ((curry (fun (x, y) -> x - y)) 7 2)));
      "uncurry" >: (lazy (check_int ~expected:5 ((uncurry (-)) (7, 2))));
    ];
    "Function3" >:: Function3.[
      "flip" >: (lazy (check_string ~expected:"2 7 5" ((flip (Format.apply "%d %d %d")) 5 7 2)));
      "curry" >: (lazy (check_int ~expected:1 ((curry (fun (x, y, z) -> x - y * z)) 7 2 3)));
      "uncurry" >: (lazy (check_string ~expected:"7 2 4" ((uncurry (Format.apply "%d %d %d")) (7, 2, 4))));
    ];
    "Function4" >:: Function4.[
      "flip" >: (lazy (check_string ~expected:"2 7 5 9" ((flip (Format.apply "%d %d %d %d")) 9 5 7 2)));
      "curry" >: (lazy (check_int ~expected:6 ((curry (fun (x, y, z, u) -> x - y * z + u)) 7 2 3 5)));
      "uncurry" >: (lazy (check_string ~expected:"7 2 4 5" ((uncurry (Format.apply "%d %d %d %d")) (7, 2, 4, 5))));
    ];
    "Function5" >:: Function5.[
      "flip" >: (lazy (check_string ~expected:"2 7 5 9 3" ((flip (Format.apply "%d %d %d %d %d")) 3 9 5 7 2)));
      "curry" >: (lazy (check_int ~expected:4 ((curry (fun (x, y, z, u, v) -> x - y * z + u -v)) 7 2 3 5 2)));
      "uncurry" >: (lazy (check_string ~expected:"7 2 4 5 3" ((uncurry (Format.apply "%d %d %d %d %d")) (7, 2, 4, 5, 3))));
    ];
  ]
end
# 257 "General.cppo.ml"
end
module Function1 = Functions.Function1
module Function2 = Functions.Function2
module Function3 = Functions.Function3
module Function4 = Functions.Function4
module Function5 = Functions.Function5

module InChannel = struct
# 1 "Implementation/InChannel.ml"
module OCSP = OCamlStandard.Pervasives

type t = OCSP.in_channel

(* @todo Alias for type P.open_flag *)
# 266 "General.cppo.ml"
end

module InFile = struct
# 1 "Implementation/InFile.ml"
module OCSP = OCamlStandard.Pervasives

type t = OCSP.in_channel

let seek x ~pos =
  OCSP.LargeFile.seek_in x pos

let pos = OCSP.LargeFile.pos_in

let size = OCSP.LargeFile.in_channel_length

let channel = identity

let with_file s ~f =
  let file = OCSP.open_in s in
  try
    let r = f file in
    OCSP.close_in file;
    r
  with
    | ex -> OCSP.close_in file; Exception.raise ex

let with_channel s ~f =
  with_file s ~f:(f % channel)
# 270 "General.cppo.ml"
end

module IntRange = struct
# 1 "Implementation/IntRange.ml"
module Self = Foundations.IntRange

include Self

module Tests = struct
  open Testing

  (* @feature Comparable: compare ranges as equal if to_list produces the same integers in the same order, not if they have the same start, stop and step. Poly.equal wouldn't work. *)

  module Examples = struct
    let repr = [
      (make 0, "[]");
      (make (-5), "[]");
      (make 5, "[0 to 4 step 1]");
      (make ~step:(-3) (-15), "[0 down to -12 step -3]");
      (make ~start:3 ~step:4 25, "[3 to 23 step 4]");
    ]

    let equal = [
      [make 0; make ~step:2 0; make (-4); make 10 ~step:0; make 10 ~step:(-1); make ~start:5 3; empty];
      [make 10; make ~start:0 ~step:1 10];
      [make ~start:5 ~step:3 9; make ~start:5 ~step:3 10; make ~start:5 ~step:3 11]
    ]

    let different = [
      (make 0, make 1);
      (make ~start:5 ~step:3 11, make ~start:5 ~step:3 12);
    ]
  end

  let test = "IntRange" >:: [
    (let module T = Traits.Representable.Tests.Make0(Self)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make0(Self)(Examples) in T.test);
    "to_list" >:: [
      "simplest" >: (lazy (check_int_list ~expected:[0; 1; 2; 3; 4] (to_list (make 5))));
      "with start" >: (lazy (check_int_list ~expected:[2; 3; 4] (to_list (make 5 ~start:2))));
      "with stop < 0" >: (lazy (check_int_list ~expected:[] (to_list (make (-5)))));
      "with stop <= start" >: (lazy (check_int_list ~expected:[] (to_list (make 0))));
      "with stop <= start" >: (lazy (check_int_list ~expected:[] (to_list (make (-5)))));
      "with stop <= start" >: (lazy (check_int_list ~expected:[] (to_list (make 5 ~start:5))));
      "with step" >: (lazy (check_int_list ~expected:[0; 2; 4] (to_list (make 5 ~step:2))));
      "with step" >: (lazy (check_int_list ~expected:[0; 2; 4] (to_list (make 6 ~step:2))));
      "with step = 0" >: (lazy (check_int_list ~expected:[] (to_list (make 6 ~step:0))));
      "with start and step" >: (lazy (check_int_list ~expected:[2; 4; 6] (to_list (make ~start:2 ~step:2 7))));
      "with start and step" >: (lazy (check_int_list ~expected:[2; 4; 6] (to_list (make ~start:2 ~step:2 8))));
      "with start and step" >: (lazy (check_int_list ~expected:[3; 5; 7] (to_list (make ~start:3 ~step:2 8))));
      "with start and step" >: (lazy (check_int_list ~expected:[3; 5; 7] (to_list (make ~start:3 ~step:2 9))));
      "with step < 0" >: (lazy (check_int_list ~expected:[] (to_list (make 6 ~step:(-1)))));
      "with step < 0" >: (lazy (check_int_list ~expected:[0; -1; -2; -3; -4; -5] (to_list (make (-6) ~step:(-1)))));
      "with step < 0" >: (lazy (check_int_list ~expected:[0; -2; -4] (to_list (make (-6) ~step:(-2)))));
      "with step < 0 and start" >: (lazy (check_int_list ~expected:[-3; -5; -7; -9] (to_list (make (-10) ~start:(-3) ~step:(-2)))));
      "with step < 0 and start" >: (lazy (check_int_list ~expected:[-3; -5; -7; -9] (to_list (make (-11) ~start:(-3) ~step:(-2)))));
      (* "fail" >: (lazy (fail "fail")); *)
    ];
  ]
end
# 274 "General.cppo.ml"
end

module Lazy = struct
# 1 "Implementation/Lazy.ml"
include Foundations.Lazy

open Testing

module Tests = struct
  let test = "Lazy" >:: [
    "value" >: (lazy (check_42 (value (lazy 42))));
    "value exc" >: (lazy (expect_exception ~expected:(Exception.Failure "nope") (lazy (value (lazy (Exception.failure "nope"))))));
    "is_value" >: (lazy (
      let x = lazy ((fun () -> 42)()) in
      check_false (is_value x);
      check_42 (value x);
      check_true (is_value x);
    ));
    "map" >: (lazy (check_42 (value (map (lazy 21) ~f:(( * ) 2)))));
    "map is lazy" >: (lazy (
      let x = lazy (Exception.failure "You called me!") in
      let y = map x ~f:(fun _ -> Exception.failure "Don't call me") in
      expect_exception ~expected:(Exception.Failure "You called me!") (lazy (value y))
    ));
  ]
end
# 278 "General.cppo.ml"
end

module NativeInt = struct
# 1 "Implementation/NativeInt.ml"
module OCSI = OCamlStandard.Nativeint

module Self = StandardInt.Make(struct
  include OCSI

  let name = "NativeInt"
  let repr_suffix = "n"

  
# 10 "Implementation/NativeInt.ml"
  let equal = Equate.Poly.equal
# 12 "Implementation/NativeInt.ml"
end)

include Self

module Examples = struct
  let of_string = [
    ("43", 43n);
    ("-12", -12n);
  ]

  let repr = [
    (-3n, "-3n");
    (-0n, "0n");
    (0n, "0n");
    (1n, "1n");
    (15n, "15n");
  ]

  let to_string = [
    (-3n, "-3");
    (-0n, "0");
    (0n, "0");
    (1n, "1");
    (15n, "15");
  ]

  let equal = [
    [0n];
    [1n];
    [2n];
  ]

  let different = [
    (0n, 1n);
    (1n, -1n);
  ]

  let ordered = [
    [-10n; -5n; -1n; 0n; 1n; 2n; 5n];
  ]

  let add_substract = [
    (4n, 3n, 7n);
    (4n, -2n, 2n);
    (5n, -7n, -2n);
  ]

  let negate = [
    (4n, -4n);
    (-7n, 7n);
  ]

  let multiply = [
    (4n, 3n, 12n);
    (4n, -3n, -12n);
    (-4n, -3n, 12n);
  ]

  let divide = [
    (5n, 2n, 2n);
    (4n, 2n, 2n);
    (4n, 3n, 1n);
    (4n, 4n, 1n);
    (4n, 5n, 0n);
  ]

  let exponentiate = [
    (3n, 3, 27n);
    (2n, 7, 128n);
  ]

  let succ = [
    (1n, 2n);
    (42n, 43n);
    (-121n, -120n);
  ]
end

module Tests = struct
  open Testing

  let test = "NativeInt" >:: [
    (let module T = Concepts.Integer.Tests.Make0(Self)(Examples) in T.test);
    (let module T = Traits.Parsable.Tests.Make0(Self)(Examples) in T.test);
    "exponentiate 2n (-4)" >: (lazy (expect_exception ~expected:(Exception.InvalidArgument "NativeInt.exponentiate: Negative exponent: -4") (lazy (exponentiate 2n (-4)))));
  ]
end
# 282 "General.cppo.ml"
end

module Option = struct
# 1 "Implementation/Option.ml"
module SelfA = struct
  include Foundations.Option
  include Traits.Equatable.Different.Make1(Foundations.Option)
  include Traits.Comparable.GreaterLessThan.Make1(Foundations.Option)
  include Traits.Comparable.MinMax.Make1(Foundations.Option)
end

module Self = struct
  include SelfA
  include Traits.Comparable.Between.Make1(SelfA)
end

module Specialize(A: sig type t end) = struct
  type t = A.t option

  include (Self: module type of Self with type 'a t := 'a Self.t)
end

include Self

module Tests = struct
  open Testing

  module Examples = struct
    module A = Int

    let repr = [
      (None, "None");
      (Some 42, "Some 42");
    ]

    let equal = [
      [None];
      [Some 42];
    ]

    let different = [
      (None, Some 42);
      (Some 42, Some 43);
    ]

    let ordered = [
      [None; Some 0; Some 1];
    ]
  end

  let test = "Option" >:: [
    (let module T = Concepts.Able.Tests.Make1(Self)(Examples) in T.test);
    "some_if true" >: (lazy (check_some_42 (some_if true (lazy 42))));
    "some_if false" >: (lazy (check_none_int (some_if false (lazy (Exception.failure "Don't call me"))))); (*BISECT-IGNORE*)
    "some_if' true" >: (lazy (check_some_42 (some_if' true 42)));
    "some_if' false" >: (lazy (check_none_int (some_if' false 42)));
    "is_some None" >: (lazy (check_false (is_some None)));
    "is_some Some" >: (lazy (check_true (is_some (Some 42))));
    "is_none None" >: (lazy (check_true (is_none None)));
    "is_none Some" >: (lazy (check_false (is_none (Some 42))));
    "value_def None" >: (lazy (check_string ~expected:"def" (value_def None ~def:"def")));
    "value_def Some" >: (lazy (check_string ~expected:"val" (value_def (Some "val") ~def:"def")));
    "value Some" >: (lazy (check_string ~expected:"val" (value (Some "val"))));
    "value None" >: (lazy (expect_exception ~expected:(Exception.Failure "Option.value") (lazy (value None))));
    "value ~exc None" >: (lazy (expect_exception ~expected:(Exception.Failure "Nope") (lazy (value ~exc:(Exception.Failure "Nope") None))));
    "repr None" >: (lazy (check_string ~expected:"None" (repr ~repr_a:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*) (*BISECT-IGNORE*)
    "map None" >: (lazy (check_none_int (map ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "map Some" >: (lazy (check_some_42 (map ~f:(( * ) 2) (Some 21))));
    "value_map None" >: (lazy (check_42 (value_map ~def:42 ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "value_map Some" >: (lazy (check_42 (value_map ~def:57 ~f:(( * ) 2) (Some 21))));
    "iter None" >: (lazy (iter ~f:(fun _ -> Exception.failure "Don't call me") None)); (*BISECT-IGNORE*)
    "iter Some" >: (lazy (check_42 (let x = ref 0 in iter ~f:(fun n -> x := n) (Some 42); !x)));
    "filter None" >: (lazy (check_none_int (filter ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "filter Some true" >: (lazy (check_some_42 (filter ~f:(fun _ -> true) (Some 42))));
    "filter Some false" >: (lazy (check_none_int (filter ~f:(fun _ -> false) (Some 42))));
    "filter_map None" >: (lazy (check_none_int (filter_map ~f:(fun _ -> Exception.failure "Don't call me") None))); (*BISECT-IGNORE*)
    "filter_map Some true" >: (lazy (check_some_int ~expected:57 (filter_map ~f:(fun _ -> Some 57) (Some 42))));
    "filter_map Some false" >: (lazy (check_none_int (filter_map ~f:(fun _ -> None) (Some 42))));
  ]
end
# 286 "General.cppo.ml"
end

module OutChannel = struct
# 1 "Implementation/OutChannel.ml"
module OCSP = OCamlStandard.Pervasives
module OCSPr = OCamlStandard.Printf

type t = OCSP.out_channel

let flush = OCSP.flush

let print ?flush:(do_flush=false) channel format =
  OCSPr.kfprintf
    (fun channel -> if do_flush then flush channel)
    channel
    format

let output = OCSP.output_bytes
# 290 "General.cppo.ml"
end

module OutFile = struct
# 1 "Implementation/OutFile.ml"
module OCSP = OCamlStandard.Pervasives

type t = OCSP.out_channel

let seek x ~pos =
  OCSP.LargeFile.seek_out x pos

let pos = OCSP.LargeFile.pos_out

let size = OCSP.LargeFile.out_channel_length

let channel = identity

let with_file s ~f =
  let file = OCSP.open_out s in
  try
    let r = f file in
    OCSP.close_out file;
    r
  with
    | ex -> OCSP.close_out file; Exception.raise ex

let with_channel s ~f =
  with_file s ~f:(f % channel)
# 294 "General.cppo.ml"
end

module Tuples = struct

# 13 "Implementation/Tuples.ml"
 
module  TupleA2  = struct 
  include Foundations.Tuples. Tuple2  
  include Traits.Comparable.GreaterLessThan. Make2 (Foundations.Tuples. Tuple2 ) 
  include Traits.Comparable.MinMax. Make2 (Foundations.Tuples. Tuple2 ) 
  include Traits.Equatable.Different. Make2 (Foundations.Tuples. Tuple2 ) 
end 
module  Tuple2  = struct 
  include  TupleA2  
  include Traits.Comparable.Between. Make2 ( TupleA2 ) 
end 
# 14 "Implementation/Tuples.ml"
 
module  TupleA3  = struct 
  include Foundations.Tuples. Tuple3  
  include Traits.Comparable.GreaterLessThan. Make3 (Foundations.Tuples. Tuple3 ) 
  include Traits.Comparable.MinMax. Make3 (Foundations.Tuples. Tuple3 ) 
  include Traits.Equatable.Different. Make3 (Foundations.Tuples. Tuple3 ) 
end 
module  Tuple3  = struct 
  include  TupleA3  
  include Traits.Comparable.Between. Make3 ( TupleA3 ) 
end 
# 15 "Implementation/Tuples.ml"
 
module  TupleA4  = struct 
  include Foundations.Tuples. Tuple4  
  include Traits.Comparable.GreaterLessThan. Make4 (Foundations.Tuples. Tuple4 ) 
  include Traits.Comparable.MinMax. Make4 (Foundations.Tuples. Tuple4 ) 
  include Traits.Equatable.Different. Make4 (Foundations.Tuples. Tuple4 ) 
end 
module  Tuple4  = struct 
  include  TupleA4  
  include Traits.Comparable.Between. Make4 ( TupleA4 ) 
end 
# 16 "Implementation/Tuples.ml"
 
module  TupleA5  = struct 
  include Foundations.Tuples. Tuple5  
  include Traits.Comparable.GreaterLessThan. Make5 (Foundations.Tuples. Tuple5 ) 
  include Traits.Comparable.MinMax. Make5 (Foundations.Tuples. Tuple5 ) 
  include Traits.Equatable.Different. Make5 (Foundations.Tuples. Tuple5 ) 
end 
module  Tuple5  = struct 
  include  TupleA5  
  include Traits.Comparable.Between. Make5 ( TupleA5 ) 
end 

# 18 "Implementation/Tuples.ml"
module Tests = struct
  open Testing

  module Examples2 = struct
    module A = Foundations.Int
    module B = Foundations.String

    let repr = [
      ((1, "a"), "(1, \"a\")");
    ]

    let equal = [
      [(1, "a")];
    ]

    let different = [
      ((1, "a"), (1, "b"));
      ((1, "a"), (2, "a"));
    ]

    let ordered = [
      [(0, "a"); (0, "b"); (1, "a")]
    ]
  end

  module Examples3 = struct
    module A = Foundations.Int
    module B = Foundations.String
    module C = Foundations.Float

    let repr = [
      ((1, "a", 2.), "(1, \"a\", 2.)");
    ]

    let equal = [
      [(1, "a", 2.)];
    ]

    let different = [
      ((1, "a", 2.), (1, "a", 3.));
      ((1, "a", 2.), (1, "b", 2.));
      ((1, "a", 2.), (2, "a", 2.));
    ]

    let ordered = [
      [(0, "a", 0.); (0, "a", 1.); (0, "b", 0.); (1, "a", 0.)]
    ]
  end

  module Examples4 = struct
    module A = Foundations.Int
    module B = Foundations.String
    module C = Foundations.Float
    module D = Foundations.Int

    let repr = [
      ((1, "a", 2., 3), "(1, \"a\", 2., 3)");
    ]

    let equal = [
      [(1, "a", 2., 3)];
    ]

    let different = [
      ((1, "a", 2., 3), (1, "a", 2., 4));
      ((1, "a", 2., 3), (1, "a", 3., 3));
      ((1, "a", 2., 3), (1, "b", 2., 3));
      ((1, "a", 2., 3), (0, "a", 2., 3));
    ]

    let ordered = [
      [(1, "a", 2., 3); (1, "a", 2., 4); (1, "a", 3., 3); (1, "b", 2., 3); (2, "a", 2., 3)]
    ]
  end

  module Examples5 = struct
    module A = Foundations.Int
    module B = Foundations.String
    module C = Foundations.Float
    module D = Foundations.Int
    module E = Foundations.Int

    let repr = [
      ((1, "a", 2., 3, 4), "(1, \"a\", 2., 3, 4)");
    ]

    let equal = [
      [(1, "a", 2., 3, 4)];
    ]

    let different = [
      ((1, "a", 2., 3, 4), (1, "a", 2., 3, 5));
      ((1, "a", 2., 3, 4), (1, "a", 2., 4, 4));
      ((1, "a", 2., 3, 4), (1, "a", 3., 3, 4));
      ((1, "a", 2., 3, 4), (1, "b", 2., 3, 4));
      ((1, "a", 2., 3, 4), (0, "a", 2., 3, 4));
    ]

    let ordered = [
      [(1, "a", 2., 3, 4); (1, "a", 2., 3, 5); (1, "a", 2., 4, 4); (1, "a", 3., 3, 4); (1, "b", 2., 3, 4); (2, "a", 2., 3, 4)]
    ]
  end


  
# 124 "Implementation/Tuples.ml"
  let test = "Tuples" >:: [
    "Tuple2" >:: Tuple2.[
      
# 126 "Implementation/Tuples.ml"
       
    (let module T = Concepts.Able.Tests. Make2 ( Tuple2 )( Examples2 ) in T.test) 
# 126 "Implementation/Tuples.ml"
                    ;
      "make" >: (lazy (check_int_tuple2 ~expected:(1, 2) (make 1 2)));
      "flip" >: (lazy (check_int_tuple2 ~expected:(1, 2) (flip (2, 1))));
      "get_0" >: (lazy (check_42 (get_0 (42, 0))));
      "get_1" >: (lazy (check_42 (get_1 (0, 42))));
    ];
    "Tuple3" >:: Tuple3.[
      
# 133 "Implementation/Tuples.ml"
       
    (let module T = Concepts.Able.Tests. Make3 ( Tuple3 )( Examples3 ) in T.test) 
# 133 "Implementation/Tuples.ml"
                    ;
      "make" >: (lazy (check_int_tuple3 ~expected:(1, 2, 3) (make 1 2 3)));
      "flip" >: (lazy (check_int_tuple3 ~expected:(1, 2, 3) (flip (3, 2, 1))));
      "get_0" >: (lazy (check_42 (get_0 (42, 0, 0))));
      "get_1" >: (lazy (check_42 (get_1 (0, 42, 0))));
      "get_2" >: (lazy (check_42 (get_2 (0, 0, 42))));
    ];
    "Tuple4" >:: Tuple4.[
      
# 141 "Implementation/Tuples.ml"
       
    (let module T = Concepts.Able.Tests. Make4 ( Tuple4 )( Examples4 ) in T.test) 
# 141 "Implementation/Tuples.ml"
                    ;
      "make" >: (lazy (check_int_tuple4 ~expected:(1, 2, 3, 4) (make 1 2 3 4)));
      "flip" >: (lazy (check_int_tuple4 ~expected:(1, 2, 3, 4) (flip (4, 3, 2, 1))));
      "get_0" >: (lazy (check_42 (get_0 (42, 0, 0, 0))));
      "get_1" >: (lazy (check_42 (get_1 (0, 42, 0, 0))));
      "get_2" >: (lazy (check_42 (get_2 (0, 0, 42, 0))));
      "get_3" >: (lazy (check_42 (get_3 (0, 0, 0, 42))));
    ];
    "Tuple5" >:: Tuple5.[
      
# 150 "Implementation/Tuples.ml"
       
    (let module T = Concepts.Able.Tests. Make5 ( Tuple5 )( Examples5 ) in T.test) 
# 150 "Implementation/Tuples.ml"
                    ;
      "make" >: (lazy (check_int_tuple5 ~expected:(1, 2, 3, 4, 5) (make 1 2 3 4 5)));
      "flip" >: (lazy (check_int_tuple5 ~expected:(1, 2, 3, 4, 5) (flip (5, 4, 3, 2, 1))));
      "get_0" >: (lazy (check_42 (get_0 (42, 0, 0, 0, 0))));
      "get_1" >: (lazy (check_42 (get_1 (0, 42, 0, 0, 0))));
      "get_2" >: (lazy (check_42 (get_2 (0, 0, 42, 0, 0))));
      "get_3" >: (lazy (check_42 (get_3 (0, 0, 0, 42, 0))));
      "get_4" >: (lazy (check_42 (get_4 (0, 0, 0, 0, 42))));
    ];
  ]
end
# 298 "General.cppo.ml"
end
module Tuple2 = Tuples.Tuple2
module Tuple3 = Tuples.Tuple3
module Tuple4 = Tuples.Tuple4
module Tuple5 = Tuples.Tuple5

module RedBlackTree = struct
# 1 "Implementation/RedBlackTree.ml"
type 'a node = {
  l: 'a t;
  v: 'a;
  r: 'a t
}
and 'a t =
  | Empty
  | EmptyPlus (* Temporary marker for Empty nodes that carry an extra unit of black-height during node removal. *)
  | Black of 'a node
  | BlackPlus of 'a node (* Same kind of temporary marker for black nodes. *)
  | Red of 'a node
  (* Red nodes don't need such marker because if the extra black-height reaches them, they just absorb it by turning black. *)

let repr ~repr_a =
  let rec aux = function
    | Empty -> "Empty"
    | EmptyPlus -> "EmptyPlus"
    | Black {l; v; r} -> Format.apply "Black {l=%s; v=%s; r=%s}" (aux l) (repr_a v) (aux r)
    | BlackPlus {l; v; r} -> Format.apply "BlackPlus {l=%s; v=%s; r=%s}" (aux l) (repr_a v) (aux r)
    | Red {l; v; r} -> Format.apply "Red {l=%s; v=%s; r=%s}" (aux l) (repr_a v) (aux r)
  in
  aux

module Invariants = struct
  type t =
    | HasBlackRoot
    | IsRedBlack
    | IsBlackBalanced
    | IsBinarySearchTree

  exception BrokenInvariants of t list

  (*BISECT-IGNORE-BEGIN*)
  let repr = function
    | HasBlackRoot -> "HasBlackRoot"
    | IsRedBlack -> "IsRedBlack"
    | IsBlackBalanced -> "IsBlackBalanced"
    | IsBinarySearchTree -> "IsBinarySearchTree"

  let _ = Exception.register_printer (function
    | BrokenInvariants broken_invariants ->
      Some (Format.apply "Broken red-black tree invariants: %s" (broken_invariants |> List.map ~f:repr |> List.join_string_list ~sep:", "))
    | _ ->
      None
  )
  (*BISECT-IGNORE-END*)

  let has_black_root = function
    | Empty
    | Black _ ->
      true
    | EmptyPlus
    | BlackPlus _
    | Red _ ->
      false

  let is_red_black t =
    let rec aux = function
      | Empty ->
        true
      | Red {l=Red _; _}
      | Red {r=Red _; _}
      | EmptyPlus
      | BlackPlus _ ->
        false
      | Red {l; r; _}
      | Black {l; r; _} ->
        (aux l) && (aux r)
    in
    aux t

  let is_binary_search_tree t ~cmp =
    let check_min ~min ~v =
      min |> Option.value_map ~def:true ~f:(fun min ->
        match cmp v min with
          | Compare.GT -> true
          | _ -> false
      )
    and check_max ~max ~v =
      max |> Option.value_map ~def:true ~f:(fun max ->
        match cmp v max with
          | Compare.LT -> true
          | _ -> false
        )
    in
    let check_value ~min ~max ~v =
      (check_min ~min ~v) && (check_max ~max ~v)
    in
    let rec aux ~min ~max = function
      | Empty
      | EmptyPlus ->
        true
      | Red {l; v; r}
      | Black {l; v; r}
      | BlackPlus {l; v; r} ->
        (aux ~min ~max:(Some v) l) && (check_value ~min ~max ~v) && (aux ~min:(Some v) ~max r)
    in
    aux ~min:None ~max:None t

  let rec black_height =
    let common_height l r =
      match (black_height l, black_height r) with
        | (Some hl, Some hr) when hl = hr ->
          Some hl
        | _ ->
          None
    in
    function
      | Empty ->
        Some 0
      | EmptyPlus ->
        Some 1
      | Red {l; r; _} ->
        common_height l r
      | Black {l; r; _} ->
        common_height l r |> Option.map ~f:((+) 1)
      | BlackPlus {l; r; _} ->
        common_height l r |> Option.map ~f:((+) 2)

  let is_black_balanced t =
    t
    |> black_height
    |> Option.is_some

  let validate t ~cmp =
    match
      [
        (has_black_root, HasBlackRoot);
        (is_red_black, IsRedBlack);
        (is_black_balanced, IsBlackBalanced);
        (is_binary_search_tree ~cmp, IsBinarySearchTree);
      ]
      |> List.filter_map ~f:(fun (predicate, invariant) ->
        Option.some_if' (not (predicate t)) invariant
      )
    with
      | [] -> t
      | broken_invariants -> Exception.raise (BrokenInvariants broken_invariants)
end

module Restore = struct
  let fix_root_color = function
    | Empty
    | EmptyPlus ->
      Empty
    | Red node
    | BlackPlus node ->
      Black node
    | Black _ as t ->
      t

  let balance_reds_left = function
    | Black {l=Red {l=Red {l=a; v=x; r=b}; v=y; r=c}; v=z; r=d} ->
      Red {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | Black {l=Red {l=a; v=x; r=Red {l=b; v=y; r=c}}; v=z; r=d} ->
      Red {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | Black _ as t -> t
    | BlackPlus {l=Red {l=Red {l=a; v=x; r=b}; v=y; r=c}; v=z; r=d} ->
      Black {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | BlackPlus {l=Red {l=a; v=x; r=Red {l=b; v=y; r=c}}; v=z; r=d} ->
      Black {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | BlackPlus _ as t -> t
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)

  let balance_reds_right = function
    | Black {l=a; v=x; r=Red {l=Red {l=b; v=y; r=c}; v=z; r=d}} ->
      Red {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | Black {l=a; v=x; r=Red {l=b; v=y; r=Red {l=c; v=z; r=d}}} ->
      Red {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | Black _ as t -> t
    | BlackPlus {l=a; v=x; r=Red {l=Red {l=b; v=y; r=c}; v=z; r=d}} ->
      Black {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | BlackPlus {l=a; v=x; r=Red {l=b; v=y; r=Red {l=c; v=z; r=d}}} ->
      Black {l=Black {l=a; v=x; r=b}; v=y; r=Black {l=c; v=z; r=d}}
    | BlackPlus _ as t -> t
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)

  let balance_blacks_left = function
    | Red {l=Black {l=a; v=x; r=b}; v=y; r=EmptyPlus} ->
      balance_reds_left (Black {l=Red {l=a; v=x; r=b}; v=y; r=Empty})
    | Black {l=Black {l=a; v=x; r=b}; v=y; r=EmptyPlus} ->
      balance_reds_left (BlackPlus {l=Red {l=a; v=x; r=b}; v=y; r=Empty})
    | Black {l=Red {l=a; v=x; r=Black {l=b; v=y; r=c}}; v=z; r=EmptyPlus} ->
      Black {l=a; v=x; r=balance_reds_left (Black {l=Red {l=b; v=y; r=c}; v=z; r=Empty})}
    | t ->
      t

  let balance_blacks_right = function
    | Red {l=EmptyPlus; v=x; r=Black {l=b; v=y; r=c}} ->
      balance_reds_right (Black {l=Empty; v=x; r=Red {l=b; v=y; r=c}})
    | Black {l=EmptyPlus; v=x; r=Black {l=b; v=y; r=c}} ->
      balance_reds_right (BlackPlus {l=Empty; v=x; r=Red {l=b; v=y; r=c}})
    | Black {l=EmptyPlus; v=x; r=Red {l=Black {l=b; v=y; r=c}; v=z; r=d}} ->
      Black {l=balance_reds_right (Black {l=Empty; v=x; r=Red {l=b; v=y; r=c}}); v=z; r=d}
    | t ->
      t
end

let empty = Empty

let add xs ~cmp x =
  let rec aux = function
    | Empty ->
      (true, Red {l=Empty; v=x; r=Empty})
    | Red {l; v; r} as t -> (
      match cmp x v with
        | Compare.LT ->
          let (modified, l') = aux l in
          if modified then
            (true, Red {l=l'; v; r})
          else
            (false, t)
        | Compare.EQ ->
          (false, t)
        | Compare.GT ->
          let (modified, r') = aux r in
          if modified then
            (true, Red {l; v; r=r'})
          else
            (false, t)
    )
    | Black {l; v; r} as t -> (
      match cmp x v with
        | Compare.LT ->
          let (modified, l') = aux l in
          if modified then
            (true, Restore.balance_reds_left (Black {l=l'; v; r}))
          else
            (false, t)
        | Compare.EQ ->
          (false, t)
        | Compare.GT ->
          let (modified, r') = aux r in
          if modified then
            (true, Restore.balance_reds_right (Black {l; v; r=r'}))
          else
            (false, t)
    )
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
  in
  let (modified, t) =
    xs
    (* @todo Define DEBUG when compiling with jbuilder --dev *)
    
# 247 "Implementation/RedBlackTree.ml"
    |> aux
  in
  let t =
    t
    |> Restore.fix_root_color
  
# 255 "Implementation/RedBlackTree.ml"
  in
  (modified, t)

let replace xs ~cmp x =
  let rec aux = function
    | Empty ->
      Red {l=Empty; v=x; r=Empty}
    | Red {l; v; r} -> (
      match cmp x v with
        | Compare.LT ->
          Red {l=aux l; v; r}
        | Compare.EQ ->
          Red {l; v=x; r}
        | Compare.GT ->
          Red {l; v; r=aux r}
    )
    | Black {l; v; r} -> (
      match cmp x v with
        | Compare.LT ->
          Restore.balance_reds_left (Black {l=aux l; v; r})
        | Compare.EQ ->
          Black {l; v=x; r}
        | Compare.GT ->
          Restore.balance_reds_right (Black {l; v; r=aux r})
    )
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
  in
  xs
  
# 286 "Implementation/RedBlackTree.ml"
  |> aux
  |> Restore.fix_root_color

# 292 "Implementation/RedBlackTree.ml"
let remove xs ~cmp ~cmp_k x =
  
# 294 "Implementation/RedBlackTree.ml"
  ignore cmp;
  
# 296 "Implementation/RedBlackTree.ml"
  let rec remove_min = function
    | Black {l=Empty; v; r=Empty} ->
      (EmptyPlus, v)
    | Black {l=Empty; v=x; r=Red {l; v=y; r}} ->
      (Black {l; v=y; r}, x)
    | Red {l=Empty; v; r} ->
      (r, v)
    | Black {l; v; r} ->
        let (l', min) = remove_min l in
        let t = Black {l=l'; v; r} in
        (Restore.balance_blacks_right t, min)
    | Red {l; v; r} ->
        let (l', min) = remove_min l in
        let t = Red {l=l'; v; r} in
        (Restore.balance_blacks_right t, min)
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
  in
  let rec aux = function
    | Empty ->
      (false, Empty)
    | Black {l; v; r} as t -> (
      match cmp_k x v with
        | Compare.LT ->
          let (modified, l') = aux l in
          if modified then
            (true, Restore.balance_blacks_right (Black {l=l'; v; r}))
          else
            (false, t)
        | Compare.GT ->
          let (modified, r') = aux r in
          if modified then
            (true, Restore.balance_blacks_left (Black {l; v; r=r'}))
          else
            (false, t)
        | Compare.EQ -> (
          match r with
            | Empty -> (
              match l with
                | Red node ->
                  (true, Black node)
                | Empty ->
                  (true, EmptyPlus)
                | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
            )
            | Red _
            | Black _ ->
              let (r', min) = remove_min r in
              (true, Restore.balance_blacks_left (Black {l; v=min; r=r'}))
            | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
        )
    )
    | Red {l; v; r} as t -> (
      match cmp_k x v with
        | Compare.LT ->
          let (modified, l') = aux l in
          if modified then
            (true, Restore.balance_blacks_right (Red {l=l'; v; r}))
          else
            (false, t)
        | Compare.GT ->
          let (modified, r') = aux r in
          if modified then
            (true, Restore.balance_blacks_left (Red {l; v; r=r'}))
          else
            (false, t)
        | Compare.EQ -> (
          match r with
            | Empty ->
              (true, l)
            | Black _ ->
              let (r', min) = remove_min r in
              (true, Restore.balance_blacks_left (Red {l; v=min; r=r'}))
            | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
        )
    )
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
  in
  let (modified, t) =
    xs
    
# 378 "Implementation/RedBlackTree.ml"
    |> aux
  in
  let t =
    t
    |> Restore.fix_root_color
  
# 386 "Implementation/RedBlackTree.ml"
  in
  (modified, t)

let is_empty = function
  | Empty -> true
  | _ -> false

let try_get xs ~cmp ~cmp_k x =
  
# 395 "Implementation/RedBlackTree.ml"
  ignore cmp;
  
# 397 "Implementation/RedBlackTree.ml"
  let rec aux = function
    | Empty ->
      None
    | Black {l; v; r}
    | Red {l; v; r} -> (
      match cmp_k x v with
        | Compare.LT ->
          aux l
        | Compare.EQ ->
          Some v
        | Compare.GT ->
          aux r
    )
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
  in
  xs
  
# 416 "Implementation/RedBlackTree.ml"
  |> aux

let fold xs ~cmp ~init ~f =
  
# 420 "Implementation/RedBlackTree.ml"
  ignore cmp;
  
# 422 "Implementation/RedBlackTree.ml"
  let rec aux acc = function
    | Empty ->
      acc
    | Red {l; v; r}
    | Black {l; v; r} ->
      aux (f (aux acc l) v) r
    | _ -> Exception.failure "broken invariants" (*BISECT-IGNORE*) (* Unreachable *)
  in
  xs
  
# 434 "Implementation/RedBlackTree.ml"
  |> aux init

let to_list xs ~cmp =
  fold xs ~cmp ~init:[] ~f:(Functions.Function2.flip List.prepend)
  |> List.reverse

let size xs ~cmp =
  fold xs ~cmp ~init:0 ~f:(fun n _ -> Int.succ n)

module Tests = struct
  open Testing

  let repr = repr ~repr_a:Int.repr
  let cmp a b =
    Int.(compare (abs a) (abs b))

  let b1 = Black {l=Empty; v=1; r=Empty}

  let b1r3 = Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}
  let br13 = Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}

  let bb13b5 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}
  let br13r5 = Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}

  let bb13b5r7 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Red {l=Empty; v=7; r=Empty}}}
  let bb13br57 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}}
  let bb1r35b7 = Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}}
  let bbr135b7 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}

  let bb13br57r9 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Red {l=Empty; v=9; r=Empty}}}
  let bb13rb57b9 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}}
  let bb1r35b7r9 = Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}}
  let bb1r35br79 = Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}}
  let bbr135b7r9 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}}
  let bbr135br79 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}}
  let bbr13r57b9 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}}
  let brb13b57b9 = Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}}

  let bb13rb57b9r11 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}}}
  let bb13rb57br911 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}}}
  let bb13rb5r79b11 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Red {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}}}
  let bb13rbr579b11 = Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}}
  let bb1r35br79r11 = Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=11; r=Empty}}}
  let bb1r35rb79b11 = Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}}
  let bbr135br79r11 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=11; r=Empty}}}
  let bbr135rb79b11 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}}
  let bbr13r57b9r11 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}}
  let bbr13r57br911 = Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}}
  let brb13b57b9r11 = Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}}
  let brb13b57br911 = Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}}
  let brb13b5r79b11 = Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Red {l=Empty; v=7; r=Empty}}}; v=9; r=Black {l=Empty; v=11; r=Empty}}
  let brb13br579b11 = Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}}
  let brb1r35b79b11 = Black {l=Red {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}}
  let brbr135b79b11 = Black {l=Red {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}}

  let test = "RedBlackTree" >:: [
    "Invariants" >:: [
      "validate" >:: (
        let make t expected =
          (repr t) >: (
            match expected with
              | [] ->
                lazy (Invariants.validate t ~cmp |> ignore)
              | _ ->
                lazy (expect_exception ~expected:(Invariants.BrokenInvariants expected) (lazy (Invariants.validate t ~cmp)))
          )
        in Invariants.[
          make Empty [];
          make EmptyPlus [HasBlackRoot; IsRedBlack];
          make (Black     {l=Empty; v=0; r=Empty}) [];
          make (BlackPlus {l=Empty; v=0; r=Empty}) [HasBlackRoot; IsRedBlack];
          make (Red       {l=Empty; v=0; r=Empty}) [HasBlackRoot];
          make (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}) [];
          make (Red   {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}) [HasBlackRoot; IsRedBlack];
          make (Red   {l=Empty; v=0; r=Red {l=Empty; v=1; r=Empty}}) [HasBlackRoot; IsRedBlack];
          make (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=2; r=Empty}}) [];
          make (Black {l=Red {l=Empty; v=1; r=Empty}; v=1; r=Red {l=Empty; v=2; r=Empty}}) [IsBinarySearchTree];
          make (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=1; r=Empty}}) [IsBinarySearchTree];
          make (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=2; r=Empty}}) [IsBlackBalanced];
          make (Black {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=2; r=Empty}}) [IsBlackBalanced];
        ]
      )
    ];
    "add" >:: (
      let make t x expected =
        ~: "add %s %i" (repr t) x (lazy (
          check_poly ~repr:(Tuples.Tuple2.repr ~repr_a:Bool.repr ~repr_b:repr) ~expected (add t ~cmp x)
        ))
      in 
      let make_t t x expected =
        make t x (true, expected)
      and make_f t x =
        make t x (false, t)
      in
      [
        make_t Empty 0 (Black {l=Empty; v=0; r=Empty});

        make_t b1 0 (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty});
        make_f b1 1;
        make_t b1 2 (Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}});

        make_t b1r3 0 (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=3; r=Empty}});
        make_f b1r3 1;
        make_t b1r3 2 (Black {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}});
        make_f b1r3 3;
        make_t b1r3 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=4; r=Empty}});

        make_t br13 0 (Black {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=3; r=Empty}});
        make_f br13 1;
        make_t br13 2 (Black {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}});
        make_f br13 3;
        make_t br13 4 (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=4; r=Empty}});

        make_t bb13b5 0 (Black {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}});
        make_f bb13b5 1;
        make_t bb13b5 2 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}}; v=3; r=Black {l=Empty; v=5; r=Empty}});
        make_f bb13b5 3;
        make_t bb13b5 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=4; r=Empty}; v=5; r=Empty}});
        make_f bb13b5 5;
        make_t bb13b5 6 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Red {l=Empty; v=6; r=Empty}}});

        make_t br13r5 0 (Black {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}});
        make_f br13r5 1;
        make_t br13r5 2 (Black {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}});
        make_f br13r5 3;
        make_t br13r5 4 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=4; r=Black {l=Empty; v=5; r=Empty}});
        make_f br13r5 5;
        make_t br13r5 6 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=6; r=Empty}});

        make_t bb13b5r7 0 (Black {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Red {l=Empty; v=7; r=Empty}}});
        make_f bb13b5r7 1;
        make_t bb13b5r7 2 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}}; v=3; r=Black {l=Empty; v=5; r=Red {l=Empty; v=7; r=Empty}}});
        make_f bb13b5r7 3;
        make_t bb13b5r7 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=4; r=Empty}; v=5; r=Red {l=Empty; v=7; r=Empty}}});
        make_f bb13b5r7 5;
        make_t bb13b5r7 6 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=6; r=Black {l=Empty; v=7; r=Empty}}});
        make_f bb13b5r7 7;
        make_t bb13b5r7 8 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=8; r=Empty}}});

        make_f bb13br57 1;
        make_t bb13br57 2 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}});
        make_f bb13br57 3;
        make_t bb13br57 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=4; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}});
        make_f bb13br57 5;
        make_t bb13br57 6 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=6; r=Black {l=Empty; v=7; r=Empty}}});
        make_f bb13br57 7;
        make_t bb13br57 8 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Red {l=Empty; v=8; r=Empty}}});

        make_f bb1r35b7 1;
        make_t bb1r35b7 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35b7 3;
        make_t bb1r35b7 4 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=4; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35b7 5;
        make_t bb1r35b7 6 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=6; r=Empty}; v=7; r=Empty}});
        make_f bb1r35b7 7;
        make_t bb1r35b7 8 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=8; r=Empty}}});

        make_f bbr135b7 1;
        make_t bbr135b7 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135b7 3;
        make_t bbr135b7 4 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=4; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135b7 5;
        make_t bbr135b7 6 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=6; r=Empty}; v=7; r=Empty}});
        make_f bbr135b7 7;
        make_t bbr135b7 8 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=8; r=Empty}}});

        make_t bb13br57r9 0 (Black {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13br57r9 1;
        make_t bb13br57r9 2 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13br57r9 3;
        make_t bb13br57r9 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=4; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}}});
        make_f bb13br57r9 5;
        make_t bb13br57r9 6 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=6; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}}});
        make_f bb13br57r9 7;
        make_t bb13br57r9 8 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}; v=8; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13br57r9 9;
        make_t bb13br57r9 10 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}; v=9; r=Black {l=Empty; v=10; r=Empty}}});

        make_t bb13rb57b9 0 (Black {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9 1;
        make_t bb13rb57b9 2 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9 3;
        make_t bb13rb57b9 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Red {l=Empty; v=4; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9 5;
        make_t bb13rb57b9 6 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Red {l=Empty; v=6; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9 7;
        make_t bb13rb57b9 8 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Red {l=Empty; v=8; r=Empty}; v=9; r=Empty}}});
        make_f bb13rb57b9 9;
        make_t bb13rb57b9 10 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=10; r=Empty}}}});

        make_t bb1r35b7r9 0 (Black {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 1;
        make_t bb1r35b7r9 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 3;
        make_t bb1r35b7r9 4 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=4; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 5;
        make_t bb1r35b7r9 6 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=6; r=Empty}; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 7;
        make_t bb1r35b7r9 8 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=8; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 9;
        make_t bb1r35b7r9 10 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=10; r=Empty}}});

        make_t bb1r35br79 0 (Black {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35br79 1;
        make_t bb1r35br79 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35br79 3;
        make_t bb1r35br79 4 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=4; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35br79 5;
        make_t bb1r35br79 6 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Red {l=Black {l=Empty; v=6; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb1r35br79 7;
        make_t bb1r35br79 8 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=8; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb1r35br79 9;
        make_t bb1r35br79 10 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=10; r=Empty}}});

        make_t bbr135b7r9 0 (Black {l=Red {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 1;
        make_t bbr135b7r9 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 3;
        make_t bbr135b7r9 4 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=4; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 5;
        make_t bbr135b7r9 6 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=6; r=Empty}; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 7;
        make_t bbr135b7r9 8 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=8; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 9;
        make_t bbr135b7r9 10 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=10; r=Empty}}});

        make_t bbr135br79 0 (Black {l=Red {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135br79 1;
        make_t bbr135br79 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135br79 3;
        make_t bbr135br79 4 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=4; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135br79 5;
        make_t bbr135br79 6 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=6; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bbr135br79 7;
        make_t bbr135br79 8 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=8; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bbr135br79 9;
        make_t bbr135br79 10 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=10; r=Empty}}});

        make_t bbr13r57b9 0 (Black {l=Red {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 1;
        make_t bbr13r57b9 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 3;
        make_t bbr13r57b9 4 (Black {l=Red {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=4; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 5;
        make_t bbr13r57b9 6 (Black {l=Red {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=6; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 7;
        make_t bbr13r57b9 8 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=8; r=Empty}; v=9; r=Empty}});
        make_f bbr13r57b9 9;
        make_t bbr13r57b9 10 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=10; r=Empty}}});

        make_t brb13b57b9 0 (Black {l=Red {l=Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 1;
        make_t brb13b57b9 2 (Black {l=Red {l=Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 3;
        make_t brb13b57b9 4 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=4; r=Empty}; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 5;
        make_t brb13b57b9 6 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Red {l=Empty; v=6; r=Empty}}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 7;
        make_t brb13b57b9 8 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=8; r=Empty}; v=9; r=Empty}});
        make_f brb13b57b9 9;
        make_t brb13b57b9 10 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=10; r=Empty}}});
      ]
    );
    "replace" >:: (
      let make t x expected =
        ~: "replace %s %i" (repr t) x (lazy (
          check_poly ~repr ~expected (replace t ~cmp x)
        ))
      in
      [
        make Empty 0 (Black {l=Empty; v=0; r=Empty});

        make b1 (-2) (Black {l=Empty; v=1; r=Red {l=Empty; v=(-2); r=Empty}});
        make b1 (-1) (Black {l=Empty; v=(-1); r=Empty});
        make b1 0 (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Empty});
        make b1 1 (Black {l=Empty; v=1; r=Empty});
        make b1 2 (Black {l=Empty; v=1; r=Red {l=Empty; v=2; r=Empty}});

        make b1r3 (-4) (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=(-4); r=Empty}});
        make b1r3 (-3) (Black {l=Empty; v=1; r=Red {l=Empty; v=(-3); r=Empty}});
        make b1r3 (-2) (Black {l=Black {l=Empty; v=1; r=Empty}; v=(-2); r=Black {l=Empty; v=3; r=Empty}});
        make b1r3 (-1) (Black {l=Empty; v=(-1); r=Red {l=Empty; v=3; r=Empty}});
        make b1r3 0 (Black {l=Red {l=Empty; v=0; r=Empty}; v=1; r=Red {l=Empty; v=3; r=Empty}});
        make b1r3 1 (Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}});
        make b1r3 2 (Black {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}});
        make b1r3 3 (Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}});
        make b1r3 4 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=4; r=Empty}});

        make br13 (-4) (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=(-4); r=Empty}});
        make br13 (-3) (Black {l=Red {l=Empty; v=1; r=Empty}; v=(-3); r=Empty});
        make br13 (-2) (Black {l=Black {l=Empty; v=1; r=Empty}; v=(-2); r=Black {l=Empty; v=3; r=Empty}});
        make br13 (-1) (Black {l=Red {l=Empty; v=(-1); r=Empty}; v=3; r=Empty});
        make br13 0 (Black {l=Black {l=Empty; v=0; r=Empty}; v=1; r=Black {l=Empty; v=3; r=Empty}});
        make br13 1 (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty});
        make br13 2 (Black {l=Black {l=Empty; v=1; r=Empty}; v=2; r=Black {l=Empty; v=3; r=Empty}});
        make br13 3 (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty});
        make br13 4 (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=4; r=Empty}});
      ]
    );
    "try_get" >:: (
      let make t x expected =
        ~: "try_get %s %i" (repr t) x (lazy (
          check_int_option ~expected (try_get t ~cmp ~cmp_k:cmp x)
        ))
      in
      let make_t t x =
        make t x (Some (Int.abs x))
      and make_f t x =
        make t x None
      in
      [
        make_f br13r5 (-6);
        make_t br13r5 (-5);
        make_f br13r5 (-4);
        make_t br13r5 (-3);
        make_f br13r5 (-2);
        make_t br13r5 (-1);
        make_f br13r5 0;
        make_t br13r5 1;
        make_f br13r5 2;
        make_t br13r5 3;
        make_f br13r5 4;
        make_t br13r5 5;
        make_f br13r5 6;
      ]
    );
    "is_empty" >:: [
      "empty" >: (lazy (check_true (is_empty Empty)));
      "not empty" >: (lazy (check_false (is_empty bb13b5r7)));
    ];
    "remove" >:: (
      let make t x expected =
        ~: "remove %s %i" (repr t) x (lazy (
          check_poly ~repr:(Tuples.Tuple2.repr ~repr_a:Bool.repr ~repr_b:repr) ~expected (remove t ~cmp ~cmp_k:cmp x)
        ))
      in
      let make_t t x expected =
        make t x (true, expected)
      and make_f t x =
        make t x (false, t)
      in
      [
        make_f Empty 0;

        make_f b1 0;
        make_t b1 1 Empty;
        make_f b1 2;

        make_f b1r3 0;
        make_t b1r3 1 (Black {l=Empty; v=3; r=Empty});
        make_f b1r3 2;
        make_t b1r3 3 (Black {l=Empty; v=1; r=Empty});
        make_f b1r3 4;

        make_f br13 0;
        make_t br13 1 (Black {l=Empty; v=3; r=Empty});
        make_f br13 2;
        make_t br13 3 (Black {l=Empty; v=1; r=Empty});
        make_f br13 4;

        make_f bb13b5 0;
        make_t bb13b5 1 (Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}});
        make_f bb13b5 2;
        make_t bb13b5 3 (Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty});
        make_f bb13b5 4;
        make_t bb13b5 5 (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty});
        make_f bb13b5 6;

        make_f br13r5 0;
        make_t br13r5 1 (Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}});
        make_f br13r5 2;
        make_t br13r5 3 (Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty});
        make_f br13r5 4;
        make_t br13r5 5 (Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty});
        make_f br13r5 6;

        make_f bb13b5r7 0;
        make_t bb13b5r7 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb13b5r7 2;
        make_t bb13b5r7 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb13b5r7 4;
        make_t bb13b5r7 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb13b5r7 6;
        make_t bb13b5r7 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}});
        make_f bb13b5r7 8;

        make_f bb13br57 0;
        make_t bb13br57 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb13br57 2;
        make_t bb13br57 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb13br57 4;
        make_t bb13br57 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb13br57 6;
        make_t bb13br57 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}});
        make_f bb13br57 8;

        make_f bb1r35b7 0;
        make_t bb1r35b7 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35b7 2;
        make_t bb1r35b7 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35b7 4;
        make_t bb1r35b7 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35b7 6;
        make_t bb1r35b7 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}});
        make_f bb1r35b7 8;

        make_f bbr135b7 0;
        make_t bbr135b7 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135b7 2;
        make_t bbr135b7 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135b7 4;
        make_t bbr135b7 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135b7 6;
        make_t bbr135b7 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}});
        make_f bbr135b7 8;

        make_f bb13br57r9 0;
        make_t bb13br57r9 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13br57r9 2;
        make_t bb13br57r9 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13br57r9 4;
        make_t bb13br57r9 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13br57r9 6;
        make_t bb13br57r9 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=9; r=Empty}});
        make_f bb13br57r9 8;
        make_t bb13br57r9 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}});
        make_f bb13br57r9 10;

        make_f bb13rb57b9 0;
        make_t bb13rb57b9 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bb13rb57b9 2;
        make_t bb13rb57b9 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9 4;
        make_t bb13rb57b9 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9 6;
        make_t bb13rb57b9 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=9; r=Empty}});
        make_f bb13rb57b9 8;
        make_t bb13rb57b9 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}});
        make_f bb13rb57b9 10;

        make_f bb1r35b7r9 0;
        make_t bb1r35b7r9 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 2;
        make_t bb1r35b7r9 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bb1r35b7r9 4;
        make_t bb1r35b7r9 5 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bb1r35b7r9 6;
        make_t bb1r35b7r9 7 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=9; r=Empty}});
        make_f bb1r35b7r9 8;
        make_t bb1r35b7r9 9 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35b7r9 10;

        make_f bb1r35br79 0;
        make_t bb1r35br79 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35br79 2;
        make_t bb1r35br79 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35br79 4;
        make_t bb1r35br79 5 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bb1r35br79 6;
        make_t bb1r35br79 7 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=9; r=Empty}});
        make_f bb1r35br79 8;
        make_t bb1r35br79 9 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bb1r35br79 10;

        make_f bbr135b7r9 0;
        make_t bbr135b7r9 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 2;
        make_t bbr135b7r9 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Red {l=Empty; v=9; r=Empty}}});
        make_f bbr135b7r9 4;
        make_t bbr135b7r9 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr135b7r9 6;
        make_t bbr135b7r9 7 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr135b7r9 8;
        make_t bbr135b7r9 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135b7r9 10;

        make_f bbr135br79 0;
        make_t bbr135br79 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135br79 2;
        make_t bbr135br79 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135br79 4;
        make_t bbr135br79 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr135br79 6;
        make_t bbr135br79 7 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr135br79 8;
        make_t bbr135br79 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}});
        make_f bbr135br79 10;

        make_f bbr13r57b9 0;
        make_t bbr13r57b9 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 2;
        make_t bbr13r57b9 3 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 4;
        make_t bbr13r57b9 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9 6;
        make_t bbr13r57b9 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=9; r=Empty}});
        make_f bbr13r57b9 8;
        make_t bbr13r57b9 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}});
        make_f bbr13r57b9 10;

        make_f brb13b57b9 0;
        make_t brb13b57b9 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 2;
        make_t brb13b57b9 3 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 4;
        make_t brb13b57b9 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9 6;
        make_t brb13b57b9 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=9; r=Empty}});
        make_f brb13b57b9 8;
        make_t brb13b57b9 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Red {l=Empty; v=5; r=Empty}; v=7; r=Empty}});
        make_f brb13b57b9 10;

        make_f bb13rb57b9r11 0;
        make_t bb13rb57b9r11 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57b9r11 2;
        make_t bb13rb57b9r11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57b9r11 4;
        make_t bb13rb57b9r11 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57b9r11 6;
        make_t bb13rb57b9r11 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57b9r11 8;
        make_t bb13rb57b9r11 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57b9r11 10;
        make_t bb13rb57b9r11 11 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57b9r11 12;

        make_f bb13rb57br911 0;
        make_t bb13rb57br911 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f bb13rb57br911 2;
        make_t bb13rb57br911 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57br911 4;
        make_t bb13rb57br911 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57br911 6;
        make_t bb13rb57br911 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57br911 8;
        make_t bb13rb57br911 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb57br911 10;
        make_t bb13rb57br911 11 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb57br911 12;

        make_f bb13rb5r79b11 0;
        make_t bb13rb5r79b11 1 (Black {l=Red {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f bb13rb5r79b11 2;
        make_t bb13rb5r79b11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb5r79b11 4;
        make_t bb13rb5r79b11 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb5r79b11 6;
        make_t bb13rb5r79b11 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb5r79b11 8;
        make_t bb13rb5r79b11 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rb5r79b11 10;
        make_t bb13rb5r79b11 11 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rb5r79b11 12;

        make_f bb13rbr579b11 0;
        make_t bb13rbr579b11 1 (Black {l=Red {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f bb13rbr579b11 2;
        make_t bb13rbr579b11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rbr579b11 4;
        make_t bb13rbr579b11 5 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rbr579b11 6;
        make_t bb13rbr579b11 7 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rbr579b11 8;
        make_t bb13rbr579b11 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb13rbr579b11 10;
        make_t bb13rbr579b11 11 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f bb13rbr579b11 12;

        make_f bb1r35br79r11 0;
        make_t bb1r35br79r11 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb1r35br79r11 2;
        make_t bb1r35br79r11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb1r35br79r11 4;
        make_t bb1r35br79r11 5 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb1r35br79r11 6;
        make_t bb1r35br79r11 7 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb1r35br79r11 8;
        make_t bb1r35br79r11 9 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=11; r=Empty}});
        make_f bb1r35br79r11 10;
        make_t bb1r35br79r11 11 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35br79r11 12;

        make_f bb1r35rb79b11 0;
        make_t bb1r35rb79b11 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb1r35rb79b11 2;
        make_t bb1r35rb79b11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bb1r35rb79b11 4;
        make_t bb1r35rb79b11 5 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb1r35rb79b11 6;
        make_t bb1r35rb79b11 7 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bb1r35rb79b11 8;
        make_t bb1r35rb79b11 9 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=11; r=Empty}});
        make_f bb1r35rb79b11 10;
        make_t bb1r35rb79b11 11 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bb1r35rb79b11 12;

        make_f bbr135br79r11 0;
        make_t bbr135br79r11 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr135br79r11 2;
        make_t bbr135br79r11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr135br79r11 4;
        make_t bbr135br79r11 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr135br79r11 6;
        make_t bbr135br79r11 7 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr135br79r11 8;
        make_t bbr135br79r11 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=11; r=Empty}});
        make_f bbr135br79r11 10;
        make_t bbr135br79r11 11 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135br79r11 12;

        make_f bbr135rb79b11 0;
        make_t bbr135rb79b11 1 (Black {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bbr135rb79b11 2;
        make_t bbr135rb79b11 3 (Black {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Red {l=Black {l=Empty; v=7; r=Empty}; v=9; r=Black {l=Empty; v=11; r=Empty}}});
        make_f bbr135rb79b11 4;
        make_t bbr135rb79b11 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr135rb79b11 6;
        make_t bbr135rb79b11 7 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr135rb79b11 8;
        make_t bbr135rb79b11 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=11; r=Empty}});
        make_f bbr135rb79b11 10;
        make_t bbr135rb79b11 11 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f bbr135rb79b11 12;

        make_f bbr13r57b9r11 0;
        make_t bbr13r57b9r11 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr13r57b9r11 2;
        make_t bbr13r57b9r11 3 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr13r57b9r11 4;
        make_t bbr13r57b9r11 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f bbr13r57b9r11 6;
        make_t bbr13r57b9r11 7 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f bbr13r57b9r11 8;
        make_t bbr13r57b9r11 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=11; r=Empty}});
        make_f bbr13r57b9r11 10;
        make_t bbr13r57b9r11 11 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57b9r11 12;

        make_f bbr13r57br911 0;
        make_t bbr13r57br911 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f bbr13r57br911 2;
        make_t bbr13r57br911 3 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f bbr13r57br911 4;
        make_t bbr13r57br911 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f bbr13r57br911 6;
        make_t bbr13r57br911 7 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f bbr13r57br911 8;
        make_t bbr13r57br911 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=11; r=Empty}});
        make_f bbr13r57br911 10;
        make_t bbr13r57br911 11 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f bbr13r57br911 12;

        make_f brb13b57b9r11 0;
        make_t brb13b57b9r11 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f brb13b57b9r11 2;
        make_t brb13b57b9r11 3 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f brb13b57b9r11 4;
        make_t brb13b57b9r11 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Red {l=Empty; v=11; r=Empty}}});
        make_f brb13b57b9r11 6;
        make_t brb13b57b9r11 7 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b57b9r11 8;
        make_t brb13b57b9r11 9 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b57b9r11 10;
        make_t brb13b57b9r11 11 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57b9r11 12;

        make_f brb13b57br911 0;
        make_t brb13b57br911 1 (Black {l=Black {l=Empty; v=3; r=Red {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f brb13b57br911 2;
        make_t brb13b57br911 3 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=5; r=Empty}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f brb13b57br911 4;
        make_t brb13b57br911 5 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=7; r=Black {l=Red {l=Empty; v=9; r=Empty}; v=11; r=Empty}});
        make_f brb13b57br911 6;
        make_t brb13b57br911 7 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b57br911 8;
        make_t brb13b57br911 9 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b57br911 10;
        make_t brb13b57br911 11 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=7; r=Black {l=Empty; v=9; r=Empty}});
        make_f brb13b57br911 12;

        make_f brb13b5r79b11 0;
        make_t brb13b5r79b11 1 (Black {l=Red {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b5r79b11 2;
        make_t brb13b5r79b11 3 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b5r79b11 4;
        make_t brb13b5r79b11 5 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b5r79b11 6;
        make_t brb13b5r79b11 7 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13b5r79b11 8;
        make_t brb13b5r79b11 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=11; r=Empty}}});
        make_f brb13b5r79b11 10;
        make_t brb13b5r79b11 11 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f brb13b5r79b11 12;

        make_f brb13br579b11 0;
        make_t brb13br579b11 1 (Black {l=Red {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13br579b11 2;
        make_t brb13br579b11 3 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13br579b11 4;
        make_t brb13br579b11 5 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13br579b11 6;
        make_t brb13br579b11 7 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb13br579b11 8;
        make_t brb13br579b11 9 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=11; r=Empty}}});
        make_f brb13br579b11 10;
        make_t brb13br579b11 11 (Black {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Red {l=Black {l=Empty; v=5; r=Empty}; v=7; r=Black {l=Empty; v=9; r=Empty}}});
        make_f brb13br579b11 12;

        make_f brb1r35b79b11 0;
        make_t brb1r35b79b11 1 (Black {l=Red {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb1r35b79b11 2;
        make_t brb1r35b79b11 3 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb1r35b79b11 4;
        make_t brb1r35b79b11 5 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb1r35b79b11 6;
        make_t brb1r35b79b11 7 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brb1r35b79b11 8;
        make_t brb1r35b79b11 9 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=11; r=Empty}});
        make_f brb1r35b79b11 10;
        make_t brb1r35b79b11 11 (Black {l=Black {l=Empty; v=1; r=Red {l=Empty; v=3; r=Empty}}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f brb1r35b79b11 12;

        make_f brbr135b79b11 0;
        make_t brbr135b79b11 1 (Black {l=Red {l=Black {l=Empty; v=3; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brbr135b79b11 2;
        make_t brbr135b79b11 3 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=5; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brbr135b79b11 4;
        make_t brbr135b79b11 5 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=7; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brbr135b79b11 6;
        make_t brbr135b79b11 7 (Black {l=Red {l=Black {l=Empty; v=1; r=Empty}; v=3; r=Black {l=Empty; v=5; r=Empty}}; v=9; r=Black {l=Empty; v=11; r=Empty}});
        make_f brbr135b79b11 8;
        make_t brbr135b79b11 9 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=11; r=Empty}});
        make_f brbr135b79b11 10;
        make_t brbr135b79b11 11 (Black {l=Black {l=Red {l=Empty; v=1; r=Empty}; v=3; r=Empty}; v=5; r=Black {l=Red {l=Empty; v=7; r=Empty}; v=9; r=Empty}});
        make_f brbr135b79b11 12;
      ]
    );
    "heterogeneous" >:: (
      let cmp_k (`Int (x:int)) (y:int) = Int.compare x y in
      [
        "try_get" >: (lazy (
          check_some_42 (try_get (Black {l=Empty; v=42; r=Empty}) ~cmp ~cmp_k (`Int 42))
        ));
        "remove" >: (lazy (
          check_poly
            ~repr:(Tuples.Tuple2.repr ~repr_a:Bool.repr ~repr_b:repr)
            ~expected:(true, Empty)
            (remove (Black {l=Empty; v=42; r=Empty}) ~cmp ~cmp_k (`Int 42))
        ));
      ]
    );
    "to_list" >:: (
      let make t expected =
        (repr t) >: (lazy (
          check_int_list ~expected (to_list ~cmp t)
        ))
      in
      [
        make empty [];
        make bb13br57r9 [1; 3; 5; 7; 9];
      ]
    );
    "size" >:: (
      let make t expected =
        (repr t) >: (lazy (
          check_int ~expected (size ~cmp t)
        ))
      in
      [
        make empty 0;
        make bb13br57r9 5;
      ]
    );
  ]
end
# 306 "General.cppo.ml"
end

module BinaryHeap = struct
# 1 "Implementation/BinaryHeap.ml"
module OCSA = OCamlStandard.ArrayLabels

type 'a t = 'a array

let (empty: 'a t) = [||]

let is_empty = function
  | [||] -> true
  | _ -> false

let parent i =
  (i - 1) / 2

let children i =
  (2 * i + 1, 2 * i + 2)

module Invariants = struct
  type t =
    | IsMaxHeap

  exception BrokenInvariants of t list

  (*BISECT-IGNORE-BEGIN*)
  let repr = function
    | IsMaxHeap -> "IsMaxHeap"

  let _ = Exception.register_printer (function
    | BrokenInvariants broken_invariants ->
      Some (Format.apply "Broken binary heap invariants: %s" (broken_invariants |> List.map ~f:repr |> List.join_string_list ~sep:", "))
    | _ ->
      None
  )
  (*BISECT-IGNORE-END*)

  let is_max_heap xs ~cmp =
    IntRange.make (OCSA.length xs)
    |> IntRange.for_all ~f:(fun i ->
      match cmp xs.(i) xs.(parent i) with
        | Compare.LT
        | Compare.EQ -> true
        | Compare.GT -> false
    )

  let validate xs ~cmp =
    match
      [
        (is_max_heap ~cmp, IsMaxHeap);
      ]
      |> List.filter_map ~f:(fun (predicate, invariant) ->
        Option.some_if' (not (predicate xs)) invariant
      )
    with
      | [] -> xs
      | broken_invariants -> Exception.raise (BrokenInvariants broken_invariants)
end

let swap xs i j =
  let x = xs.(i) in
  xs.(i) <- xs.(j);
  xs.(j) <- x

let add xs ~cmp x =
  let xs = OCSA.append xs [|x|] in
  let rec aux = function
    | 0 -> ()
    | i ->
      let p = parent i in
      match cmp xs.(i) xs.(p) with
        | Compare.LT
        | Compare.EQ -> ()
        | Compare.GT -> begin
          swap xs i p;
          aux p
        end
  in
  aux ((OCSA.length xs) - 1);
  xs

(* @todo Define DEBUG when compiling with jbuilder --dev *)
(* #ifdef DEBUG *)
let add xs ~cmp x =
  Invariants.(validate ~cmp (add (validate ~cmp xs) ~cmp x))
(* #endif *)

let max xs =
  xs.(0)

let pop_max xs ~cmp =
  let len = OCSA.length xs - 1 in
  if len = 0 then empty else
  let last = xs.(len) in
  let xs = OCSA.sub xs ~pos:0 ~len in
  xs.(0) <- last;
  let rec aux i =
    let (l, r) = children i in
    if r < len then begin
      match (cmp xs.(i) xs.(l), cmp xs.(i) xs.(r)) with
        | ((Compare.GT | Compare.EQ), (Compare.GT | Compare.EQ)) ->
          ()
        | _ ->
          let c =
            match cmp xs.(l) xs.(r) with
              | Compare.LT
              | Compare.EQ -> r
              | Compare.GT -> l
          in
          swap xs i c;
          aux c
    end else if l < len then begin
      match cmp xs.(i) xs.(l) with
        | Compare.GT | Compare.EQ ->
          ()
        | Compare.LT ->
          swap xs i l;
          aux l (* @todo Is this recursion needed? *)
    end
  in
  aux 0;
  xs

let pop_max xs ~cmp =
  Invariants.(xs |> validate ~cmp |> pop_max ~cmp |> validate ~cmp)

module Tests = struct
  open Testing

  let make name ?(init=empty) fs expected =
    name >: (lazy (
      let heap = List.fold ~init ~f:(fun heap f -> f heap) fs in
      check_int_list ~expected (OCSA.to_list heap)
    ))

  let add x xs =
    add xs ~cmp:Int.compare x

  let pop_max xs =
    pop_max xs ~cmp:Int.compare

  let test = "BinaryHeap" >:: [
    make "empty" [] [];
    "add" >:: (
      let make xs expected =
        let name = List.repr ~repr_a:Int.repr xs
        and fs = List.map ~f:(fun x -> add x) xs in
        make name fs expected
      in
      [
        make [0] [0];
        make [0; 1] [1; 0];
        make [1; 0] [1; 0];
        make [0; 1; 2] [2; 0; 1];
        make [0; 2; 1] [2; 0; 1];
        make [1; 0; 2] [2; 0; 1];
        make [1; 2; 0] [2; 1; 0];
        make [2; 0; 1] [2; 0; 1];
        make [2; 1; 0] [2; 1; 0];
        make [0; 0; 0; 0; 0; 0; 0; 1] [1; 0; 0; 0; 0; 0; 0; 0];
        make [1; 0; 0; 0; 0; 0; 0; 0] [1; 0; 0; 0; 0; 0; 0; 0];
      ]
    );
    "pop_max" >:: (
      let make xs expected =
        let name = List.repr ~repr_a:Int.repr xs in
        make name ~init:(OCSA.of_list xs) [pop_max] expected
      in
      [
        make [1] [];
        make [2; 1] [1];
        make [3; 2; 1] [2; 1];
        make [3; 1; 2] [2; 1];
        make [4; 3; 2; 1] [3; 1; 2];
        make [4; 3; 1; 2] [3; 2; 1];
        make [4; 2; 3; 1] [3; 2; 1];
      ]
    );
  ]
end
# 310 "General.cppo.ml"
end

module PriorityQueue = struct
# 1 "Implementation/PriorityQueue.ml"
module Poly = struct
  let cmp (x, _) (y, _) =
    Compare.Poly.compare x y

  type ('a, 'b) t = ('a * 'b) BinaryHeap.t

  let empty = BinaryHeap.empty

  let is_empty xs = BinaryHeap.is_empty xs

  let add xs ~k ~v =
    BinaryHeap.add xs ~cmp (k, v)

  let max xs =
    BinaryHeap.max xs

  let pop_max xs =
    BinaryHeap.pop_max ~cmp xs
end

module Make(E: Traits.Comparable.Basic.S0) = struct
  let cmp (x, _) (y, _) =
    E.compare x y

  type 'a t = (E.t * 'a) BinaryHeap.t

  let empty = BinaryHeap.empty

  let is_empty xs = BinaryHeap.is_empty xs

  let add xs ~k ~v =
    BinaryHeap.add xs ~cmp (k, v)

  let max xs =
    BinaryHeap.max xs

  let pop_max xs =
    BinaryHeap.pop_max ~cmp xs
end
# 314 "General.cppo.ml"
end

module Reference = struct
# 1 "Implementation/Reference.ml"
module Ref = Foundations.Reference

include Ref

module SpecializeOperators(A: sig type t end) = struct
  type t = A.t Ref.t

  include Ref.O
end

module Specialize(A: sig type t end) = struct
  type t = A.t Ref.t

  include (Ref: module type of Ref with type 'a t := 'a Ref.t)
end

module SpecializePredSucc(A: Traits.PredSucc.S0) = struct
  open Ref.O

  type t = A.t Ref.t

  let increment r =
    r := A.succ !r

  let decrement r =
    r := A.pred !r
end

module SpecializeRingoidOperators(A: Traits.Ringoid.Basic.S0) = struct
  open Ref.O

  type t = A.t Ref.t

  let (=+) r v =
    r := A.add !r v

  let (=-) r v =
    r := A.substract !r v

  let (=*) r v =
    r := A.multiply !r v

  let (=/) r v =
    r := A.divide !r v
end

module SpecializeRingoid(A: Traits.Ringoid.Basic.S0) = struct
  type t = A.t Ref.t

  module O = (SpecializeRingoidOperators(A): module type of SpecializeRingoidOperators(A) with type t := t)
end
# 318 "General.cppo.ml"
end

module SortedMap = struct
# 1 "Implementation/SortedMap.ml"
module Tree = RedBlackTree

module Poly = struct
  let cmp (x, _) (y, _) =
    Compare.Poly.compare x y

  let cmp_k x (y, _) =
    Compare.Poly.compare x y

  type ('a, 'b) t = ('a * 'b) Tree.t

  let empty = Tree.empty

  let is_empty = Tree.is_empty

  let size t =
    Tree.size t ~cmp

  let add t ~k ~v =
    Tree.add t ~cmp (k, v)

  let of_list_first vs =
    vs
    |> List.fold ~init:empty ~f:(fun t (k, v) ->
      add t ~k ~v
      |> Tuples.Tuple2.get_1
    )

  let replace t ~k ~v =
    Tree.replace t ~cmp (k, v)

  let singleton ~k ~v =
    replace empty ~k ~v

  let of_list_last vs =
    vs
    |> List.fold ~init:empty ~f:(fun t (k, v) ->
      replace t ~k ~v
    )

  let remove t ~k =
    Tree.remove t ~cmp ~cmp_k k

  let to_list t =
    Tree.to_list t ~cmp

  let try_get t ~k =
    Tree.try_get t ~cmp ~cmp_k k
    |> Option.map ~f:Tuples.Tuple2.get_1

  let get t ~k =
    try_get t ~k
    |> Option.or_failure ""

  let of_list_reduce vs ~f =
    vs
    |> List.fold ~init:empty ~f:(fun t (k, v) ->
      match try_get t ~k with
        | None -> replace t ~k ~v
        | Some v2 -> replace t ~k ~v:(f k v2 v)
    )
end

module Make(K: Traits.Comparable.Basic.S0) = struct
  let cmp (x, _) (y, _) =
    K.compare x y

  let cmp_k x (y, _) =
    K.compare x y

  type 'a t = (K.t * 'a) Tree.t

  let empty = Tree.empty

  let is_empty = Tree.is_empty

  let size t =
    Tree.size t ~cmp

  let add t ~k ~v =
    Tree.add t ~cmp (k, v)

  let of_list_first vs =
    vs
    |> List.fold ~init:empty ~f:(fun t (k, v) ->
      add t ~k ~v
      |> Tuples.Tuple2.get_1
    )

  let replace t ~k ~v =
    Tree.replace t ~cmp (k, v)

  let singleton ~k ~v =
    replace empty ~k ~v

  let of_list_last vs =
    vs
    |> List.fold ~init:empty ~f:(fun t (k, v) ->
      replace t ~k ~v
    )

  let remove t ~k =
    Tree.remove t ~cmp ~cmp_k k

  let to_list t =
    Tree.to_list t ~cmp

  let try_get t ~k =
    Tree.try_get t ~cmp ~cmp_k k
    |> Option.map ~f:Tuples.Tuple2.get_1

  let get t ~k =
    try_get t ~k
    |> Option.or_failure ""

  let of_list_reduce vs ~f =
    vs
    |> List.fold ~init:empty ~f:(fun t (k, v) ->
      match try_get t ~k with
        | None -> replace t ~k ~v
        | Some v2 -> replace t ~k ~v:(f k v2 v)
    )
end
# 322 "General.cppo.ml"
end

module SortedSet = struct
# 1 "Implementation/SortedSet.ml"
module Tree = RedBlackTree

module Poly = struct
  let cmp = Compare.Poly.compare
  let cmp_k = cmp

  (* @todo Forbid using Poly.equal and Poly.compare *)
  type 'a t = 'a Tree.t

  let empty = Tree.empty

  let is_empty = Tree.is_empty

  let size t =
    Tree.size t ~cmp

  let add t ~v =
    Tree.add t ~cmp v

  let of_list vs =
    vs
    |> List.fold ~init:empty ~f:(fun t v ->
      add t ~v
      |> Tuples.Tuple2.get_1
    )

  let replace t ~v =
    Tree.replace t ~cmp v

  let remove t ~v =
    Tree.remove t ~cmp ~cmp_k v

  let to_list t =
    Tree.to_list t ~cmp

  let contains t ~v =
    Tree.try_get t ~cmp ~cmp_k v
    |> Option.is_some
end

module Make(E: Traits.Comparable.Basic.S0) = struct
  let cmp = E.compare
  let cmp_k = cmp

  (* @todo Forbid using Poly.equal and Poly.compare *)
  type t = E.t Tree.t

  let empty = Tree.empty

  let is_empty = Tree.is_empty

  let size t =
    Tree.size t ~cmp

  let add t ~v =
    Tree.add t ~cmp v

  let of_list vs =
    vs
    |> List.fold ~init:empty ~f:(fun t v ->
      add t ~v
      |> Tuples.Tuple2.get_1
    )

  let replace t ~v =
    Tree.replace t ~cmp v

  let remove t ~v =
    Tree.remove t ~cmp ~cmp_k v

  let to_list t =
    Tree.to_list t ~cmp

  let contains t ~v =
    Tree.try_get t ~cmp ~cmp_k v
    |> Option.is_some
end
# 326 "General.cppo.ml"
end

module Heap = struct
# 1 "Implementation/Heap.ml"
module Poly = struct
  let cmp x y =
    Compare.Poly.compare x y

  type 'a t = 'a BinaryHeap.t

  let empty = BinaryHeap.empty

  let add xs ~v =
    BinaryHeap.add xs ~cmp v

  let max xs =
    BinaryHeap.max xs

  let pop_max xs =
    BinaryHeap.pop_max ~cmp xs
end

module Make(E: Traits.Comparable.Basic.S0) = struct
  let cmp x y =
    E.compare x y

  type t = E.t BinaryHeap.t

  let empty = BinaryHeap.empty

  let add xs ~v =
    BinaryHeap.add xs ~cmp v

  let max xs =
    BinaryHeap.max xs

  let pop_max xs =
    BinaryHeap.pop_max ~cmp xs
end
# 330 "General.cppo.ml"
end

module StandardOutChannel = struct
# 1 "Implementation/StandardOutChannel.ml"
module Make(C: sig
  val channel: OutChannel.t
  val flush: bool
end) = struct
  let channel = C.channel

  let print ?(flush=C.flush) format =
    OutChannel.print ~flush channel format

  let output x =
    OutChannel.output channel x

  let flush () =
    OutChannel.flush channel
end
# 334 "General.cppo.ml"
end

module StdErr = struct
# 1 "Implementation/StdErr.ml"
module OCSP = OCamlStandard.Pervasives

include StandardOutChannel.Make(struct
  let channel = OCSP.stderr
  let flush = true
end)
# 338 "General.cppo.ml"
end

module StdIn = struct
# 1 "Implementation/StdIn.ml"
module OCSP = OCamlStandard.Pervasives

let channel = OCSP.stdin
# 342 "General.cppo.ml"
end

module StdOut = struct
# 1 "Implementation/StdOut.ml"
module OCSP = OCamlStandard.Pervasives

include StandardOutChannel.Make(struct
  let channel = OCSP.stdout
  let flush = false
end)
# 346 "General.cppo.ml"
end

module Stream = struct
# 1 "Implementation/Stream.ml"
module Self = Foundations.Stream

include Self

module Tests = struct
  open Testing

  let test = "Stream" >:: [
    (let module T = Traits.FilterMapable.Tests.Make1(Self) in T.test);
    (let module T = Traits.FilterMapable.ToList.Tests.Make1(Self)(Self.ToList)(List) in T.test);
  ]
end
# 350 "General.cppo.ml"
end

module String = struct
# 1 "Implementation/String.ml"
include Foundations.String

let split' s ~seps =
  let seps = SortedSet.Poly.of_list seps in
  let (parts, last_part) =
    s
    |> fold ~init:([], []) ~f:(fun (parts, current_part) c ->
      if SortedSet.Poly.contains seps ~v:c then
        (current_part::parts, [])
      else
        (parts, c::current_part)
    )
  in
  last_part::parts
  |> List.map ~f:List.reverse
  |> List.map ~f:of_list
  |> List.reverse

module Tests = struct
  open Testing

  module Examples = struct
    let repr = [
      ("foo", "\"foo\"");
      ("bar\"baz", "\"bar\\\"baz\"");
    ]

    let equal = [
      ["foo"];
    ]

    let different = [
      ("foo", "bar");
    ]

    let ordered = [
      ["aaaa"; "aaaaa"; "aaaab"; "ab"; "b"];
    ]
  end

  let test = "String" >:: [
    (let module T = Concepts.Able.Tests.Make0(Foundations.String)(Examples) in T.test);
    "split'" >:: (
      let make s seps expected =
        ~: "%S %S" s (of_list seps) (lazy (
          check_string_list ~expected (split' s ~seps)
        ))
      in
      [
        make "abcdefghfj" ['c'; 'f'] ["ab"; "de"; "gh"; "j"];
        make "xabxxcdx" ['x'] [""; "ab"; ""; "cd"; ""];
      ]
    );
  ]
end
# 354 "General.cppo.ml"
end

module TestingTests = struct
# 1 "Implementation/TestingTests.ml"
(* The position of these symbols is tested below. Moving them requires fixing the tests *)
let callstack = CallStack.current ()
(* End of symbols to not move *)

module Tests = struct
  open Foundations
  open Testing

  exception TestException0
  exception TestException0'
  exception TestException1 of string

  let () = Exception.register_printer (function
    | TestException0 -> Some "TestingTests.Tests.TestException0"
    | TestException0' -> Some "TestingTests.Tests.TestException0'"
    | TestException1 s -> Some (Format.apply "TestingTests.Tests.TestException1(%S)" s)
    | _ -> None
  )

  module ResultExamples = struct
    open Result
    open Status
    open Counts

    let repr = [
      (Single {label="foo"; status=Success}, "Single {label=\"foo\"; status=Success}");
      (Single {label="foo"; status=Failure (NotEqual ("a", "b"))}, "Single {label=\"foo\"; status=Failure (NotEqual (\"a\", \"b\"))}");
      (Single {label="foo"; status=Failure (NoException TestException0)}, "Single {label=\"foo\"; status=Failure (NoException TestingTests.Tests.TestException0)}");
      (Single {label="foo"; status=Failure (NoExceptionNamed "Foo")}, "Single {label=\"foo\"; status=Failure (NoExceptionNamed \"Foo\")}");
      (Single {label="foo"; status=Failure (WrongException (TestException0, TestException0', None))}, "Single {label=\"foo\"; status=Failure (WrongException (TestingTests.Tests.TestException0, TestingTests.Tests.TestException0', None))}");
      (Single {label="foo"; status=Failure (WrongExceptionNamed ("Foo", TestException0', None))}, "Single {label=\"foo\"; status=Failure (WrongExceptionNamed (\"Foo\", TestingTests.Tests.TestException0', None))}");
      (Single {label="foo"; status=Failure (Custom "bad")}, "Single {label=\"foo\"; status=Failure (Custom \"bad\")}");
      (Single {label="foo"; status=Error (TestException0, None)}, "Single {label=\"foo\"; status=Error (TestingTests.Tests.TestException0, None)}");
      (Group {name="bar"; children=[Single {label="foo"; status=Success}]; counts={successes=1; failures=2; errors=3}}, "Group {name=\"bar\"; children=[Single {label=\"foo\"; status=Success}]; counts={successes=1; failures=2; errors=3}}");
    ]
  end

  let test = "Testing" >:: [
    "Result" >:: [
      (let module T = Traits.Representable.Tests.Make0(Result)(ResultExamples) in T.test);
      "to_indented_strings" >:: (
        let make ?(verbose=false) expected result =
          (expected |> Foundations.List.join_string_list ~sep:"\n") >: (lazy (
            let actual =
              result
              |> Result.to_indented_strings ~verbose
            in
            check_string_list ~expected actual
          ))
        in
        Result.(Status.(Counts.[
          make ~verbose:true
            ["\"foo\": OK"]
            (Single {label="foo"; status=Success});
          make
            ["\"bar 1\": FAILED: expected a, but got b"]
            (Single {label="bar 1"; status=Failure (NotEqual ("a", "b"))});
          make
            ["\"bar 2\": FAILED: expected exception TestingTests.Tests.TestException0 not raised"]
            (Single {label="bar 2"; status=Failure (NoException TestException0)});
          make
            ["\"bar 2'\": FAILED: expected exception Foo not raised"]
            (Single {label="bar 2'"; status=Failure (NoExceptionNamed "Foo")});
          make
            ["\"bar 3\": FAILED: expected exception TestingTests.Tests.TestException0 not raised, but exception TestingTests.Tests.TestException0' raised (no backtrace)"]
            (Single {label="bar 3"; status=Failure (WrongException (TestException0, TestException0', None))});
          make
            ["\"bar 3'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException0' raised (no backtrace)"]
            (Single {label="bar 3'"; status=Failure (WrongExceptionNamed ("Foo", TestException0', None))});
          make
            [
              if javascript then
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n"
              else
                "\"bar 4\": FAILED: expected exception TestingTests.Tests.TestException1(\"bad\") not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                 Raised by primitive operation at file \"Implementation/TestingTests.ml\", line 2, characters 16-36\n"
            ]
            (Single {label="bar 4"; status=Failure (WrongException (TestException1 "bad", TestException1 "too bad", Some callstack))});
          make
            [
              if javascript then
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n"
              else
                "\"bar 4'\": FAILED: expected exception Foo not raised, but exception TestingTests.Tests.TestException1(\"too bad\") raised\n\
                 Raised by primitive operation at file \"Implementation/TestingTests.ml\", line 2, characters 16-36\n"
            ]
            (Single {label="bar 4'"; status=Failure (WrongExceptionNamed ("Foo", TestException1 "too bad", Some callstack))});
          make
            ["\"bar 5\": FAILED: too bad"]
            (Single {label="bar 5"; status=Failure (Custom "too bad")});
          make
            ["\"bar 6\": ERROR: exception TestingTests.Tests.TestException0 raised (no backtrace)"]
            (Single {label="bar 6"; status=Error (TestException0, None)});
          make
            [
              if javascript then
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n"
              else
                "\"bar 7\": ERROR: exception TestingTests.Tests.TestException1(\"bad\") raised\n\
                 Raised by primitive operation at file \"Implementation/TestingTests.ml\", line 2, characters 16-36\n"
            ]
            (Single {label="bar 7"; status=Error (TestException1 "bad", Some callstack)});
          make ~verbose:true
            [
              "\"foo\" (Successes: 2)";
              "  \"bar\": OK";
              "  \"baz\": OK";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Success}; Single {label="baz"; status=Success}]; counts={successes=2; failures=0; errors=0}});
          make ~verbose:false
            [
              "\"foo\" (Successes: 2)";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Success}; Single {label="baz"; status=Success}]; counts={successes=2; failures=0; errors=0}});
          make ~verbose:true
            [
              "\"foo\" (Successes: 1, failures: 1, errors: 0)";
              "  \"bar\": FAILED: nope";
              "  \"baz\": OK";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Failure (Custom "nope")}; Single {label="baz"; status=Success}]; counts={successes=1; failures=1; errors=0}});
          make ~verbose:false
            [
              "\"foo\" (Successes: 1, failures: 1, errors: 0)";
              "  \"bar\": FAILED: nope";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Failure (Custom "nope")}; Single {label="baz"; status=Success}]; counts={successes=1; failures=1; errors=0}});
          make
            [
              "\"foo\" (Successes: 0, failures: 0, errors: 1)";
              "  \"bar\": ERROR: exception TestingTests.Tests.TestException0 raised (no backtrace)";
            ]
            (Group {name="foo"; children=[Single {label="bar"; status=Error (TestException0, None)}]; counts={successes=0; failures=0; errors=1}});
        ]))
      );
    ];
    "Test" >:: [
      ~:: "ru%s" "n" (
        let make expected test =
          let name = match test with
            | Test.Single {Test.label; _} -> label
            | Test.Group {Test.name; _} -> name
          in
          name >: (lazy (check ~repr:Result.repr ~equal:Result.equal ~expected (Test.run ~record_backtrace:false test)))
        in
        Result.(Status.(Counts.[
          make (Single {label="single success"; status=Success}) ("single success" >: (lazy ()));
          make
            (Group {name="group success"; children=[Single {label="child"; status=Success}]; counts={successes=1; failures=0; errors=0}})
            ("group success" >:: ["child" >: (lazy ())]);
          make
            (Single {label="not equal failure"; status=Failure (NotEqual ("42", "43"))})
            ("not equal failure" >: (lazy (check_42 43)));
          make
            (Single {label="no exception"; status=Failure (NoException TestException0)})
            ("no exception" >: (lazy (expect_exception ~expected:TestException0 (lazy ()))));
          make
            (Single {label="wrong exception"; status=Failure (WrongException (TestException0, TestException0', None))})
            ("wrong exception" >: (lazy (expect_exception ~expected:TestException0 (lazy (Exception.raise TestException0')))));
          make
            (Single {label="custom failure"; status=Failure (Custom "bad")})
            ("custom failure" >: (lazy (fail "bad")));
          make
            (Single {label="error"; status=Error (TestException0, None)})
            ("error" >: (lazy (Exception.raise TestException0)));
        ]))
      );
    ];
  ]
end
# 358 "General.cppo.ml"
end

module Unit = struct
# 1 "Implementation/Unit.ml"
include Foundations.Unit
# 362 "General.cppo.ml"
end

module Specializations = struct
  module List = struct
# 1 "Specializations/List.ml"
module Int = struct
  include List.Specialize(Int)
  module Equa = List.SpecializeEquatable(Int)
  module Repr = List.SpecializeRepresentable(Int)

  include (Equa: module type of Equa with type t := t)
  include (Repr: module type of Repr with type t := t)
end

module Float = struct
  include List.Specialize(Float)
  module Equa = List.SpecializeEquatable(Float)

  include (Equa: module type of Equa with type t := t)
end

module String = struct
  include List.Specialize(String)
  module Equa = List.SpecializeEquatable(String)

  include (Equa: module type of Equa with type t := t)

  let join = List.join_string_list
end
  
# 367 "General.cppo.ml"
  end

  module Option = struct
# 1 "Specializations/Option.ml"
module Int = struct
  include Option.Specialize(Int)
end

module Float = struct
  include Option.Specialize(Float)
end

module String = struct
  include Option.Specialize(String)
end
  
# 371 "General.cppo.ml"
  end

  module Reference = struct
# 1 "Specializations/Reference.ml"
module Int = struct
  module Spe = Reference.Specialize(Int)
  module Ringoid = Reference.SpecializeRingoid(Int)

  module O = struct
    include Spe.O
    include Ringoid.O
  end

  include (Spe: module type of Spe with module O := O)
  include (Ringoid: module type of Ringoid with type t := t and module O := O)

  let increment = OCSP.incr
  let decrement = OCSP.decr
end

module Float = struct
  module Spe = Reference.Specialize(Float)
  module Ringoid = Reference.SpecializeRingoid(Float)

  module O = struct
    include Spe.O
    include Ringoid.O
  end

  include (Spe: module type of Spe with module O := O)
  include (Ringoid: module type of Ringoid with type t := t and module O := O)
end

module String = struct
  module Spe = Reference.Specialize(String)

  module O = struct
    include Spe.O

    let (=^) r x =
      r := !r ^ x
  end

  include (Spe: module type of Spe with module O := O)
end
  
# 375 "General.cppo.ml"
  end

  module SortedMap = struct
# 1 "Specializations/SortedMap.ml"
module Int = SortedMap.Make(Int)

module Float = SortedMap.Make(Float)

module String = SortedMap.Make(String)

module Char = SortedMap.Make(Char)
  
# 379 "General.cppo.ml"
  end

  module SortedSet = struct
# 1 "Specializations/SortedSet.ml"
module Int = SortedSet.Make(Int)

module Float = SortedSet.Make(Float)

module String = SortedSet.Make(String)

module Char = SortedSet.Make(Char)
  
# 383 "General.cppo.ml"
  end
end

module FloatOption = Specializations.Option.Float
module IntOption = Specializations.Option.Int
module StringOption = Specializations.Option.String

module FloatReference = Specializations.Reference.Float
module IntReference = Specializations.Reference.Int
module StringReference = Specializations.Reference.String

module FloatList = Specializations.List.Float
module IntList = Specializations.List.Int
module StringList = Specializations.List.String

module CharSortedSet = Specializations.SortedSet.Char
module FloatSortedSet = Specializations.SortedSet.Float
module IntSortedSet = Specializations.SortedSet.Int
module StringSortedSet = Specializations.SortedSet.String

module CharSortedMap = Specializations.SortedMap.Char
module FloatSortedMap = Specializations.SortedMap.Float
module IntSortedMap = Specializations.SortedMap.Int
module StringSortedMap = Specializations.SortedMap.String

module Standard = struct
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

  include (
    Ubiquitous: module type of Ubiquitous[@remove_aliases]
    with module Array := Array
    and module Bytes := Bytes
    and module Char := Char
    
# 485 "General.cppo.ml"
    and module Format := Format
    and module Int32 := Int32
    and module Int64 := Int64
    and module Lazy := Lazy
    and module List := List
    and module Stream := Stream
    and module String := String
  )
end

module Abbr = struct
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

  include (
    Ubiquitous: module type of Ubiquitous[@remove_aliases]
    with module Int32 := Int32
    and module Int64 := Int64
  )
end

module Tests = struct
  open Testing

  let test = "General" >:: [
    BigInt.Tests.test;
    BinaryHeap.Tests.test;
    Bool.Tests.test;
    CallStack.Tests.test;
    Exception.Tests.test;
    Float.Tests.test;
    Functions.Tests.test;
    Int.Tests.test;
    Int32.Tests.test;
    Int64.Tests.test;
    Lazy.Tests.test;
    List.Tests.test;
    NativeInt.Tests.test;
    Option.Tests.test;
    RedBlackTree.Tests.test;
    Stream.Tests.test;
    String.Tests.test;
    Tuples.Tests.test;

    IntRange.Tests.test;

    TestingTests.Tests.test;

    "Syntactic sugar" >:: [
      "Standard" >:: Standard.[
        "array" >:: [
          "get" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 a.(0)));
          "set" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 (Array.get a 0); a.(0) <- 37; check_int ~expected:37 (Array.get a 0)));
        ];
        (* @todo Use check_char *)
        "string" >:: [
          "get" >: (let a: string = "a" in lazy (Char.(check ~repr ~equal ~expected:'a' a.[0])));
          
# 608 "General.cppo.ml"
          (* @todo Fix that test in node.js *)
          (* "set" >: (let a: string = "a" in lazy (Char.(check ~repr ~equal ~expected:'a' (String.get a 0)); a.[0] <- 'z'; Char.(check ~repr ~equal ~expected:'z' (String.get a 0)))); *)
        
# 611 "General.cppo.ml"
        ];
        "bytes" >:: [
          "set" >: (let a: bytes = Bytes.of_string "a" in lazy (Char.(check ~repr ~equal ~expected:'a' (Bytes.get a 0)); a.[0] <- 'z'; Char.(check ~repr ~equal ~expected:'z' (Bytes.get a 0))));
        ];
      ];
      "Abbr" >:: Abbr.[
        "array" >:: [
          "get" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 a.(0)));
          "set" >: (let a: int array = [|42|] in lazy (check_int ~expected:42 (Ar.get a 0); a.(0) <- 37; check_int ~expected:37 (Ar.get a 0)));
        ];
        (* @todo Use check_char *)
        "string" >:: [
          "get" >: (let a: string = "a" in lazy (Ch.(check ~repr ~equal ~expected:'a' a.[0])));
          
# 625 "General.cppo.ml"
          (* "set" >: (let a: string = "a" in lazy (Ch.(check ~repr ~equal ~expected:'a' (Str.get a 0)); a.[0] <- 'z'; Ch.(check ~repr ~equal ~expected:'z' (Str.get a 0)))); *)
        
# 627 "General.cppo.ml"
        ];
        "bytes" >:: [
          "set" >: (let a: bytes = By.of_string "a" in lazy (Ch.(check ~repr ~equal ~expected:'a' (By.get a 0)); a.[0] <- 'z'; Ch.(check ~repr ~equal ~expected:'z' (By.get a 0))));
        ];
      ];
    ];
  ]
end
