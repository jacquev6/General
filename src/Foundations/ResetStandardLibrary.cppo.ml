#if OCAML_VERSION >= (4, 3, 0)
  #define HAS_Ephemeron
  #define HAS_Uchar
#endif

#if OCAML_VERSION >= (4, 4, 0)
  #define HAS_Spacetime
#endif

module OCamlStandard = struct
  #define ALIAS(m) module m = m

  (* https://caml.inria.fr/pub/docs/manual-ocaml/core.html *)
  ALIAS(Pervasives)

  (* https://caml.inria.fr/pub/docs/manual-ocaml/stdlib.html *)
  ALIAS(Arg)
  ALIAS(Array)
  ALIAS(ArrayLabels)
  ALIAS(Buffer)
  ALIAS(Bytes)
  ALIAS(Callback)
  ALIAS(Char)
  ALIAS(Complex)
  ALIAS(Digest)
  #ifdef HAS_Ephemeron
  ALIAS(Ephemeron)
  #endif
  ALIAS(Filename)
  ALIAS(Format)
  ALIAS(Gc)
  ALIAS(Genlex)
  ALIAS(Hashtbl)
  ALIAS(Int32)
  ALIAS(Int64)
  ALIAS(Lazy)
  ALIAS(Lexing)
  ALIAS(List)
  ALIAS(ListLabels)
  ALIAS(Map)
  ALIAS(Marshal)
  ALIAS(MoreLabels)
  ALIAS(Nativeint)
  ALIAS(Oo)
  ALIAS(Parsing)
  ALIAS(Printexc)
  ALIAS(Printf)
  ALIAS(Queue)
  ALIAS(Random)
  ALIAS(Scanf)
  ALIAS(Set)
  #ifdef HAS_Spacetime
  ALIAS(Spacetime)
  #endif
  ALIAS(Stack)
  ALIAS(StdLabels)
  ALIAS(Stream)
  ALIAS(String)
  ALIAS(StringLabels)
  ALIAS(Sys)
  #ifdef HAS_Uchar
  ALIAS(Uchar)
  #endif
  ALIAS(Weak)

  (* https://caml.inria.fr/pub/docs/manual-ocaml/libunix.html *)

  (* https://caml.inria.fr/pub/docs/manual-ocaml/libnum.html *)
  ALIAS(Num)
  ALIAS(Big_int)
  ALIAS(Arith_status)

  (* https://caml.inria.fr/pub/docs/manual-ocaml/libstr.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml/libthreads.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml/libgraph.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml/libdynlink.html *)
  (* https://caml.inria.fr/pub/docs/manual-ocaml/libbigarray.html *)
end

#define EMPTY(m) module m = struct end

EMPTY(Pervasives)

EMPTY(Arg)
module Array = struct
  let get = OCamlStandard.Array.get
end
EMPTY(ArrayLabels)
EMPTY(Buffer)
EMPTY(Bytes)
EMPTY(Callback)
EMPTY(Char)
EMPTY(Complex)
EMPTY(Digest)
#ifdef HAS_Ephemeron
EMPTY(Ephemeron)
#endif
EMPTY(Filename)
EMPTY(Format)
EMPTY(Gc)
EMPTY(Genlex)
EMPTY(Hashtbl)
EMPTY(Int32)
EMPTY(Int64)
EMPTY(Lazy)
EMPTY(Lexing)
EMPTY(List)
EMPTY(ListLabels)
EMPTY(Map)
EMPTY(Marshal)
EMPTY(MoreLabels)
EMPTY(Nativeint)
EMPTY(Oo)
EMPTY(Parsing)
EMPTY(Printexc)
EMPTY(Printf)
EMPTY(Queue)
EMPTY(Random)
EMPTY(Scanf)
EMPTY(Set)
#ifdef HAS_Spacetime
EMPTY(Spacetime)
#endif
EMPTY(Stack)
EMPTY(StdLabels)
EMPTY(Stream)
module String = struct
  let get = OCamlStandard.String.get
end
EMPTY(StringLabels)
EMPTY(Sys)
#ifdef HAS_Uchar
EMPTY(Uchar)
#endif
EMPTY(Weak)

EMPTY(Num)
EMPTY(Big_int)
EMPTY(Arith_status)
