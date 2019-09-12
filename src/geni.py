import itertools
import os
import sys
import textwrap


max_arity = 6


def generate(*element, **kwds):
    for line in indent(element, kwds.get("indent", 0)):
        print(line, file=kwds.get("file"))


def indent(element, levels=1):
    if isinstance(element, str):
        yield f"{'  ' * levels}{element}"
    else:
        for sub in element:
            yield from indent(sub, levels)


class Facets:
    def __init__(
            self, *,
            prefix, name,
            variadic,
            inherited, base_values, extensions,
            publish_tests, generate_tests, examples, test_requirements,
        ):
        self.prefix = prefix
        self.name = name
        self.inherited = list(inherited)
        self.max_arity = min(itertools.chain([max_arity], (i.max_arity for i in self.inherited))) if variadic else 1
        self.arities = list(range(self.max_arity))
        self.non_zero_arities = list(range(1, self.max_arity))
        self.base_values = list(base_values)
        self.extensions = list(extensions)
        self.all_items = list(itertools.chain(
            self.base_values,
            itertools.chain.from_iterable(extension.members for extension in self.extensions),
        ))
        self.operators = [item for item in self.all_items if item.operator is not None]
        self.publish_tests = publish_tests
        self.generate_tests = generate_tests
        self.examples = list(examples)
        self.test_requirements = list(test_requirements)

    @property
    def graphviz_label(self):
        parts = [self.name]
        if len(self.base_values) > 0:
            parts.append("")
            parts += [val.name for val in self.base_values]
        exts = [val.name for extension in self.extensions for val in extension.members]
        if len(exts) > 0:
            parts.append("")
            parts += exts
        return "\\n".join(parts)

    @property
    def specification(self):
        return mod_spec(self.name, self.specification_items)

    @property
    def implementation(self):
        return mod_impl(self.name, self.implementation_items)

    @property
    def specification_items(self):
        if self.__has_operators():
            yield self.__operators_specification()

        if self.__is_basic():
            yield self.__basic_specification_items()
        else:
            yield self.__extended_specification_items()

        yield self.__extension_makers_specification_items()

        if self.publish_tests:
            yield self.__tests_specification()

    @property
    def implementation_items(self):
        if self.__has_operators():
            yield self.__operators_implementation()

        if self.__is_basic():
            yield self.__basic_implementation_items()
        else:
            yield self.__extended_implementation_items()

        # @todo Generate extension makers: yield self.__extensions_makers_implementation_items()

        if self.publish_tests:
            yield self.__tests_implementation()

    def __contextualized_name(self, prefix):
        if prefix == self.prefix:
            return self.name
        else:
            return f"{self.prefix}.{self.name}"

    # Operators

    def __has_operators(self):
        return self.__has_own_operators() or self.__inherits_operators()

    def __has_own_operators(self):
        return len(self.operators) > 0

    def __inherits_operators(self):
        return any(base.__has_operators() for base in self.inherited)

    def __operators_specification(self):
        return mod_spec("Operators", self.__operators_specification_items())

    def __operators_implementation(self):
        return mod_impl("Operators", self.__operators_implementation_items())

    def __operators_specification_items(self):
        yield self.__operators_s0_mod_type()
        if len(self.operators) > 0:
            yield self.__operators_make0_specification()

    def __operators_implementation_items(self):
        yield self.__operators_s0_mod_type()
        if len(self.operators) > 0:
            yield self.__operators_make0_implementation()

    def __operators_s0_mod_type(self):
        return mod_type("S0", self.__operators_s0_mod_type_items())

    def __operators_s0_mod_type_items(self):
        yield "type t"
        for base in self.inherited:
            if base.__has_operators():
                yield f"include {base.__contextualized_name(self.prefix)}.Operators.S0 with type t := t"
        for operator in self.operators:
            yield operator.make_signature(self.base_values, 0, operator=True)

    def __operators_make0_specification(self):
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield indent(operator.make_signature(self.base_values, 0))
        yield "end): sig"
        for operator in self.operators:
            yield indent(operator.make_signature(self.base_values, 0, operator=True, t="M.t"))
        yield "end"

    def __operators_make0_implementation(self):
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield indent(operator.make_signature(self.base_values, 0))
        yield "end) = struct"
        for operator in self.operators:
            yield f"  let ( {operator.operator} ) = M.{operator.name}"
        yield "end"

    # Core contents: basic

    def __is_basic(self):
        return len(list(itertools.chain.from_iterable(extension.members for extension in self.extensions))) == 0

    def __basic_specification_items(self):
        yield self.__basic_signature_mod_types()
        yield self.__basic_specialize_specifications()

    def __basic_implementation_items(self):
        yield self.__basic_signature_mod_types()
        yield self.__basic_specialize_implementations()

    def __basic_signature_mod_types(self):
        for arity in self.arities:
            yield mod_type(f"S{arity}", self.__basic_signature_mod_type_items(arity))

    def __basic_signature_mod_type_items(self, arity):
        t = f"{type_params(arity)}t"
        yield f"type {t}"
        if arity == 0 and self.__has_operators() and self.__is_basic():
            yield "module O: Operators.S0 with type t := t"
        for base in self.inherited:
            if arity == 0 and base.__has_operators():
                operators_constraint = " and module O := O"
            else:
                operators_constraint = ""
            yield f"include {base.__contextualized_name(self.prefix)}.S{arity} with type {t} := {t}{operators_constraint}"
        for value in self.base_values:
            yield value.make_signature(self.base_values, arity, t=t)

    def __basic_specialize_specifications(self):
        for arity in self.non_zero_arities:
            functor_params = "".join(f"({a.upper()}: S0)" for a in abcd(arity))
            yield mod_spec(f"Specialize{arity}(M: S{arity}){functor_params}", self.__specialize_specification_items(arity))

    def __basic_specialize_implementations(self):
        for arity in self.non_zero_arities:
            functor_params = "".join(f"({a.upper()}: S0)" for a in abcd(arity))
            yield mod_impl(f"Specialize{arity}(M: S{arity}){functor_params}", self.__basic_specialize_implementation_items(arity))

    def __specialize_specification_items(self, arity):
        yield f"type t = {type_args(arity)}M.t",
        yield "include S0 with type t := t",

    def __basic_specialize_implementation_items(self, arity):
        yield f"type t = {type_args(arity)}M.t"
        functor_args = "".join(f"({a.upper()})" for a in abcd(arity))
        for base in self.inherited:
            yield f"module {base.name}_ = {base.__contextualized_name(self.prefix)}.Specialize{arity}(M){functor_args}"
        if self.__inherits_operators():
            yield mod_impl("O", (f"include {base.name}_.O" for base in self.inherited if base.__has_operators()))
        for base in self.inherited:
            if base.__has_operators():
                operators_constraint = " and module O := O"
            else:
                operators_constraint = ""
            yield f"include ({base.name}_: {base.__contextualized_name(self.prefix)}.S0 with type t := t{operators_constraint})"
        for v in self.base_values:
            yield v.make_specialization(self.base_values, arity)

    # Core contents: extended

    def __extended_specification_items(self):
        yield mod_spec("Basic", self.__basic_specification_items())
        yield self.__extended_signature_mod_types()
        yield self.__extended_specialize_specifications()

    def __extended_implementation_items(self):
        yield mod_impl("Basic", self.__basic_implementation_items())
        yield self.__extended_signature_mod_types()
        yield self.__extended_specialize_implementations()

    def __extended_signature_mod_types(self):
        for arity in self.arities:
            yield mod_type(f"S{arity}", self.__extended_signature_mod_type_items(arity))

    def __extended_signature_mod_type_items(self, arity):
        yield f"include Basic.S{arity}"
        if arity == 0:
            yield "module O: Operators.S0 with type t := t"
        for extension in self.extensions:
            for item in extension.members:
                yield item.make_signature(self.base_values, arity)

    def __extended_specialize_specifications(self):
        for arity in self.non_zero_arities:
            functor_params = "".join(f"({a.upper()}: Basic.S0)" for a in abcd(arity))
            yield mod_spec(f"Specialize{arity}(M: S{arity}){functor_params}", self.__specialize_specification_items(arity))

    def __extended_specialize_implementations(self):
        for arity in self.non_zero_arities:
            functor_params = "".join(f"({a.upper()}: Basic.S0)" for a in abcd(arity))
            yield mod_impl(f"Specialize{arity}(M: S{arity}){functor_params}", self.__extended_specialize_implementation_items(arity))

    def __extended_specialize_implementation_items(self, arity):
        functor_args = "".join(f"({a.upper()})" for a in abcd(arity))
        yield mod_impl("Self",
            f"include Basic.Specialize{arity}(M){functor_args}",
            (item.make_specialization(self.base_values, arity) for extension in self.extensions for item in extension.members)
        )
        yield "module O = Operators.Make0(Self)"
        yield "include Self"

    # Extension makers

    def __extension_makers_specification_items(self):
        for extension in self.extensions:
            yield mod_spec(extension.name, (self.__extension_maker_specification(extension, arity) for arity in self.arities))
                
    def __extension_maker_specification(self, extension, arity):
        yield f"module Make{arity}(M: sig"
        yield f"  type {type_params(arity)}t"
        for req in extension.requirements:
            # @todo Take this decision when constructing the req object
            if isinstance(req, str):
                for item in self.all_items:
                    if item.name == req:  # @todo Resolve this search when constructing the object
                        yield indent(item.make_signature(self.base_values, arity))
                        break
            else:
                yield indent(req.make_signature(self.base_values, arity))
        yield "end): sig"
        for item in extension.members:
            yield indent(item.make_signature(self.base_values, arity, t=f"{type_params(arity)}M.t"))
        for prod in extension.basic_production:
            for item in self.base_values:
                if item.name == prod:  # @todo Resolve this search when constructing the object
                    yield indent(item.make_signature(self.base_values, arity, t=f"{type_params(arity)}M.t"))
                    break
        yield "end"

    # Tests

    def __tests_specification(self):
        yield mod_spec("Tests", self.__tests_specification_items())

    def __tests_implementation(self):
        yield mod_impl("Tests_", self.__tests_implementation_items())

    def __tests_specification_items(self):
        yield self.__tests_examples_specification()
        yield mod_spec("Testable", self.__tests_testable_mod_types())
        yield self.__tests_makers_specifications()

    def __tests_implementation_items(self):
        yield self.__tests_examples_implementation()
        yield mod_impl("Testable", self.__tests_testable_mod_types())
        if self.generate_tests:
            yield self.__tests_makers_implementations()

    def __tests_examples_specification(self):
        yield mod_spec("Examples", self.__tests_examples_items())

    def __tests_examples_implementation(self):
        yield mod_impl("Examples", self.__tests_examples_items())

    def __tests_examples_items(self):
        if self.max_arity > 1:
            yield mod_type("Element", self.__tests_examples_element_mod_type_items())
        for arity in self.arities:
            yield mod_type(f"S{arity}", self.__tests_examples_mod_type_items(arity))

    def __tests_examples_element_mod_type_items(self):
        yield "type t"
        basic = "" if self.__is_basic() else "Basic."
        yield f"include {basic}S0 with type t := t"
        for req in self.test_requirements:
            basic = "" if req.__is_basic() else "Basic."
            yield f"include {req.name}.{basic}S0 with type t := t"

    def __tests_examples_mod_type_items(self, arity):
        yield f"type {type_params(arity)}t"
        for a in abcd(arity):
            yield f"module {a.upper()}: Element"
        for base in self.inherited:
            if base.publish_tests:
                yield (
                    f"include {base.__contextualized_name(self.prefix)}.Tests.Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}t"
                    + "".join(f" and module {a.upper()} := {a.upper()}" for a in abcd(arity))
                )
        for item in self.examples:
            yield item.make_signature(self.base_values, 0, t=f"{type_args(arity)}t")

    def __tests_testable_mod_types(self):
        for arity in self.arities:
            yield mod_type(f"S{arity}", self.__tests_testable_mod_types_items(arity))

    def __tests_testable_mod_types_items(self, arity):
            yield f"include S{arity}"
            for req in self.test_requirements:
                basic = "" if req.__is_basic() else "Basic."
                yield f"include {req.__contextualized_name(self.prefix)}.{basic}S{arity} with type {type_params(arity)}t := {type_params(arity)}t"

    def __tests_makers_specifications(self):
        for arity in self.arities:
            yield mod_spec(
                f"Make{arity}(M: Testable.S{arity})(E: Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}M.t)",
                "val test: Test.t",
            )

    def __tests_makers_implementations(self):
        yield mod_impl(
            "MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end)",
            self.__tests_makers_implementations_items(),
        )

    def __tests_makers_implementations_items(self):
        yield mod_impl(
            "Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t)",
            self.__tests_make0_implementation_items(),
        )
        for arity in self.non_zero_arities:
            yield mod_impl(
                f"Make{arity}(M: Testable.S{arity})(E: Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}M.t)",
                self.__tests_maker_implementation_items(arity),
            )

    def __tests_make0_implementation_items(self):
        yield "open Testing"
        yield "module E = MakeExamples(M)(E)"
        yield f'let test = "{self.name}" >:: ['
        for base in self.inherited:
            if base.publish_tests:  # @todo Ensure all traits do publish tests, then remove this condition
                yield f"  (let module T = {base.__contextualized_name(self.prefix)}.Tests.Make0(M)(E) in T.test);"
        yield "] @ (let module T = MakeTests(M)(E) in T.tests)"

    def __tests_maker_implementation_items(self, arity):
        yield "include Make0(struct",
        functor_args = "".join(f"(E.{a.upper()})" for a in abcd(arity))
        yield indent(f"include Specialize{arity}(M){functor_args}"),
        for req in self.test_requirements:
            basic = "" if req.__is_basic() else "Basic."
            yield indent(f"include ({req.__contextualized_name(self.prefix)}.{basic}Specialize{arity}(M){functor_args}: {req.__contextualized_name(self.prefix)}.{basic}S0 with type t := t)")
        yield "end)(E)",


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

def trait(name, *, variadic=True, basics, extensions=[], has_tests=True, examples=[], test_requirements=[]):
    trait = Facets(
        prefix="Traits",
        name=name,
        variadic=variadic,
        inherited=[],
        base_values=basics,
        extensions=extensions,
        publish_tests=has_tests,
        generate_tests=has_tests,
        examples=examples,
        test_requirements=test_requirements,
    )
    traits.append(trait)
    return trait

# @todo (?) Add trait Testable with val test: Test.t

representable = trait(
    "Representable",
    basics=[
        val("repr", params=[variadic_type], return_="string"),
    ],
    examples=[
        val("repr", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * string) list"),
    ],
)

equatable = trait(
    "Equatable",
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
    examples=[
        val("equal", params=[], return_=lambda *args: f"{variadic_type.make_type(*args)} list list"),
        val("different", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}) list"),
    ],
    test_requirements=[representable],
)

displayable = trait(
    "Displayable",
    variadic=False,
    basics=[
        val("to_string", params=[variadic_type], return_="string"),
    ],
    examples=[
        val("to_string", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * string) list"),
    ],
)

parsable = trait(
    "Parsable",
    variadic=False,
    basics=[
        val("try_of_string", params=["string"], return_="t option"),
        val("of_string", params=["string"], return_="t"),
    ],
    examples=[
        val("of_string", params=[], return_=lambda *args: f"(string * {variadic_type.make_type(*args)}) list"),
    ],
    test_requirements=[equatable, representable],
)

comparable = trait(
    "Comparable",
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
    examples=[
        val("ordered", params=[], return_=lambda *args: f"{variadic_type.make_type(*args)} list list"),
        val("equal", params=[], return_=lambda *args: f"{variadic_type.make_type(*args)} list list"),
    ],
    test_requirements=[equatable, representable],
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
    examples=[
        val("add_substract", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * {variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}) list"),
        val("negate", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}) list"),
        val("multiply", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * {variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}) list"),
        val("divide", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * {variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}) list"),
        val("exponentiate", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * int * {variadic_type.make_type(*args)}) list"),
    ],
    test_requirements=[equatable, representable],
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
    examples=[
        val("succ", params=[], return_=lambda *args: f"({variadic_type.make_type(*args)} * {variadic_type.make_type(*args)}) list"),
    ],
    test_requirements=[equatable, representable],
)


concepts = []

def concept(name, *, inherited, basics=[], generate_tests=True, test_requirements=[]):
    concept = Facets(
        prefix="Concepts",
        name=name,
        variadic=True,
        inherited=inherited,
        base_values=basics,
        extensions=[],
        publish_tests=True,
        generate_tests=generate_tests,
        examples=[],
        test_requirements=test_requirements,
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

stringable = concept(
    "Stringable",
    inherited=[displayable, parsable],
    test_requirements=[representable, equatable],
)

number = concept(
    "Number",
    inherited=[identifiable, stringable, ringoid, of_standard_numbers],
)

real_number = concept(
    "RealNumber",
    # @feature sign
    inherited=[number, comparable, to_standard_numbers],
    basics=[
        val("abs", params=[variadic_type], return_=variadic_type),
        val("modulo", params=[variadic_type, variadic_type], return_=variadic_type, operator="mod"),
    ],
)

integer = concept(
    "Integer",
    # @feature Bitwise?
    # @feature gcd, lcm, quomod
    inherited=[real_number, pred_succ],
)


if __name__ == "__main__":
    destination = sys.argv[1]
    assert os.path.isdir(destination)

    def gen(name, *items):
        with open(os.path.join(destination, name), "w") as f:
            generate(items, file = f)

    gen(
        "Facets.dot",
        'digraph {',
        '  rankdir="BT"',
        '  node [shape="box"]',
        '  subgraph cluster_Traits {',
        '    label="Traits";',
        (f'    {trait.name.lower()} [label="{trait.graphviz_label}"];' for trait in traits),
        '  }',
        '  subgraph cluster_Concepts {',
        '    label="Concepts";',
        (f'    {concept.name.lower()} [label="{concept.graphviz_label}"];' for concept in concepts),
        '  }',
        (f'  {concept.name.lower()} -> {base.name.lower()}' for concept in concepts for base in concept.inherited),
        '}',
    )

    gen("Traits.mli", (trait.specification for trait in traits))
    gen("Concepts.mli", (concept.specification for concept in concepts))

    destination = os.path.join(sys.argv[1], "Traits")
    os.mkdir(destination)

    for trait in traits:
        gen(f"{trait.name}.ml", trait.implementation_items)

    destination = os.path.join(sys.argv[1], "Concepts")
    os.mkdir(destination)

    for concept in concepts:
        gen(f"{concept.name}.ml", concept.implementation_items)
