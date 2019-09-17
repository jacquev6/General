import contextlib
import functools
import itertools
import os
import sys
import textwrap


max_arity = 6


def generate(*element, **kwds):
    p = functools.partial(print, file=kwds.get("file"))
    previous_line_was_end = False
    for line in indent(element, kwds.get("indent", 0)):
        line_is_end = line.strip() == "end"
        if previous_line_was_end and not line_is_end:
            p("")
        p(line)
        previous_line_was_end = line_is_end


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
            bases, values, extensions,
            test_examples, test_requirements,
        ):
        self.prefix = prefix
        self.name = name
        self.bases = list(bases)
        self.max_arity = min(itertools.chain([max_arity], (i.max_arity for i in self.bases))) if variadic else 1
        self.arities = list(range(self.max_arity))
        self.non_zero_arities = list(range(1, self.max_arity))
        self.values = list(values)
        self.extensions = list(extensions)
        self.all_items = list(itertools.chain(
            self.values,
            itertools.chain.from_iterable(extension.members for extension in self.extensions),
        ))
        self.operators = [item for item in self.all_items if item.operator is not None]
        self.test_examples = list(test_examples)
        self.test_requirements = list(test_requirements)

    @property
    def graphviz_label(self):
        parts = [self.name]
        if len(self.values) > 0:
            parts.append("")
            parts += [val.name for val in self.values]
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

        yield self.__tests_specification()

    @property
    def implementation_items(self):
        if self.__has_operators():
            yield self.__operators_implementation()

        if self.__is_basic():
            yield self.__basic_implementation_items()
        else:
            yield self.__extended_implementation_items()

        yield self.__extensions_makers_implementation_items()

        yield self.__tests_implementation()

    def contextualized_name(self, prefix):
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
        return any(base.__has_operators() for base in self.bases)

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
        for base in self.bases:
            if base.__has_operators():
                yield f"include {base.contextualized_name(self.prefix)}.Operators.S0 with type t := t"
        for operator in self.operators:
            yield f"val ( {operator.operator} ): { operator.value_type(0, 't')}"

    def __operators_make0_specification(self):
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield f"  val {operator.name}: {operator.value_type(0, 't')}"
        yield "end): sig"
        for operator in self.operators:
            yield f"  val ( {operator.operator} ): {operator.value_type(0, 'M.t')}"
        yield "end"

    def __operators_make0_implementation(self):
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield f"  val {operator.name}: {operator.value_type(0, f'{type_params(0)}t')}"
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
        for base in self.bases:
            if arity == 0 and base.__has_operators():
                operators_constraint = " and module O := O"
            else:
                operators_constraint = ""
            yield f"include {base.contextualized_name(self.prefix)}.S{arity} with type {t} := {t}{operators_constraint}"
        for value in self.values:
            yield f"val {value.name}: {value.value_type(arity, t)}"

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
        for base in self.bases:
            yield f"module {base.name}_ = {base.contextualized_name(self.prefix)}.Specialize{arity}(M){functor_args}"
        if self.__inherits_operators():
            yield mod_impl("O", (f"include {base.name}_.O" for base in self.bases if base.__has_operators()))
        for base in self.bases:
            if base.__has_operators():
                operators_constraint = " and module O := O"
            else:
                operators_constraint = ""
            yield f"include ({base.name}_: {base.contextualized_name(self.prefix)}.S0 with type t := t{operators_constraint})"
        for value in self.values:
            yield value.value_specialization(arity)

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
            for value in extension.members:
                yield f"val {value.name}: {value.value_type(arity, f'{type_params(arity)}t')}"

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
            (value.value_specialization(arity) for extension in self.extensions for value in extension.members)
        )
        yield "module O = Operators.Make0(Self)"
        yield "include Self"

    # Extension makers

    def __extension_makers_specification_items(self):
        for extension in self.extensions:
            yield mod_spec(extension.name, extension.extension_makers_specification(self.arities))

    def __extensions_makers_implementation_items(self):
        for extension in self.extensions:
            yield mod_impl(f"{extension.name}_", extension.extension_makers_implementation(self.arities))

    # Tests

    def __tests_specification(self):
        yield mod_spec("Tests", self.__tests_specification_items())

    def __tests_implementation(self):
        yield mod_impl("Tests_", self.__tests_implementation_items())

    def __tests_specification_items(self):
        yield self.__tests_examples_specification()
        yield mod_spec("Testable", self.__tests_testable_items())
        yield self.__tests_makers_specifications()

    def __tests_implementation_items(self):
        yield self.__tests_examples_implementation()
        yield mod_impl("Testable", self.__tests_testable_items())
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
        for base in self.bases:
            yield (
                f"include {base.contextualized_name(self.prefix)}.Tests.Examples.S{arity} with type {type_params(arity)}t := {type_params(arity)}t"
                + "".join(f" and module {a.upper()} := {a.upper()}" for a in abcd(arity))
            )
        t = f"{type_args(arity)}t"
        for item in self.test_examples:
            yield f"val {item.name}: {item.value_type(0, t)}"

    def __tests_testable_items(self):
        for arity in self.arities:
            yield mod_type(f"S{arity}", self.__tests_testable_mod_type_items(arity))

    def __tests_testable_mod_type_items(self, arity):
            yield f"include S{arity}"
            for req in self.test_requirements:
                basic = "" if req.__is_basic() else "Basic."
                yield f"include {req.contextualized_name(self.prefix)}.{basic}S{arity} with type {type_params(arity)}t := {type_params(arity)}t"

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
        for base in self.bases:
            yield f"  (let module T = {base.contextualized_name(self.prefix)}.Tests.Make0(M)(E) in T.test);"
        yield "] @ (let module T = MakeTests(M)(E) in T.tests)"

    def __tests_maker_implementation_items(self, arity):
        yield "include Make0(struct",
        functor_args = "".join(f"(E.{a.upper()})" for a in abcd(arity))
        yield indent(f"include Specialize{arity}(M){functor_args}"),
        for req in self.test_requirements:
            basic = "" if req.__is_basic() else "Basic."
            yield indent(f"include ({req.contextualized_name(self.prefix)}.{basic}Specialize{arity}(M){functor_args}: {req.contextualized_name(self.prefix)}.{basic}S0 with type t := t)")
        yield "end)(E)",


class Type:
    def __init__(
            self, *,
            prefix, name,
            type,
            arity,
            bases,
    ):
        self.prefix = prefix
        self.name = name
        self.type = type
        self.arity = arity
        self.bases = list(bases)

    @property
    def graphviz_label(self):
        return self.name

    @property
    def specification_items(self):
        yield f"type t = {self.type}"

    @property
    def implementation_items(self):
        yield mod_impl("Tests_", self.__tests_implementation_items())

    def __tests_implementation_items(self):
        yield mod_type("Examples",
            (f"include {base.contextualized_name(self.prefix)}.Tests.Examples.S{self.arity} with type t := {self.type}" for base in self.bases),
        )
        yield mod_type("Testable",
            f"type t = {self.type}",
            (f"include {base.contextualized_name(self.prefix)}.Tests.Testable.S{self.arity} with type t := t" for base in self.bases),
        )
        yield mod_impl("Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end)",
            "open Testing",
            f'let test = "{self.name}" >:: [',
            indent(f"(let module T = {base.contextualized_name(self.prefix)}.Tests.Make{self.arity}(M)(E) in T.test);" for base in self.bases),
            "] @ Tests.tests",
        )


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


class Extension:
    def __init__(self, *, name, members, requirements, basic_production):
        self.__name = name
        self.__members = list(members)
        self.__requirements = list(requirements)
        self.__basic_production = list(basic_production)

    @property
    def name(self):
        return self.__name

    @property
    def members(self):
        return list(self.__members)

    def extension_makers_specification(self, arities):
        for arity in arities:
            yield f"module Make{arity}(M: sig"
            yield f"  type {type_params(arity)}t"
            for requirement in self.__requirements:
                yield f"  val {requirement.name}: {requirement.value_type(arity, f'{type_params(arity)}t')}"
            yield "end): sig"
            for value in itertools.chain(self.members, self.__basic_production):
                yield f"  val {value.name}: {value.value_type(arity, f'{type_params(arity)}M.t')}"
            yield "end"

    def extension_makers_implementation(self, arities):
        yield "module MakeMakers(Implementation: sig"
        additional_prefix_params = ""
        for requirement in self.__requirements:
            additional_prefix_params += LabelledParameter(requirement.name, requirement.value_type(0, "'a")).param_type(0, "t") + " -> "
        t = "'a"
        for value in itertools.chain(self.members, self.__basic_production):
            yield f"  val {value.name}: {additional_prefix_params}{value.value_type(0, t)}"
        yield "end) = struct"
        for arity in arities:
            yield f"  module Make{arity}(M: sig"
            yield f"    type {type_params(arity)}t"
            requirement_names = []
            for requirement in self.__requirements:
                yield f"    val {requirement.name}: {requirement.value_type(arity, f'{type_params(arity)}t')}"
                requirement_names.append(requirement.name)
            yield "  end) = struct"
            for value in itertools.chain(self.members, self.__basic_production):
                yield indent(value.value_extension(requirement_names, arity), levels=2)
            yield "  end"
        yield "end"


variadic_type_marker = "THIS_VARIADIC_TYPE_MARKER_SHOULD_NEVER_APPEAR_IN_GENERATED_CODE"


class UnlabelledParameter:
    def __init__(self, type_):
        self.__type = type_

    def param_type(self, _arity, t):
        return self.__type.replace(variadic_type_marker, t)

    def param_pattern(self, _arity, index):
        return "xyzuvw"[index]

    param_specialization = param_pattern

    param_extension = param_pattern


class LabelledParameter:
    def __init__(self, label, type_):
        self.__label = label
        self.__type = type_

    def param_type(self, _arity, t):
        return f"{self.__label}:({self.__type.replace(variadic_type_marker, t)})"

    def param_pattern(self, _arity, _index):
        return f"~{self.__label}"

    param_specialization = param_pattern

    param_extension = param_pattern


class DelegateParameter:
    def __init__(self, values, delegate_name):
        self.__values = values
        self.__delegate_name = delegate_name

    @property
    def name(self):
        return self.__delegate_name

    def param_type(self, arity, t):
        if arity == 0:
            return None
        else:
            return " -> ".join(
                f"{self.name}_{a}:(" + self.__values[self.__delegate_name].value_type(0, f"'{a}") + ")"
                for a in abcd(arity)
            )

    def param_pattern(self, arity, _index):
        if arity == 0:
            return None
        else:
            return " ".join(f"~{self.name}_{a}" for a in abcd(arity))

    def param_specialization(self, arity, _index):
        if arity == 0:
            return None
        else:
            return " ".join(f"~{self.name}_{a}:{a.upper()}.{self.name}" for a in abcd(arity))

    def param_extension(self, _arity, _index):
        return None


class Value:
    def __init__(self, *, name, type_chain, operator):
        self.__name = name
        self.__type_chain = list(type_chain)
        assert len(self.__type_chain) > 0
        self.__parameters = self.__type_chain[:-1]
        self.__operator = operator

    @property
    def name(self):
        return self.__name

    @property
    def operator(self):
        return self.__operator

    def value_type(self, arity, t):
        return " -> ".join(filter(None, (param.param_type(arity, t) for param in self.__type_chain)))

    def value_specialization(self, arity):
        yield (
            f"let {self.name} "
            + " ".join(filter(None, (p.param_pattern(0, i) for (i, p) in enumerate(self.__parameters))))
            + f" = M.{self.name} "
            + " ".join(p.param_specialization(arity, i) for (i, p) in enumerate(self.__parameters))
        )

    def value_extension(self, requirements, arity):
        for param in self.__parameters:
            if isinstance(param, DelegateParameter):
                delegate_ = param
                break
        else:
            delegate_ = None
        yield (
            f"let {self.name} "
            + " ".join(filter(None, (p.param_pattern(arity, i) for (i, p) in enumerate(self.__parameters))))
            + f" = Implementation.{self.name} "
            + "".join(
                f"~{req}:(M.{req}" + "".join([] if delegate_ is None else (f" ~{delegate_.name}_{a}" for a in abcd(arity))) + ") "
                for req in requirements
            )
            + " ".join(filter(None, (p.param_extension(arity, i) for (i, p) in enumerate(self.__parameters))))
        )


values = {}

def val(name, *type_chain, operator=None):
    def make_param(param):
        if isinstance(param, str):
            return UnlabelledParameter(param)
        elif isinstance(param, dict):
            [(label, type_)] = param.items()
            return LabelledParameter(label, type_)
        elif isinstance(param, tuple):
            if param[0] is DelegateParameter:
                return DelegateParameter(values, param[1])
            else:
                assert False
        else:
            assert False

    value = Value(
        name=name,
        type_chain=(make_param(param) for param in type_chain),
        operator=operator,
    )
    assert name not in values
    values[name] = value
    return value


def ext(name, *, members, requirements):
    def make_requirement(req):
        if isinstance(req, str):
            return values[req]
        elif isinstance(req, Value):
            return req
        else:
            assert False

    members = list(members)

    return Extension(
        name=name,
        members=(member for member in members if isinstance(member, Value)),
        requirements=(make_requirement(requirement) for requirement in requirements),
        basic_production=(values[member] for member in members if isinstance(member, str)),
    )


def deleg(name):
    return (DelegateParameter, name)


t = variadic_type_marker


traits = []

def trait(
        name,
        *,
        variadic=True,
        values=[],
        extensions=[],
        test_examples=[],
        test_requirements=[],
):
    trait = Facets(
        prefix="Traits",
        name=name,
        variadic=variadic,
        bases=[],
        values=values,
        extensions=extensions,
        test_examples=test_examples,
        test_requirements=test_requirements,
    )
    traits.append(trait)
    return trait


concepts = []

def concept(
        name,
        *,
        bases,
        values=[],
        test_requirements=[],
):
    concept = Facets(
        prefix="Concepts",
        name=name,
        variadic=True,
        bases=bases,
        values=values,
        extensions=[],
        test_examples=[],
        test_requirements=test_requirements,
    )
    concepts.append(concept)
    return concept


atoms = []

def atom(
    name,
    *,
    type,
    bases=[],
):
    atom = Type(
        prefix="Atoms",
        name=name,
        type=type,
        arity=0,
        bases=bases,
    )
    atoms.append(atom)
    return atom


###### TRAITS ######

# @feature (?) Add trait Testable with val test: Test.t

# A *representation* is a string representing a value for a software developer audience.
# When possible, it should be a valid OCaml expression for the value.
representable = trait(
    "Representable",
    values=[val("repr", t, deleg("repr"), "string")],
    test_examples=[val("representations", f"({t} * string) list")],
)

equalities = val("equalities", f"{t} list list")

equatable = trait(
    "Equatable",
    values=[val("equal", t, t, deleg("equal"), "bool", operator="=")],
    extensions=[
        ext(
            "Different",
            members=[val("different", t, t, deleg("equal"), "bool", operator="<>")],
            requirements=["equal"],
        ),
    ],
    test_examples=[
        equalities,
        val("differences", f"({t} * {t}) list"),
    ],
    test_requirements=[representable],
)

displayable = trait(
    "Displayable",
    variadic=False,
    values=[val("to_string", t, "string")],
    test_examples=[val("displays", f"({t} * string) list")],
)

# @feature Traits.Hashable with val hash: t -> int, Poly using Hashtbl.hash

parsable = trait(
    "Parsable",
    variadic=False,
    values=[
        val("try_of_string", "string", f"{t} option"),
        val("of_string", "string", t),
    ],
    test_examples=[val("literals", f"(string * {t}) list")],
    test_requirements=[equatable, representable],
)

comparable = trait(
    "Comparable",
    values=[val("compare", t, t, deleg("compare"), "Compare.t")],
    extensions=[
        ext(
            "GreaterLessThan",
            members=[
                val("less_than", t, t, deleg("compare"), "bool", operator="<"),
                val("less_or_equal", t, t, deleg("compare"), "bool", operator="<="),
                val("greater_than", t, t, deleg("compare"), "bool", operator=">"),
                val("greater_or_equal", t, t, deleg("compare"), "bool", operator=">="),
            ],
            requirements=["compare"],
        ),
        ext(
            "Between",
            members=[
                val("between", t, {"low": t}, {"high": t}, deleg("compare"), "bool"),
                val("between_or_equal", t, {"low": t}, {"high": t}, deleg("compare"), "bool")
            ],
            requirements=["less_than", "less_or_equal", "greater_than", "greater_or_equal"],
        ),
        ext(
            "MinMax",
            members=[
                val("min", t, t, deleg("compare"), t),
                val("max", t, t, deleg("compare"), t),
                val("min_max", t, t, deleg("compare"), f"{t} * {t}"),
            ],
            requirements=["compare"],
        ),
    ],
    test_examples=[
        val("orders", f"{t} list list"),
        equalities,
    ],
    test_requirements=[equatable, representable],
)

ringoid = trait(
    "Ringoid",
    variadic=False,
    values=[
        val("zero", t),
        val("one", t),
        # val("posate", t, t, operator="~+"),
        val("negate", t, t, operator="~-"),
        val("add", t, t, t, operator="+"),
        val("subtract", t, t, t, operator="-"),
        val("multiply", t, t, t, operator="*"),
        val("divide", t, t, t, operator="/"),
    ],
    extensions=[
        ext(
            "Subtract",
            members=["subtract"],
            requirements=["negate", "add"],
        ),
        ext(
            "Square",
            members=[val("square", t, t)],
            requirements=["multiply"],
        ),
        ext(
            "Exponentiate",
            members=[val("exponentiate", t, "int", t, operator="**")],
            requirements=[
                "one",
                "square",
                "multiply",
                val("exponentiate_negative_exponent", {"exponentiate": f"{t} -> int -> {t}"}, t, "int", t),
            ],
        ),
    ],
    test_examples=[
        val("additions", f"({t} * {t} * {t}) list"),
        val("negations", f"({t} * {t}) list"),
        val("multiplications", f"({t} * {t} * {t}) list"),
        val("divisions", f"({t} * {t} * {t}) list"),
        val("exponentiations", f"({t} * int * {t}) list"),
    ],
    test_requirements=[equatable, representable],
)

of_standard_numbers = trait(
    "OfStandardNumbers",
    variadic=False,
    values=[
        val("of_int", "int", t),
        val("of_float", "float", t),
    ],
)

to_standard_numbers = trait(
    "ToStandardNumbers",
    variadic=False,
    values=[
        val("to_int", t, "int"),
        val("to_float", t, "float"),
    ],
)

pred_succ = trait(
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
    test_requirements=[equatable, representable],
)


###### CONCEPTS ######

# @feature Concepts for iterables and collections. Something like Collection, Container, MonoBag, MultiBag, LinearContainer

identifiable = concept(
    "Identifiable",
    bases=[equatable, representable],
)

able = concept(
    "Able",
    bases=[identifiable, comparable],
)

stringable = concept(
    "Stringable",
    bases=[displayable, parsable],
    test_requirements=[representable, equatable],  # @todo Deduce from parsable's test requirements
)

number = concept(
    "Number",
    bases=[identifiable, stringable, ringoid, of_standard_numbers],
)

real_number = concept(
    "RealNumber",
    # @feature sign
    bases=[number, comparable, to_standard_numbers],
    values=[
        val("abs", t, t),
        val("modulo", t, t, t, operator="mod"),
    ],
)

integer = concept(
    "Integer",
    # @feature Bitwise?
    # @feature gcd, lcm, quomod
    # @feature width: like Sys.int_size
    bases=[real_number, pred_succ],
)


###### TYPES ######

unit = atom(
    "Unit",
    type="unit",
    bases=[able],
)

bool_ = atom(
    "Bool",
    type="bool",
    bases=[able, stringable],
)

char = atom(
    "Char",
    type="char",
    bases=[able],
)

int_ = atom(
    "Int",
    type="int",
    bases=[integer],
)

int32 = atom(
    "Int32",
    type="Pervasives.OCamlStandard.Int32.t",
    bases=[integer],
)

int64 = atom(
    "Int64",
    type="Pervasives.OCamlStandard.Int64.t",
    bases=[integer],
)

native_int = atom(
    "NativeInt",
    type="Pervasives.OCamlStandard.Nativeint.t",
    bases=[integer],
)

big_int = atom(
    "BigInt",
    type="Pervasives.OCamlStandard.Big_int.big_int",
    bases=[integer],
)

float_ = atom(
    "Float",
    type="float",
    bases=[real_number],
)

string = atom(
    "String",
    type="string",
    bases=[able, displayable],
)

bytes_ = atom(
    "Bytes",
    type="bytes",
    bases=[able, displayable],
)


if __name__ == "__main__":
    def gen(path, *items):
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w") as f:
            generate(items, file=f)

    gen(
        "src/Generated/Facets.dot",
        'digraph {',
        '  rankdir="BT"',
        '  node [shape="box"]',
        (
            (
                f'  subgraph cluster_{items[0].prefix} {{',
                f'    label="{items[0].prefix}";',
                (f'    {item.name.lower()} [label="{item.graphviz_label}"];' for item in items),
                '  }',
            )
            for items in (traits, concepts, atoms)
        ),
        (
            f'  {item.name.lower()} -> {base.name.lower()}'
            for item in itertools.chain(traits, concepts, atoms)
            for base in item.bases
        ),
        '}',
    )

    for items in (traits, concepts):
        gen(f"src/Generated/{items[0].prefix}.mli", (item.specification for item in items))

    for item in itertools.chain(traits, concepts, atoms):
        gen(f"src/Generated/{item.prefix}/{item.name}.ml", item.implementation_items)

    for item in atoms:
        gen(f"src/Generated/{item.prefix}/{item.name}.mli", item.specification_items)
