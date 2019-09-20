#if SIGNATURE = 1
  #define RESET_MODULE(m) module m: sig
  #define EMPTY_MODULE(m) module m: sig end
  #define ALIAS_VALUE(name, t, v) val name: t
#else
  #define RESET_MODULE(m) module m = struct
  #define EMPTY_MODULE(m) module m = struct end
  #define ALIAS_VALUE(name, t, v) let name = v
#endif

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libref/Stdlib.html *)

EMPTY_MODULE(Pervasives)

EMPTY_MODULE(Arg)
#if SIGNATURE = 0 || ABBREVIATED = 1
RESET_MODULE(Array)
  ALIAS_VALUE(get, 'a array -> int -> 'a, OCamlStandard.Array.get)
  ALIAS_VALUE(set, 'a array -> int -> 'a -> unit, OCamlStandard.Array.set)
end
#endif
EMPTY_MODULE(ArrayLabels)
EMPTY_MODULE(Bigarray)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Bool)
#endif
EMPTY_MODULE(Buffer)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Bytes)
#endif
EMPTY_MODULE(BytesLabels)
EMPTY_MODULE(Callback)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Char)
#endif
EMPTY_MODULE(Complex)
EMPTY_MODULE(Digest)
EMPTY_MODULE(Ephemeron)
EMPTY_MODULE(Filename)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Float)
EMPTY_MODULE(Format)
#endif
EMPTY_MODULE(Fun)
EMPTY_MODULE(Gc)
EMPTY_MODULE(Genlex)
EMPTY_MODULE(Hashtbl)
(* EMPTY_MODULE(Int) *)
(* EMPTY_MODULE(Int32) *)
(* EMPTY_MODULE(Int64) *)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Lazy)
#endif
EMPTY_MODULE(Lexing)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(List)
#endif
EMPTY_MODULE(ListLabels)
EMPTY_MODULE(Map)
EMPTY_MODULE(Marshal)
EMPTY_MODULE(MoreLabels)
EMPTY_MODULE(Nativeint)
EMPTY_MODULE(Obj)
EMPTY_MODULE(Oo)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Option)
#endif
EMPTY_MODULE(Parsing)
EMPTY_MODULE(Printexc)
EMPTY_MODULE(Printf)
EMPTY_MODULE(Queue)
EMPTY_MODULE(Result)
EMPTY_MODULE(Random)
EMPTY_MODULE(Scanf)
EMPTY_MODULE(Seq)
EMPTY_MODULE(Set)
EMPTY_MODULE(Sort)
EMPTY_MODULE(Spacetime)
EMPTY_MODULE(Stack)
EMPTY_MODULE(StdLabels)
#if SIGNATURE = 0 || ABBREVIATED = 1
EMPTY_MODULE(Stream)
RESET_MODULE(String)
  ALIAS_VALUE(get, string -> int -> char, OCamlStandard.String.get)
  ALIAS_VALUE(set, bytes -> int -> char -> unit, OCamlStandard.Bytes.set)
end
#endif
EMPTY_MODULE(StringLabels)
EMPTY_MODULE(Sys)
EMPTY_MODULE(Uchar)
(* EMPTY_MODULE(Unit) *)
EMPTY_MODULE(Weak)

EMPTY_MODULE(Num)
EMPTY_MODULE(Big_int)
EMPTY_MODULE(Arith_status)

#undef RESET_MODULE
#undef EMPTY_MODULE
#undef ALIAS_VALUE
