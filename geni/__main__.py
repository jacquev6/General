import glob
import itertools
import os
import shutil
import subprocess
import textwrap

from .facets import Facet, Type, OCamlException, Value, UnlabelledParameter, LabelledParameter, DelegateParameter, Extension, variadic_type_marker as t, abcd, max_arity, generate, indent

vals = {}

def val(name, *type_chain):
    def make_param(param):
        if isinstance(param, str):
            return UnlabelledParameter(param)
        elif isinstance(param, dict):
            [(label, type_)] = param.items()
            return LabelledParameter(label, type_)
        elif isinstance(param, tuple):
            if param[0] is DelegateParameter:
                return DelegateParameter(vals, param[1])
            else:
                assert False  # pragma nocover
        else:
            assert False  # pragma nocover

    value = Value(
        name=name,
        type_chain=(make_param(param) for param in type_chain),
    )
    if name not in vals:
        vals[name] = value
    return value


def ext(name, *, members, requirements):
    def make_requirement(req):
        if isinstance(req, str):
            return vals[req]
        elif isinstance(req, Value):
            return req
        else:
            assert False  # pragma nocover

    members = list(members)

    return Extension(
        name=name,
        members=(member for member in members if isinstance(member, Value)),
        requirements=(make_requirement(requirement) for requirement in requirements),
        basic_production=(vals[member] for member in members if isinstance(member, str)),
    )


def deleg(name):
    return (DelegateParameter, name)


def exception(name, *arguments):
    return OCamlException(name, arguments)


facets = []

def facet(
        name,
        *,
        variadic=True,
        submodule=None,
        bases=[],
        values=[],
        operators={},
        extensions=[],
        specializes_from=None,
        test_examples=[],
        test_requirements=[],
):
    facet = Facet(
        prefix="Facets",
        name=name,
        variadic=variadic,
        submodule=submodule,
        bases=bases,
        values=values,
        operators={name: vals[value] for (name, value) in operators.items()},
        extensions=extensions,
        specializes_from=specializes_from,
        test_examples=test_examples,
        test_requirements=test_requirements,
    )
    facets.append(facet)
    return facet


atoms = []

def atom(
    name,
    *,
    type,
    arity=0,
    bases=[],
    exceptions=[],
    operators=[],
    values=[],
    types=[],
    type_params=None,
):
    atom = Type(
        prefix="Atoms",
        name=name,
        type_params=type_params,
        type=type,
        arity=arity,
        bases=bases,
        exceptions=exceptions,
        operators=operators,
        values=values,
        types=types,
        specializers=[],
    )
    atoms.append(atom)
    return atom


wrappers = []

def wrapper(
    name,
    *,
    type_params,
    type,
    arity=1,
    bases,
    operators=[],
    values,
    specializers=[],
):
    wrapper = Type(
        prefix="Wrappers",
        name=name,
        type_params=type_params,
        type=type,
        arity=arity,
        bases=bases,
        operators=operators,
        values=values,
        types=[],
        exceptions=[],
        specializers=specializers,
    )
    wrappers.append(wrapper)
    return wrapper


def make_unit_tests():
    types = set()
    values = set()
    with open("src/Reset/ResetPervasives.ml") as f:
        for line in f:
            if line.startswith("RESET_TYPE"):
                type_ = "General." + line.split(",")[-1].strip()[:-1].replace("__", ".")
                if "'" in line:
                    type_ = f"_ {type_}"
                types.add(type_)
            if line.startswith("RESET_VALUE"):
                values.add("General." + line.split(",")[1].strip()[:-1].replace("__", "."))
    types.discard("General.todo")
    types.discard("_ General.todo")
    values.discard("General.todo")
    for type_ in sorted(types):
        yield f"let (_: {type_} option) = None"
    for value in sorted(values):
        yield f"let _ = {value}"
    # yield ""
    # yield "open General.Abbr"
    # yield ""
    # yield "let () ="
    # yield "  let argv = Li.of_array OCamlStandard.Sys.argv in"
    # yield "  Exit.exit (Tst.command_line_main ~argv General.Tests.test)"


def make_dune():
    yield "(rule"
    yield "  (targets General.mli)"
    yield "  (deps"
    yield "    (:src General.cppo.mli)"
    for name in sorted(itertools.chain(
        glob.glob("src/OldFashion/Facets/*.signatures*.ml", recursive=False),
        glob.glob("src/Generated/*.mli", recursive=False),
        filter(lambda path: path != "src/Reset/DefinitionHeader.ml", glob.glob("src/Reset/*.ml*", recursive=False)),
    )):
        yield f"    {name[4:]}"
    yield "  )"
    yield "  (action (run %{bin:cppo} -V OCAML:%{ocaml_version} %{src} -o %{targets}))"
    yield ")"
    yield ""
    yield "(rule"
    yield "  (targets General.ml)"
    yield "  (deps"
    yield "    (:src General.cppo.ml)"
    for path in sorted(glob.glob("src/**/*.ml", recursive=True)):
        if path in ["src/Reset/SignatureHeader.ml", "src/General.cppo.ml"]:
            continue
        yield f"    {path[4:]}"
    yield "  )"
    yield "  (action (run %{bin:cppo} -V OCAML:%{ocaml_version} %{src} -o %{targets}))"
    yield ")"
    yield ""
    yield "(library"
    yield "  (name General)"
    yield "  (public_name General)"
    yield "  (modules General)"
    yield "  (libraries num)"
    yield "  (flags (:standard -nopervasives -w @A-4-33-44-45-48))"
    yield ")"


###### FACETS ######

# @feature (?) Add facet Testable with val test: Test.t

# A *representation* is a string representing a value for a software developer audience.
# When possible, it should be a valid OCaml expression for the value.
representable = facet(
    "Representable",
    values=[val("repr", t, deleg("repr"), "string")],
    test_examples=[val("representations", f"({t} * string) list")],
)

equalities = val("equalities", f"{t} list list")

equatable_basic = facet(
    "EquatableBasic",
    values=[val("equal", t, t, deleg("equal"), "bool")],
    test_examples=[
        equalities,
        val("differences", f"({t} * {t}) list"),
    ],
    test_requirements=[representable],
)

equatable = facet(
    "Equatable",
    bases=[equatable_basic],
    values=[
        val("different", t, t, deleg("equal"), "bool"),
    ],
    operators={
        "=": "equal",
        "<>": "different",
    },
    extensions=[
        ext("Different", members=["different"], requirements=["equal"]),
    ],
    specializes_from=equatable_basic,
    test_requirements=[representable],
)

displayable = facet(
    "Displayable",
    variadic=False,
    values=[val("to_string", t, "string")],
    test_examples=[val("displays", f"({t} * string) list")],
)

# @feature Facets.Hashable with val hash: t -> int, Poly using Hashtbl.hash

parsable = facet(
    "Parsable",
    variadic=False,
    values=[
        val("try_of_string", "string", f"{t} option"),
        val("of_string", "string", t),
    ],
    test_examples=[val("literals", f"(string * {t}) list")],
    test_requirements=[equatable_basic, representable],
)

comparable_basic = facet(
    "ComparableBasic",
    values=[val("compare", t, t, deleg("compare"), "Compare.t")],
    test_examples=[
        val("orders", f"{t} list list"),
        equalities,
    ],
    test_requirements=[equatable_basic, representable],
)

comparable = facet(
    "Comparable",
    bases=[comparable_basic],
    values=[
        val("less_than", t, t, deleg("compare"), "bool"),
        val("less_or_equal", t, t, deleg("compare"), "bool"),
        val("greater_than", t, t, deleg("compare"), "bool"),
        val("greater_or_equal", t, t, deleg("compare"), "bool"),
        val("between", t, {"low": t}, {"high": t}, deleg("compare"), "bool"),
        val("between_or_equal", t, {"low": t}, {"high": t}, deleg("compare"), "bool"),
        val("min", t, t, deleg("compare"), t),
        val("max", t, t, deleg("compare"), t),
        val("min_max", t, t, deleg("compare"), f"{t} * {t}"),
    ],
    operators={
        "<": "less_than",
        "<=": "less_or_equal",
        ">": "greater_than",
        ">=": "greater_or_equal",
    },
    extensions=[
        ext(
            "GreaterLessThan",
            members=["less_than", "less_or_equal", "greater_than", "greater_or_equal"],
            requirements=["compare"],
        ),
        ext(
            "Between",
            members=["between", "between_or_equal"],
            requirements=["less_than", "less_or_equal", "greater_than", "greater_or_equal"],
        ),
        ext(
            "MinMax",
            members=["min", "max", "min_max"],
            requirements=["compare"],
        ),
    ],
    specializes_from=comparable_basic,
    test_requirements=[equatable_basic, representable],
)

ringoid_basic = facet(
    "RingoidBasic",
    variadic=False,
    values=[
        val("zero", t),
        val("one", t),
        # val("posate", t, t),
        val("negate", t, t),
        val("add", t, t, t),
        val("subtract", t, t, t),
        val("multiply", t, t, t),
        val("divide", t, t, t),
    ],
    extensions=[
        ext(
            "Subtract",
            members=["subtract"],
            requirements=["negate", "add"],
        ),
    ],
    test_examples=[
        val("additions", f"({t} * {t} * {t}) list"),
        val("negations", f"({t} * {t}) list"),
        val("multiplications", f"({t} * {t} * {t}) list"),
        val("divisions", f"({t} * {t} * {t}) list"),
    ],
    test_requirements=[equatable_basic, representable],
)

ringoid = facet(
    "Ringoid",
    bases=[ringoid_basic],
    values=[
        val("square", t, t),
        val("exponentiate", t, "int", t),
    ],
    operators={
        "~-": "negate",
        "+": "add",
        "-": "subtract",
        "*": "multiply",
        "/": "divide",
        "**": "exponentiate",
    },
    extensions=[
        ext(
            "Square",
            members=["square"],
            requirements=["multiply"],
        ),
        ext(
            "Exponentiate",
            members=["exponentiate"],
            requirements=[
                "one",
                "square",
                "multiply",
                val("exponentiate_negative_exponent", {"exponentiate": f"{t} -> int -> {t}"}, t, "int", t),
            ],
        ),
    ],
    test_examples=[
        val("exponentiations", f"({t} * int * {t}) list"),
    ],
    test_requirements=[equatable_basic, representable],
)

of_int = facet(
    "OfInt",
    variadic=False,
    values=[
        val("of_int", "int", t),
    ],
)

to_int = facet(
    "ToInt",
    variadic=False,
    values=[
        val("to_int", t, "int"),
    ],
)

of_float = facet(
    "OfFloat",
    variadic=False,
    values=[
        val("of_float", "float", t),
    ],
)

to_float = facet(
    "ToFloat",
    variadic=False,
    values=[
        val("to_float", t, "float"),
    ],
)

pred_succ = facet(
    "PredSucc",
    variadic=False,
    values=[
        val("pred", t, t),
        val("succ", t, t),
    ],
    extensions=[
        ext(
            "PredSucc",
            members=["pred", "succ"],
            requirements=["one", "add", "subtract"],
        ),
    ],
    test_examples=[val("successions", f"({t} * {t}) list")],
    test_requirements=[equatable_basic, representable],
)

bounded = facet(
    "Bounded",
    variadic=False,
    values=[
        val("smallest", t),
        val("greatest", t),
    ],
)

bitwise = facet(
    "Bitwise",
    variadic=False,
    submodule="Bitwise",
    values=[
        val("logical_and", t, t, t),
        val("logical_or", t, t, t),
        val("logical_xor", t, t, t),
        val("logical_not", t, t),
        val("logical_shift_left", t, {"shift": "int"}, t),
        val("logical_shift_right", t, {"shift": "int"}, t),
        val("arithmetic_shift_right", t, {"shift": "int"}, t),
    ],
)

# @feature Facets for iterables and collections. Something like Collection, Container, MonoBag, MultiBag, LinearContainer

identifiable = facet(
    "Identifiable",
    bases=[equatable, representable],
)

able = facet(
    "Able",
    bases=[identifiable, comparable],
)

stringable = facet(
    "Stringable",
    bases=[displayable, parsable],
    test_requirements=[representable, equatable_basic],  # @todo Deduce from parsable's test requirements
)

of_standard_numbers = facet(
    "OfStandardNumber",
    bases=[of_int, of_float],
)

number = facet(
    "Number",
    bases=[identifiable, stringable, ringoid, of_standard_numbers],
)

to_standard_numbers = facet(
    "ToStandardNumber",
    bases=[to_int, to_float],
)

real_number = facet(
    "RealNumber",
    # @feature sign
    bases=[number, comparable, to_standard_numbers],
    values=[
        val("abs", t, t),
        val("modulo", t, t, t),
    ],
    operators={
        "mod": "modulo",
    }
)

integer = facet(
    "Integer",
    # @feature Bitwise?
    # @feature gcd, lcm, quomod
    # @feature width: like Sys.int_size
    bases=[real_number, pred_succ],
)

fixed_width_integer = facet(
    "FixedWidthInteger",
    bases=[integer, bounded, bitwise],
    values=[val("width", "int")],
)

###### ATOMIC TYPES ######

call_stack = atom(
    "CallStack",
    type="OCamlStandard.Printexc.raw_backtrace",
    bases=[displayable, representable],
    values=[
        val("current", {"?max_size": "int"}, "unit", t),
        # @feature? val size: t -> int
        # @feature? val frame: t -> int -> Frame.t
        val("frames", t, "Frame.t list"),
    ],
    types=[
        Type(
            prefix="Atoms.CallStack",
            name="Location",
            type_params=None,
            type="OCamlStandard.Printexc.location = {filename: string; line_number: int; start_char: int; end_char: int}",
            arity=0,
            bases=[able],
            exceptions=[],
            operators=[],
            values=[],
            types=[],
            specializers=[],
        ),
        Type(
            prefix="Atoms.CallStack",
            name="Frame",
            type_params=None,
            type="OCamlStandard.Printexc.backtrace_slot",
            arity=0,
            bases=[],
            exceptions=[],
            operators=[],
            values=[
                val("is_raise", t, "bool"),
                # @feature val is_inline: t -> bool
                val("location", t, "Location.t option"),
                val("format", "int", t, "string option"),
            ],
            types=[],
            specializers=[],
        ),
    ],
)

exception = atom(
    "Exception",
    type="exn",
    bases=[identifiable, displayable],
    exceptions=[
        # Aliases for all predefined exceptions
        # https://caml.inria.fr/pub/docs/manual-ocaml-4.09/core.html#sec556
        exception("MatchFailure", "string", "int", "int"),
        exception("AssertFailure", "string", "int", "int"),
        exception("InvalidArgument", "string"),
        exception("Failure", "string"),
        exception("NotFound"),
        exception("OutOfMemory"),
        exception("StackOverflow"),
        exception("SysError", "string"),
        exception("EndOfFile"),
        exception("DivisionByZero"),
        exception("SysBlockedIO"),
        exception("UndefinedRecursiveModule", "string", "int", "int"),

        # Aliases for all exceptions in Pervasives
        # https://caml.inria.fr/pub/docs/manual-ocaml-4.09/libref/Pervasives.html
        exception("Exit"),
    ],
    values=[
        val("register_printer", "(t -> string option) -> unit"),
        val("record_backtraces", "bool -> unit"),
        val("recording_backtraces", "unit -> bool"),
        # There is no way to get the call stack of a specific exception.
        # It's just possible to get the call stack of the most recent exception.
        val("most_recent_backtrace", "unit -> CallStack.t option"),
        val("raise", "t -> 'a"),
        val("raise_without_backtrace", "t -> 'a"),
        val("invalid_argument", "('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a"),
        val("failure", "('a, unit, string, string, string, 'b) CamlinternalFormatBasics.format6 -> 'a"),
        val("failure_if", "bool -> ('a, unit, string, string, string, unit) CamlinternalFormatBasics.format6 -> 'a"),
        val("failure_unless", "bool -> ('a, unit, string, string, string, unit) CamlinternalFormatBasics.format6 -> 'a"),
        val("name", "exn -> string"),
        val("or_none", "'a lazy_t -> 'a option"),
    ]
)

exit_ = atom(
    "Exit",
    type="Success | Failure of int",
    # @feature Able
    values=[
        val("of_int", "int", t),
        val("exit", t, "'a"),
        val("at_exit", "(unit -> unit)", "unit"),
    ],
)

function = [
    atom(
        "Function1",
        arity=2,
        type_params="('a, 'z)",
        type="'a -> 'z",
        operators=[
            val("(@@)", "('a, 'z) t", "'a", "'z"),
            val("(|>)", "'a", "('a, 'z) t", "'z"),
            val("(%)", "('a, 'b) t", "('c, 'a) t", "('c, 'b) t"),

        ],
        values=[
            val("identity", "('a, 'a) t"),
            val("apply", "('a, 'z) t", "'a", "'z"),
            val("rev_apply", "'a", "('a, 'z) t", "'z"),
            val("compose", "('a, 'b) t", "('c, 'a) t", "('c, 'b) t"),
        ],
    )
]

def function_values(arity):
    tuple_ = " * ".join(f"'{a}" for a in abcd(arity))
    params = ", ".join(f"'{a}" for a in abcd(arity))
    rev_params = ", ".join(f"'{a}" for a in reversed(abcd(arity)))
    yield val("flip", f"({params}, 'z) t", f"({rev_params}, 'z) t")
    yield val("curry", f"({tuple_}, 'z) Function1.t", f"({params}, 'z) t")
    yield val("uncurry", f"({params}, 'z) t", f"({tuple_}, 'z) Function1.t")

function += [
    atom(
        f"Function{arity}",
        arity=arity + 1,
        type_params="({})".format(", ".join(f"'{a}" for a in itertools.chain(abcd(arity), ["z"]))),
        type=" -> ".join(f"'{a}" for a in itertools.chain(abcd(arity), ["z"])),
        values=function_values(arity),
    )
    for arity in range(2, max_arity)
]

# @feature Predicate1,2,3,etc. (or BoolFunction1,2,3, more consistent with other specializations) with composition of predicates (not, and, or, xor)

unit = atom(
    "Unit",
    type="unit",
    bases=[able],
    values=[val("ignore", "_", "t")],
)

bool_ = atom(
    "Bool",
    type="bool",
    bases=[able, stringable],
    operators=[
        val("not", t, t),
        val("(&&)", t, t, t),
        val("(||)", t, t, t),
        val("xor", t, t, t),
    ],
    values=[
        val("not", t, t),
        val("and_", t, t, t),
        val("or_", t, t, t),
        val("xor", t, t, t),
    ],
)

char = atom(
    "Char",
    type="char",
    bases=[able, displayable, of_int, to_int],
    # @feature Integer, smallest, greatest
    values=[
        val("repeat", t, {"len": "int"}, "string"),
    ],
)

int_ = atom(
    "Int",
    type="int",
    bases=[fixed_width_integer],
)

int32 = atom(
    "Int32",
    type="OCamlStandard.Int32.t",
    bases=[fixed_width_integer],
)

int64 = atom(
    "Int64",
    type="OCamlStandard.Int64.t",
    bases=[fixed_width_integer],
)

native_int = atom(
    "NativeInt",
    type="OCamlStandard.Nativeint.t",
    bases=[fixed_width_integer],
)

big_int = atom(
    "BigInt",
    type="OCamlStandard.Big_int.big_int",
    bases=[integer],
)

float_ = atom(
    "Float",
    type="float",
    bases=[real_number, bounded],
    values=[
        val("approx_equal", {"?precision": t}, t, t, "bool"),

        val("epsilon", t),
        val("infinity", t),
        val("negative_infinity", t),
        val("not_a_number", t),
        val("pi", t),
        val("e", t),

        val("of_parts", {"significand": t}, {"exponent": "int"}, t),
        val("to_parts", t, "t * int"),
        val("to_fractional_and_integral", t, "t * t"),

        val("sqrt", t, t),

        val("exp", t, t),
        val("log", t, t),
        val("log10", t, t),
        val("expm1", t, t),
        val("log1p", t, t),

        val("cos", t, t),
        val("sin", t, t),
        val("tan", t, t),
        val("acos", t, t),
        val("asin", t, t),
        val("atan", t, t),
        val("atan2", {"y": t}, {"x": t}, t),
        val("hypot", t, t, t),
        val("cosh", t, t),
        val("sinh", t, t),
        val("tanh", t, t),

        val("ceil", t, t),
        val("floor", t, t),
        val("copy_sign", t, {"sign": t}, t),
    ],
    types=[
        Type(
            prefix="Atoms.Float",
            name="Class",
            type_params=None,
            type="Normal | SubNormal | Zero | Infinite | NotANumber",
            arity=0,
            bases=[able],
            exceptions=[],
            operators=[],
            values=[val("of_float", "float", t)],
            types=[],
            specializers=[],
        ),
    ],
)

string = atom(
    "String",
    type="string",
    bases=[able, stringable],
    operators=[val("(^)", t, t, t)],
    values=[
        val("of_char", "char", t),
        val("of_list", "char list", t),
        val("to_list", t, "char list"),

        val("size", t, "int"),
        val("get", t, "int", "char"),
        val("set", "bytes", "int", "char", "unit"),  # @todo (?) Remove (should be only in bytes?)

        val("of_bytes", "bytes", t),
        val("to_bytes", t, "bytes"),

        val("concat", t, t, t),

        #   (* @feature val try_substring: t -> pos:int -> len:int -> t option *)
        val("substring", t, {"pos": "int"}, {"len": "int"}, t),
        #   (* @feature val try_prefix: t -> len:int -> t option *)
        val("prefix", t, {"len": "int"}, t),
        #   (* @feature val try_suffix: t -> len:int -> t option *)
        val("suffix", t, {"len": "int"}, t),

        val("has_prefix", t, {"pre": t}, "bool"),
        val("try_drop_prefix", t, {"pre": t}, "t option"),
        val("drop_prefix", t, {"pre": t}, t),
        val("drop_prefix'", t, {"len": "int"}, t),
        val("has_suffix", t, {"suf": t}, "bool"),
        val("try_drop_suffix", t, {"suf": t}, "t option"),
        val("drop_suffix", t, {"suf": t}, t),
        val("drop_suffix'", t, {"len": "int"}, t),

        val("split", t, {"sep": t}, "t list"),
        val("split'", t, {"seps": "char list"}, "t list"),

        #   (* @feature Facets *)
        val("fold", {"init": "'a"}, t, {"f": "'a -> char -> 'a"}, "'a"),
        val("filter", t, {"f": "char -> bool"}, t),
    ]
)

bytes_ = atom(
    "Bytes",
    type="bytes",
    bases=[able, displayable],
    values=[
        val("size", t, "int"),
        val("of_string", "string", t),  # @todo parsable
        val("get", t, "int", "char"),
        val("set", t, "int", "char", "unit"),
        val("empty", t),
        val("make", {"len": "int"}, t),
    ],
)

###### FIXED-SIZE WRAPPER TYPES ######

option = wrapper(
    "Option",
    type_params="'a",
    type="'a option",
    bases=[able],
    values=[
        val("none", "'a t"),
        val("some", "'a", "'a t"),

        val("some_if", "bool", "'a lazy_t", "'a t"),
        val("some_if'", "bool", "'a", "'a t"),

        val("is_some", "'a t", "bool"),
        val("is_none", "'a t", "bool"),

        val("value_def", "'a t", {"def": "'a"}, "'a"),
        val("value", {"?exc": "exn"}, "'a t", "'a"),
        val("or_failure", "('a, unit, string, string, string, 'b t -> 'b) CamlinternalFormatBasics.format6", "'a"),

        val("map", "'a t", {"f": "'a -> 'b"}, "'b t"),
        val("iter", "'a t", {"f": "'a -> unit"}, "unit"),
        val("filter", "'a t", {"f": "'a -> bool"}, "'a t"),
        val("filter_map", "'a t", {"f": "'a -> 'b option"}, "'b t"),

        val("value_map", "'a t", {"def": "'b"}, {"f": "'a -> 'b"}, "'b"),
    ],
    # @todo Structure generation of specializers
    specializers=[
        textwrap.dedent("""\
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
        """).splitlines(),
    ]
)

lazy = wrapper(
    "Lazy",
    type_params="'a",
    type="'a lazy_t",
    bases=[],
    values=[
        val("is_value", "'a t", "bool"),
        val("value", "'a t", "'a"),
        val("map", "'a t", {"f": "'a -> 'b"}, "'b t"),
    ],
)

reference = wrapper(
    "Reference",
    type_params="'a",
    type="'a OCamlStandard.Pervasives.ref = {mutable contents: 'a}",
    bases=[
        # @feature able
    ],
    values=[
        val("of_contents", "'a", "'a t"),
        val("contents", "'a t", "'a"),
        val("assign", "'a t", "'a", "unit"),
    ],
    operators=[
        val("ref", "'a", "'a t"),
        val("(!)", "'a t", "'a"),
        val("(:=)", "'a t", "'a", "unit"),
    ],
    specializers=[
        textwrap.dedent("""\
            module SpecializeOperators(A: sig type t end): sig
              type nonrec t = A.t t
              val ref: A.t -> t
              val (!): t -> A.t
              val (:=): t -> A.t -> unit
            end
        """).splitlines(),
        textwrap.dedent("""\
            module Specialize(A: sig type t end): sig
              type nonrec t = A.t t
              val of_contents: A.t -> t
              val contents: t -> A.t
              val assign: t -> A.t -> unit
              module O: module type of SpecializeOperators(A) with type t := t
            end
        """).splitlines(),
        # @feature SpecializeComparable
        # @feature SpecializeEquatable
        # @feature SpecializeRepresentable
        # @feature SpecializeAble (merge of three previous)
        textwrap.dedent("""\
            module SpecializePredSucc(A: Facets.PredSucc.S0): sig
              type nonrec t = A.t t
              val increment: t -> unit
              val decrement: t -> unit
            end
        """).splitlines(),
        textwrap.dedent("""\
            module SpecializeRingoidOperators(A: Facets.RingoidBasic.S0): sig
              type nonrec t = A.t t
              val (=+): t -> A.t -> unit
              val (=-): t -> A.t -> unit
              val (=*): t -> A.t -> unit
              val (=/): t -> A.t -> unit
            end
        """).splitlines(),
        textwrap.dedent("""\
            module SpecializeRingoid(A: Facets.RingoidBasic.S0): sig
              type nonrec t = A.t t
              module O: module type of SpecializeRingoidOperators(A) with type t := t
            end
        """).splitlines(),
    ],
)

tuple_ = [
    wrapper(
        f"Tuple{arity}",
        arity=arity,
        type_params="({})".format(", ".join(f"'{a}" for a in abcd(arity))),
        type=" * ".join(f"'{a}" for a in abcd(arity)),
        bases=[able],
        values=itertools.chain(
            [val("make", *(f"'{a}" for a in abcd(arity)), "({}) t".format(", ".join(f"'{a}" for a in abcd(arity))))],
            (
                val(f"get_{n}", "({}) t".format(", ".join(f"'{a}" for a in abcd(arity))), f"'{abcd(n + 1)[-1]}")
                for n in range(arity)
            ),
            [val("flip", "({}) t".format(", ".join(f"'{a}" for a in abcd(arity))), "({}) t".format(", ".join(f"'{a}" for a in reversed(abcd(arity)))))]
        ),
    )
    for arity in range(2, max_arity)
]

def main():
    def gen(path, *items):
        if os.sep in path:
            os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w") as f:
            generate(items, file=f)

    all_items = (facets, atoms, wrappers)

    gen(
        "doc/Facets.dot",
        'digraph {',
        '  compound=true',
        '  rankdir="BT"',
        '  node [shape="box"]',
        (
            (
                f'  subgraph cluster_{items[0].prefix} {{',
                f'    label="{items[0].prefix}"',
                f'    labelloc="b"',
                indent((item.graphviz_node for item in items), levels=2),
                '  }',
            )
            for items in all_items
        ),
        indent(item.graphviz_links for item in itertools.chain.from_iterable(all_items)),
        '}',
    )

    subprocess.run(["dot", "doc/Facets.dot", "-Tpng", "-odocs/Facets.png"], check=True)

    shutil.rmtree("src/Generated", ignore_errors=True)

    for items in all_items:
        gen(f"src/Generated/{items[0].prefix}.mli", (item.specification for item in items))
        for item in items:
            path = f"src/{item.prefix}/{item.name}.ml"
            if os.path.exists(path):
                with open(path) as f:
                    first_line = f.readlines()[0]
                assert first_line == f'#include "../Generated/{item.prefix}/{item.name}.ml"\n', (path, first_line)
            else:  # pragma nocover
                with open(path, "w") as f:
                    f.write(f'#include "../Generated/{item.prefix}/{item.name}.ml"\n\n#include "empty_{item.prefix[:-1].lower()}.ml"\n')

    for item in itertools.chain.from_iterable(all_items):
        gen(f"src/Generated/{item.prefix}/{item.name}.ml", item.implementation_items)
        if hasattr(item, "types"):
            for subtype in item.types:
                gen(f"src/Generated/{item.prefix}/{subtype.prefix.split('.')[1]}/{subtype.name}.ml", subtype.implementation_items)

    gen("src/Generated/Facets_alpha.ml", (
        (
            f"module {facet.name} = struct",
            f'  #include "../Facets/{facet.name}.ml"',
            "end",
        )
        for facet in facets
    ))

    gen("src/Generated/Facets.ml", (
        (
            f"module {facet.name} = struct",
            f'  include Facets_alpha.{facet.name}',
            "  module Tests = Tests_beta(Testing)",
            "end",
        )
        for facet in facets
    ))

    gen("unit_tests.ml", make_unit_tests())

    gen("src/dune", make_dune())

main()
