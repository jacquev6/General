#if OCAML_VERSION >= (4, 7, 0)
#define ALIAS_STDLIB_MODULE(m) module m = Stdlib.m
#else
#define ALIAS_STDLIB_MODULE(m) module m = m
#endif

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/core.html *)
#if OCAML_VERSION >= (4, 8, 0)
module Pervasives = Stdlib
#else
ALIAS_STDLIB_MODULE(Pervasives)
#endif

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libref/Stdlib.html *)
ALIAS_STDLIB_MODULE(Arg)
ALIAS_STDLIB_MODULE(Array)
ALIAS_STDLIB_MODULE(ArrayLabels)
#if OCAML_VERSION >= (4, 7, 0)
ALIAS_STDLIB_MODULE(Bigarray)
#endif
#if OCAML_VERSION >= (4, 8, 0)
ALIAS_STDLIB_MODULE(Bool)
#endif
ALIAS_STDLIB_MODULE(Buffer)
ALIAS_STDLIB_MODULE(Bytes)
ALIAS_STDLIB_MODULE(BytesLabels)
ALIAS_STDLIB_MODULE(Callback)
ALIAS_STDLIB_MODULE(Char)
ALIAS_STDLIB_MODULE(Complex)
ALIAS_STDLIB_MODULE(Digest)
#if OCAML_VERSION >= (4, 3, 0)
ALIAS_STDLIB_MODULE(Ephemeron)
#endif
ALIAS_STDLIB_MODULE(Filename)
#if OCAML_VERSION >= (4, 7, 0)
ALIAS_STDLIB_MODULE(Float)
#endif
ALIAS_STDLIB_MODULE(Format)
#if OCAML_VERSION >= (4, 8, 0)
ALIAS_STDLIB_MODULE(Fun)
#endif
ALIAS_STDLIB_MODULE(Gc)
ALIAS_STDLIB_MODULE(Genlex)
ALIAS_STDLIB_MODULE(Hashtbl)
#if OCAML_VERSION >= (4, 8, 0)
ALIAS_STDLIB_MODULE(Int)
#endif
ALIAS_STDLIB_MODULE(Int32)
ALIAS_STDLIB_MODULE(Int64)
ALIAS_STDLIB_MODULE(Lazy)
ALIAS_STDLIB_MODULE(Lexing)
ALIAS_STDLIB_MODULE(List)
ALIAS_STDLIB_MODULE(ListLabels)
ALIAS_STDLIB_MODULE(Map)
ALIAS_STDLIB_MODULE(Marshal)
ALIAS_STDLIB_MODULE(MoreLabels)
ALIAS_STDLIB_MODULE(Nativeint)
ALIAS_STDLIB_MODULE(Obj)
ALIAS_STDLIB_MODULE(Oo)
#if OCAML_VERSION >= (4, 8, 0)
ALIAS_STDLIB_MODULE(Option)
#endif
ALIAS_STDLIB_MODULE(Parsing)
ALIAS_STDLIB_MODULE(Printexc)
ALIAS_STDLIB_MODULE(Printf)
ALIAS_STDLIB_MODULE(Queue)
ALIAS_STDLIB_MODULE(Random)
#if OCAML_VERSION >= (4, 8, 0)
ALIAS_STDLIB_MODULE(Result)
#endif
ALIAS_STDLIB_MODULE(Scanf)
#if OCAML_VERSION >= (4, 7, 0)
ALIAS_STDLIB_MODULE(Seq)
#endif
ALIAS_STDLIB_MODULE(Set)
#if OCAML_VERSION < (4, 8, 0)
ALIAS_STDLIB_MODULE(Sort)
#endif
#if OCAML_VERSION >= (4, 4, 0)
ALIAS_STDLIB_MODULE(Spacetime)
#endif
ALIAS_STDLIB_MODULE(Stack)
ALIAS_STDLIB_MODULE(StdLabels)
ALIAS_STDLIB_MODULE(Stream)
ALIAS_STDLIB_MODULE(String)
ALIAS_STDLIB_MODULE(StringLabels)
ALIAS_STDLIB_MODULE(Sys)
#if OCAML_VERSION >= (4, 3, 0)
ALIAS_STDLIB_MODULE(Uchar)
#endif
#if OCAML_VERSION >= (4, 8, 0)
ALIAS_STDLIB_MODULE(Unit)
#endif
ALIAS_STDLIB_MODULE(Weak)

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/parsing.html *)

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libunix.html *)

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libnum.html *)
(* @todo Remove these 3 aliases; Hide Big_int from our interface
(i.e. Make BigInt.t opaque, to be able implement with https://github.com/ocaml/Zarith
as suggested in https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libnum.html) *)
module Num = Num
module Big_int = Big_int
module Arith_status = Arith_status

(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libstr.html *)
(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libthreads.html *)
(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libgraph.html *)
(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libdynlink.html *)
(* https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libbigarray.html *)

#undef ALIAS_STDLIB_MODULE
