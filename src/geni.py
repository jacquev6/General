import itertools
import sys
import textwrap


max_arity = 6


def generate(*element, **kwds):
    for line in indent(element, kwds.get("indent", 0)):
        print(line)


def indent(element, levels=1):
    if isinstance(element, str):
        yield f"{'  ' * levels}{element}"
    else:
        for sub in element:
            yield from indent(sub, levels)


class Facets:
    def __init__(self, *, prefix, name, variadic, inherited, base_values, extensions, examples_implementation, tests, has_tests, gen_tests, examples, test_requirements):
        self.prefix = prefix
        self.name = name
        self.inherited = list(inherited)
        self.max_arity = min(itertools.chain([max_arity], (i.max_arity for i in self.inherited))) if variadic else 1
        self.arities = list(range(self.max_arity))
        self.base_values = list(base_values)
        self.extensions = list(extensions)
        self.all_items = list(itertools.chain(
            self.base_values,
            itertools.chain.from_iterable(extension.members for extension in self.extensions),
        ))
        self.operators = [item for item in self.all_items if item.operator is not None]
        # @todo Implement tests using a sub object
        self.examples_implementation = examples_implementation
        self.tests = tests
        self.has_tests = has_tests
        self.gen_tests = gen_tests
        self.examples = list(examples)
        self.test_requirements = list(test_requirements)

    @property
    def specification(self):
        return mod_spec(self.name, self.specification_items)

    @property
    def specification_items(self):
        if self.__has_operators():
            yield self.__operators_signature()
        if self.__is_basic():
            yield self.__basic_signatures()
        else:
            yield mod_spec("Basic", self.__basic_signatures())
            yield self.__extended_signatures()
        yield self.__extensions_makers_signatures()
        if self.gen_tests:
            yield self.__test_signatures()

    def __has_operators(self):
        return len(self.operators) > 0 or any(base.__has_operators() for base in self.inherited)

    def __operators_signature(self):
        return mod_spec("Operators",
            self.__operators_s0_signature(),
            self.__operators_makers_signatures() if len(self.operators) > 0 else [],
        )

    def __operators_s0_signature(self):
        return mod_type("S0", self.__operators_signature_items())

    def __operators_signature_items(self):
        yield "type t"
        for base in self.inherited:
            if base.__has_operators():
                yield f"include {base.__contextualized_name(self.prefix)}.Operators.S0 with type t := t"
        for operator in self.operators:
            yield operator.make_signature(self.base_values, 0, operator=True)

    def __operators_makers_signatures(self):
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield indent(operator.make_signature(self.base_values, 0))
        yield "end): sig"
        for operator in self.operators:
            yield indent(operator.make_signature(self.base_values, 0, operator=True, t="M.t"))
        yield "end"

    def __is_basic(self):
        return len(list(itertools.chain.from_iterable(extension.members for extension in self.extensions))) == 0

    def __basic_signatures(self):
        for arity in self.arities:
            yield mod_type(f"S{arity}", self.__basic_signature_items(arity))

    def __basic_signature_items(self, arity):
        t = f"{type_params(arity)}t"
        yield f"type {t}"
        # @todo Homogenize
        if arity == 0 and self.__has_operators() and self.prefix == "Concepts":
            yield "module O: Operators.S0 with type t := t"
        for base in self.inherited:
            if arity == 0 and base.__has_operators():
                operators_constraint = " and module O := O"
            else:
                operators_constraint = ""
            yield f"include {base.__contextualized_name(self.prefix)}.S{arity} with type {t} := {t}{operators_constraint}"
        for value in self.base_values:
            # @todo (?) Remove arity parameter, always pass t
            yield value.make_signature(self.base_values, arity, t=t)

    def __extended_signatures(self):
        for arity in self.arities:
            yield f"module type S{arity} = sig"
            yield f"  include Basic.S{arity}"
            for extension in self.extensions:
                for item in extension.members:
                    yield indent(item.make_signature(self.base_values, arity))
            if arity == 0:
                yield "  module O: Operators.S0 with type t := t"
            yield "end"

    def __extensions_makers_signatures(self):
        for extension in self.extensions:
            if len(extension.requirements) != 0:
                yield f"module {extension.name}: sig"
                for arity in self.arities:
                    yield f"  module Make{arity}(M: sig"
                    yield f"    type {type_params(arity)}t"
                    for req in extension.requirements:
                        if isinstance(req, str):
                            for item in self.all_items:
                                if item.name == req:
                                    yield indent(item.make_signature(self.base_values, arity), levels=2)
                        else:
                            yield indent(req.make_signature(self.base_values, arity), levels=2)
                    yield "  end): sig"
                    for item in extension.members:
                        yield indent(item.make_signature(self.base_values, arity, t=f"{type_params(arity)}M.t"), levels=2)
                    for prod in extension.basic_production:
                        for item in self.all_items:
                            if item.name == prod:
                                yield indent(item.make_signature(self.base_values, arity, t=f"{type_params(arity)}M.t"), levels=2)
                    yield "  end"
                yield "end"

    def __test_signatures(self):
        yield "module Tests: sig"
        yield "  module Examples: sig"
        if self.max_arity > 1:
            yield "    module type Element = sig"
            yield "      type t"
            yield "      include S0 with type t := t"
            yield "    end"
        for arity in self.arities:
            yield f"    module type S{arity} = sig"
            yield f"      type {type_params(arity)}t"
            for a in abcd(arity):
                yield f"      module {a.upper()}: Element"
            for item in self.examples:
                yield indent(item.make_signature(self.base_values, 0, t=f"{type_args(arity)}t"), levels=3)
            yield "    end"
        yield "  end"
        for arity in self.arities:
            if len(self.test_requirements) == 0:
                yield f"  module Make{arity}(M: S{arity})(E: Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}M.t): sig"
            else:
                yield f"  module Make{arity}(M: sig"
                yield "    include S0"
                for req in self.test_requirements:
                    yield f"    include {req.name}.S0 with type t := t"
                yield f"  end)(E: Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}M.t): sig"
            yield "     val test: Test.t"
            yield "  end"
        yield "end"

    @property
    def implementation(self):
        return mod_impl(self.name, self.implementation_items)

    @property
    def implementation_items(self):
        # @todo Homogenize
        if self.prefix == "Concepts":
            if self.__has_operators():
                yield self.__operators_implementation()
            yield self.__basic_signatures()
            if self.has_tests:
                yield self.__test_module_items()
        else:
            if self.__is_basic():
                yield self.__basic_module_items()
            else:
                yield self.__operators_implementation()
                yield "module Basic = struct"
                yield indent(self.__basic_module_items())
                yield "end"
                yield self.__extended_module_items()

    def __operators_implementation(self):
        return mod_impl("Operators", self.__operators_module_items())

    def __test_module_items(self):
        yield "module Tests = struct"
        yield "  open Testing"
        yield "  module Examples = struct"
        if self.max_arity > 1:
            yield "    module type Element = sig"
            yield "      type t"
            for base in self.inherited:
                if base.has_tests:
                    yield f"      include {base.__contextualized_name(self.prefix)}.Tests.Examples.Element with type t := t"
            yield "    end"
        for arity in self.arities:
            yield f"    module type S{arity} = sig"
            yield f"      type {type_params(arity)}t"
            for a in abcd(arity):
                yield f"      module {a.upper()}: Element"
            for base in self.inherited:
                if base.has_tests:
                    yield (
                        f"      include {base.__contextualized_name(self.prefix)}.Tests.Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}t"
                        + "".join(f" and module {a.upper()} := {a.upper()}" for a in abcd(arity))
                    )
            yield "    end"
        yield "  end"
        for arity in self.arities:
            yield f"  module Make{arity}(M: S{arity})(E: Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}M.t) = struct"
            if self.examples_implementation is not None:
                yield "    module E = struct"
                yield "      include E"
                yield indent(textwrap.dedent(self.examples_implementation).splitlines(), levels=3)
                yield "    end"
            yield f'    let test = "{self.name}" >:: ['
            for base in self.inherited:
                if base.has_tests:
                    yield f"      (let module T = {base.__contextualized_name(self.prefix)}.Tests.Make{arity}(M)(E) in T.test);"
            if self.tests is not None:
                yield "    ] @ ("
                yield from indent(textwrap.dedent(self.tests).splitlines(), levels=3)
                yield "    )"
            else:
                yield "    ]"
            yield "  end"
        yield "end"

    def __basic_module_items(self):
        yield self.__basic_signatures()
        for arity in range(1, self.max_arity):
            functor_params = "".join(f"({a.upper()}: S0)" for a in abcd(arity))
            yield f"module Specialize{arity}(M: S{arity}){functor_params}: S0 with type t = {type_args(arity)}M.t = struct"
            yield f"  type t = {type_args(arity)}M.t"
            for v in self.base_values:
                yield indent(v.make_specialization(self.base_values, arity))
            yield "end"

    def __operators_module_items(self):
        yield self.__operators_s0_signature()
        if len(self.operators) > 0:
            yield "module Make0(M: sig"
            yield "  type t"
            for operator in self.operators:
                yield indent(operator.make_signature(self.base_values, 0))
            yield "end) = struct"
            for operator in self.operators:
                yield f"  let ( {operator.operator} ) = M.{operator.name}"
            yield "end"

    def __extended_module_items(self):
        yield self.__extended_signatures()
        for arity in range(1, self.max_arity):
            functor_params = "".join(f"({a.upper()}: Basic.S0)" for a in abcd(arity))
            yield f"module Specialize{arity}(M: S{arity}){functor_params}: S0 with type t = {type_args(arity)}M.t = struct"
            yield "  module Self = struct"
            yield f"    include Basic.Specialize{arity}(M)" + "".join(f"({a.upper()})" for a in abcd(arity))
            for extension in self.extensions:
                for item in extension.members:
                    yield indent(item.make_specialization(self.base_values, arity), levels=2)
            yield "  end"
            yield "  module O = Operators.Make0(Self)"
            yield "  include Self"
            yield "end"

    def __contextualized_name(self, prefix):
        if prefix == self.prefix:
            return self.name
        else:
            return f"{self.prefix}.{self.name}"


def mod_spec(name, *items):
    yield f"module {name}: sig"
    yield indent(items)
    yield "end"


def mod_impl(name, *items):
    yield f"module {name} = struct"
    yield indent(items)
    yield "end"


def mod_type(name, *items):
    yield f"module type {name} = sig"
    yield indent(items)
    yield "end"


class Extension:
    def __init__(self, name, members, requirements=[], basic_production=[]):
        self.name = name
        self.members = list(members)
        self.requirements = list(requirements)
        self.basic_production = list(basic_production)


class VariadicType:
    def make_type(self, arity, t):
        if t is None:
            return f"{type_params(arity)}t"
        else:
            return t

    def make_pattern(self, index):
        return "xyzuvw"[index]


variadic_type = VariadicType()


class FixedType:
    def __init__(self, name):
        self.name = name

    def make_type(self, *_):
        return self.name

    def make_pattern(self, index):
        return "xyzuvw"[index]


class Named:
    def __init__(self, name, type_):
        self.name = name
        self.type = type_

    def make_type(self, arity, t):
        return f"{self.name}:({self.type.make_type(arity, t)})"

    def make_pattern(self, _index):
        return f"~{self.name}"


class CustomReturn:
    def __init__(self, return_):
        self.return_ = return_

    def make_type(self, arity, t):
        return self.return_(arity, t)


class VariadicFunction:
    def __init__(self, name, params, delegate, return_, operator):
        self.name = name
        self.params = params
        self.delegate = delegate
        self.return_ = return_
        self.operator = operator
    
    def make_signature(self, basics, arity, operator=False, t=None):
        if operator:
            name = f"( {self.operator} )"
        else:
            name = self.name
        return f"val {name}: " + " -> ".join(itertools.chain(
            (p.make_type(arity, t) for p in self.params),
            (f"{self.delegate}_{a}:({self.__make_delegate_type(basics, a)})" for a in abcd(arity)),
            [self.return_.make_type(arity, t)],
        ))

    def __make_delegate_type(self, basics, a):
        for basic in basics:
            if basic.name == self.delegate:
                return " -> ".join(itertools.chain(
                    (f"'{a}" for _ in basic.params),
                    [basic.return_.make_type(0)],
                ))
        print(f"Unknown delegate {self.delegate} for {self.name}", file=sys.stderr)

    def make_specialization(self, basics, arity):
        yield f"let {self.name} " + " ".join(itertools.chain(
            (p.make_pattern(i) for (i, p) in enumerate(self.params)),
        )) + " ="
        yield f"  M.{self.name} " + " ".join(itertools.chain(
            (p.make_pattern(i) for (i, p) in enumerate(self.params)),
            (f"~{self.delegate}_{a}:{a.upper()}.{self.delegate}" for a in abcd(arity))
        ))


def val(name, *, params, delegate=None, return_, operator=None):
    params = [
        FixedType(param) if isinstance(param, str) else param
        for param in params
    ]
    if callable(return_):
        return_ = CustomReturn(return_)
    elif isinstance(return_, str):
        return_ = FixedType(return_)
    if delegate is None:
        delegate = name
    return VariadicFunction(name, params, delegate, return_, operator)


def named(name, type_):
    if isinstance(type_, str):
        type_ = FixedType(type_)
    return Named(name, type_)


def type_params(arity):
    if arity == 0:
        return ""
    elif arity == 1:
        return "'a "
    else:
        return "({}) ".format(', '.join(f"'{a}" for a in abcd(arity)))


def type_args(arity):
    if arity == 0:
        return ""
    elif arity == 1:
        return "A.t "
    else:
        return "({}) ".format(', '.join(f"{a.upper()}.t" for a in abcd(arity)))


def abcd(arity):
    return list("abcdefghijkl"[:arity])


traits = []

def trait(name, *, variadic, basics, extensions=[], has_tests=True, examples=[], gen_tests=False, test_requirements=[]):
    trait = Facets(
        prefix="Traits",
        name=name,
        variadic=variadic,
        inherited=[],
        base_values=basics,
        extensions=extensions,
        examples_implementation=None,
        tests=None,
        has_tests=has_tests,
        gen_tests=gen_tests,
        examples=examples,
        test_requirements=test_requirements,
    )
    traits.append(trait)
    return trait

# @todo (?) Add trait Testable with val test: Test.t

representable = trait(
    "Representable",
    variadic=True,
    basics=[
        val("repr", params=[variadic_type], return_="string"),
    ],
    gen_tests=True,
    examples=[
        val("repr", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * string) list"),
    ]
)

displayable = trait(
    "Displayable",
    variadic=False,
    basics=[
        val("to_string", params=[variadic_type], return_="string"),
    ],
    gen_tests=True,
    examples=[
        val("to_string", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * string) list"),
    ]
)

equatable = trait(
    "Equatable",
    variadic=True,
    basics=[
        val("equal", params=[variadic_type, variadic_type], return_="bool", operator="="),
    ],
    extensions=[
        Extension(
            "Different",
            [val("different", params=[variadic_type, variadic_type], delegate="equal", return_="bool", operator="<>")],
            requirements=["equal"],
        )
    ],
)

parsable = trait(
    "Parsable",
    variadic=False,
    basics=[
        val("try_of_string", params=["string"], return_="t option"),
        val("of_string", params=["string"], return_="t"),
    ],
    gen_tests=True,
    examples=[
        val("of_string", params=[], return_=lambda *args: f"(string * {variadic_type.make_type(*args)}) list"),
    ],
    test_requirements=[equatable, representable],
)

comparable = trait(
    "Comparable",
    variadic=True,
    basics=[
        val(
            "compare",
            params=[variadic_type, variadic_type],
            return_="Compare.t",
        )
    ],
    extensions=[
        Extension(
            "GreaterLessThan",
            [
                val(name, params=[variadic_type, variadic_type], delegate="compare", return_="bool", operator=operator)
                for (name, operator) in [("less_than", "<"), ("less_or_equal", "<="), ("greater_than", ">"), ("greater_or_equal", ">=")]
            ],
            requirements=["compare"],
        ),
        Extension(
            "Between",
            [
                val(name, params=[variadic_type, named("low", variadic_type), named("high", variadic_type)], delegate="compare", return_="bool")
                for name in ["between", "between_or_equal"]
            ],
            requirements=["less_than", "less_or_equal", "greater_than", "greater_or_equal"],
        ),
        Extension(
            "MinMax",
            [
                val("min", params=[variadic_type, variadic_type], delegate="compare", return_=variadic_type),
                val("max", params=[variadic_type, variadic_type], delegate="compare", return_=variadic_type),
                val("min_max", params=[variadic_type, variadic_type], delegate="compare", return_=lambda *args: f"{variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}"),
            ],
            requirements=["compare"],
        ),
    ],
)

ringoid = trait(
    "Ringoid",
    variadic=False,
    basics=itertools.chain(
        (val(name, params=[], return_=variadic_type) for name in ["zero", "one"]),
        [
            # val("posate", params=[variadic_type], return_=variadic_type, operator="~+"),
            val("negate", params=[variadic_type], return_=variadic_type, operator="~-"),
        ],
        (
            val(name, params=[variadic_type, variadic_type], return_=variadic_type, operator=operator)
            for (name, operator) in [("add", "+"), ("substract", "-"), ("multiply", "*"), ("divide", "/")]
        ),
    ),
    extensions=[
        Extension("Substract", [], requirements=["negate", "add"], basic_production=["substract"]),
        Extension("Square", [val("square", params=[variadic_type], return_=variadic_type)], requirements=["multiply"]),
        Extension(
            "Exponentiate",
            [val("exponentiate", params=[variadic_type, "int"], return_=variadic_type, operator="**")],
            requirements=["one", "square", "multiply", val("exponentiate_negative_exponent", params=[named("exponentiate", "t -> int -> t"), variadic_type, "int"], return_=variadic_type)],
        ),
    ],
)

of_standard_numbers = trait(
    "OfStandardNumbers",
    variadic=False,
    basics=[
        val("of_int", params=["int"], return_=variadic_type),
        val("of_float", params=["float"], return_=variadic_type),
    ],
    has_tests=False,
)

to_standard_numbers = trait(
    "ToStandardNumbers",
    variadic=False,
    basics=[
        val("to_int", params=[variadic_type], return_="int"),
        val("to_float", params=[variadic_type], return_="float"),
    ],
    has_tests=False,
)

pred_succ = trait(
    "PredSucc",
    variadic=False,
    basics=[
        val("pred", params=[variadic_type], return_=variadic_type),
        val("succ", params=[variadic_type], return_=variadic_type),
    ],
    extensions=[
        Extension(
            "PredSucc",
            [],
            requirements=[
                val("one", params=[], return_=variadic_type),
                val("add", params=[variadic_type, variadic_type], return_=variadic_type),
                val("substract", params=[variadic_type, variadic_type], return_=variadic_type),
            ],
            basic_production=["pred", "succ"],
        ),
    ],
)


concepts = []

def concept(name, *, inherited, basics=[], examples=None, tests=None):
    concept = Facets(
        prefix="Concepts",
        name=name,
        variadic=True,
        inherited=inherited,
        base_values=basics,
        extensions=[],
        examples_implementation=examples,
        tests=tests,
        has_tests=True,
        gen_tests=False,
        examples=[],
        test_requirements=[],
    )
    concepts.append(concept)
    return concept


identifiable = concept(
    "Identifiable",
    inherited=[equatable, representable],
)

able = concept(
    "Able",
    inherited=[identifiable, comparable],
)

number = concept(
    "Number",
    inherited=[displayable, equatable, parsable, representable, ringoid, of_standard_numbers],
    examples="""\
        let equal = equal @ [
            [M.zero; M.of_int 0; M.of_float 0.; M.of_string "0"];
            [M.one; M.of_int 1; M.of_float 1.; M.of_string "1"];
        ]
        let different = different @ [
            (M.zero, M.one);
        ]
    """,
)

real_number = concept(
    "RealNumber",
    # @feature sign
    inherited=[number, comparable, to_standard_numbers],
    basics=[
        val("abs", params=[variadic_type], return_=variadic_type),
        val("modulo", params=[variadic_type, variadic_type], return_=variadic_type, operator="mod"),
    ],
    examples="""\
        let ordered = ordered @ [
            [M.zero; M.one];
        ]
    """,
    tests="""\
        (
            E.negate
            |> List.flat_map ~f:(fun (x, y) ->
                let abs_x = M.(if greater_or_equal x zero then x else y)
                and abs_y = M.(if greater_or_equal y zero then y else x) in
                [
                    ~: "abs %s" (M.repr x) (lazy M.(check ~repr ~equal ~expected:abs_x (abs x)));
                    ~: "abs %s" (M.repr y) (lazy M.(check ~repr ~equal ~expected:abs_y (abs y)));
                ]
            )
        ) @ [
            "to_int zero" >: (lazy (check_int ~expected:0 M.(to_int zero)));
            "to_float zero" >: (lazy (check_float_exact ~expected:0. M.(to_float zero)));
            "to_int one" >: (lazy (check_int ~expected:1 M.(to_int one)));
            "to_float one" >: (lazy (check_float_exact ~expected:1. M.(to_float one)));
        ]
    """,
)

integer = concept(
    "Integer",
    # @feature Bitwise?
    # @feature gcd, lcm, quomod
    inherited=[real_number, pred_succ],
    examples="""\
        let succ = succ @ [
            (M.zero, M.one);
        ]
    """,
)


if __name__ == "__main__":
    if sys.argv[1] == "specification":
        generate(
            mod_spec("Traits", (trait.specification for trait in traits)),
            mod_spec("Concepts", (concept.specification for concept in concepts)),
        )
    else:
        assert sys.argv[1] == "implementation"
        generate(
            mod_impl("Traits", (trait.implementation for trait in traits)),
            mod_impl("Concepts", (concept.implementation for concept in concepts)),
        )
