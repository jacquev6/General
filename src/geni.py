import contextlib
import functools
import glob
import itertools
import os
import shutil
import subprocess
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
            submodule,
            bases, values, extensions,
            test_examples, test_requirements,
        ):
        self.prefix = prefix
        self.name = name
        self.bases = list(bases)
        self.max_arity = min(itertools.chain([max_arity], (i.max_arity for i in self.bases))) if variadic else 1
        self.arities = list(range(self.max_arity))
        self.non_zero_arities = list(range(1, self.max_arity))
        self.submodule = submodule
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
    def graphviz_node(self):
        yield f'{self.name.lower()} [label="{self.__graphviz_label()}"]'

    def __graphviz_label(self):
        parts = [self.name]
        if len(self.values) > 0:
            parts.append("")
            if self.submodule is None:
                prefix = ""
            else:
                prefix = f"{self.submodule}."
            parts += [f"{prefix}{val.name}" for val in self.values]
        exts = [val.name for extension in self.extensions for val in extension.members]
        if len(exts) > 0:
            parts.append("")
            parts += exts
        return "\\n".join(parts)

    @property
    def graphviz_node_name(self):
        return self.name.lower()

    @property
    def graphviz_links(self):
        for base in self.bases:
            yield f'{self.name.lower()} -> {base.name.lower()}'

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
        if self.submodule is None:
            for value in self.values:
                yield f"val {value.name}: {value.value_type(arity, t)}"
        else:
            yield mod_spec(self.submodule,
                (f"val {value.name}: {value.value_type(arity, t)}" for value in self.values),
            )

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
            type_params, type,
            arity,
            bases, exceptions, operators, values, types,
            specializers,
    ):
        self.prefix = prefix
        self.name = name
        self.type = type
        self.arity = arity
        self.bases = list(bases)
        self.exceptions = list(exceptions)
        self.operators = list(operators)
        self.values = list(values)
        self.types = list(types)
        self.type_params = "" if type_params is None else f"{type_params} "
        self.specializers = specializers

    @property
    def graphviz_node(self):
        if len(self.types) == 0:
            yield f'{self.graphviz_node_name} [label="{self.__graphviz_label()}"]'
        else:
            yield f"subgraph cluster_{self.name} {{"
            yield f'  label="{self.name}"'
            yield f'  labelloc="b"',
            label = "\\n".join(val.name for val in self.values)
            yield f'  {self.graphviz_node_name} [style="dotted",label="{label}"]'
            yield indent(type_.graphviz_node for type_ in self.types)
            yield "}"

    def __graphviz_label(self):
        parts = [self.name]
        if len(self.values) > 0:
            parts.append("")
            parts += [val.name for val in self.values]
        return "\\n".join(parts)

    @property
    def graphviz_node_name(self):
        if self.name == "Class":
            return "float_class"
        else:
            return self.name.lower()

    @property
    def graphviz_links(self):
        for base in self.bases:
            if len(self.types) == 0:
                ltail = ""
            else:
                ltail = f' [ltail="cluster_{self.name}"]'
            yield f'{self.graphviz_node_name} -> {base.graphviz_node_name}{ltail}'
        for type_ in self.types:
            yield type_.graphviz_links

    @property
    def specification(self):
        return mod_spec(self.name, self.specification_items)

    @property
    def specification_items(self):
        yield f"type {self.type_params}t = {self.type}"
        if len(self.operators) > 0:
            yield mod_spec("O",
                (f"include {base.contextualized_name(self.prefix)}.Operators.S{self.arity} with type t := t" for base in self.bases if base._Facets__has_operators()),
                (f"val {value.name}: {value.value_type(self.arity, 't')}" for value in self.operators)
            )
        for base in self.bases:
            if len(self.operators) > 0 and base._Facets__has_operators():
                operators_constraint = " and module O := O"
            else:
                operators_constraint = ""
            yield f"include {base.contextualized_name(self.prefix)}.S{self.arity} with type {self.type_params}t := {self.type_params}t{operators_constraint}"
        for exn in self.exceptions:
            if len(exn.arguments) == 0:
                arguments = ""
            elif len(exn.arguments) == 1:
                arguments = f" of {exn.arguments[0]}"
            else:
                arguments = " of ({})".format(" * ".join(exn.arguments))
            yield f"exception {exn.name}{arguments}"
        for type_ in self.types:
            yield mod_spec(type_.name, type_.specification_items)
        for value in self.values:
            yield f"val {value.name}: {value.value_type(self.arity, 't')}"
        yield self.specializers

    @property
    def implementation_items(self):
        yield mod_impl("Tests_", self.__tests_implementation_items())

    def __tests_implementation_items(self):
        # @todo Homogenize
        if self.name == "Class":
            type_1 = type_2 = "SelfA.t"
        elif self.name.startswith("Tuple"):
            type_1 = f"{self.type_params}t"
            type_2 = self.type
            yield f"type {self.type_params}t = {self.type}"
        else:
            type_1 = type_2 = self.type
        yield mod_type("Examples",
            (f"include {base.contextualized_name(self.prefix)}.Tests.Examples.S{self.arity} with type {self.type_params}t := {type_1}" for base in self.bases),
        )
        yield mod_type("Testable",
            f"type {self.type_params}t = {type_2}" if len(self.bases) > 0 else (),
            (f"include {base.contextualized_name(self.prefix)}.Tests.Testable.S{self.arity} with type {self.type_params}t := {self.type_params}t" for base in self.bases),
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


class OCamlException:
    def __init__(self, name, arguments):
        self.name = name
        self.arguments = list(arguments)


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
    if name in values:
        print("WARNING: duplicated value", name)
    else:
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


def exception(name, *arguments):
    return OCamlException(name, arguments)


t = variadic_type_marker


traits = []

def trait(
        name,
        *,
        variadic=True,
        submodule=None,
        values=[],
        extensions=[],
        test_examples=[],
        test_requirements=[],
):
    trait = Facets(
        prefix="Traits",
        name=name,
        variadic=variadic,
        submodule=submodule,
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
        submodule=None,
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
            if "RESET_TYPE" in line:
                type_ = "General." + line.split(",")[-1].strip()[:-1].replace("__", ".")
                if "'" in line:
                    type_ = f"_ {type_}"
                types.add(type_)
            if "RESET_VALUE" in line:
                values.add("General." + line.split(",")[1].strip()[:-1].replace("__", "."))
    types.discard("General.todo")
    types.discard("_ General.todo")
    values.discard("General.todo")
    for type_ in sorted(types):
        yield f"let (_: {type_} option) = None"
    for value in sorted(values):
        yield f"let _ = {value}"
    yield ""
    yield "open General.Abbr"
    yield ""
    yield "let () ="
    yield "  let argv = Li.of_array OCamlStandard.Sys.argv in"
    yield "  Exit.exit (Tst.command_line_main ~argv General.Tests.test)"


def make_dune():
    yield "(rule"
    yield "  (targets General.mli)"
    yield "  (deps"
    yield "    (:src General.cppo.mli)"
    yield "    geni.py"
    for name in sorted(itertools.chain(
        glob.glob("src/OldFashion/Traits/*.signatures*.ml", recursive=False),
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
    yield "    geni.py"
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

of_int = trait(
    "OfInt",
    variadic=False,
    values=[
        val("of_int", "int", t),
    ],
)

to_int = trait(
    "ToInt",
    variadic=False,
    values=[
        val("to_int", t, "int"),
    ],
)

of_float = trait(
    "OfFloat",
    variadic=False,
    values=[
        val("of_float", "float", t),
    ],
)

to_float = trait(
    "ToFloat",
    variadic=False,
    values=[
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

bounded = trait(
    "Bounded",
    variadic=False,
    values=[
        val("smallest", t),
        val("greatest", t),
    ],
)

bitwise = trait(
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

of_standard_numbers = concept(
    "OfStandardNumber",
    bases=[of_int, of_float],
)

number = concept(
    "Number",
    bases=[identifiable, stringable, ringoid, of_standard_numbers],
)

to_standard_numbers = concept(
    "ToStandardNumber",
    bases=[to_int, to_float],
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

fixed_width_integer = concept(
    "FixedWidthInteger",
    bases=[integer, bounded, bitwise],
    values=[val("width", "int")],
)

###### ATOMIC TYPES ######

call_stack = atom(
    "CallStack",
    type="Pervasives.OCamlStandard.Printexc.raw_backtrace",
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
            type="Pervasives.OCamlStandard.Printexc.location = {filename: string; line_number: int; start_char: int; end_char: int}",
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
            type="Pervasives.OCamlStandard.Printexc.backtrace_slot",
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
        # https://caml.inria.fr/pub/docs/manual-ocaml-4.05/core.html#sec527
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
        # https://caml.inria.fr/pub/docs/manual-ocaml-4.05/libref/Pervasives.html
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
    type="Pervasives.OCamlStandard.Int32.t",
    bases=[fixed_width_integer],
)

int64 = atom(
    "Int64",
    type="Pervasives.OCamlStandard.Int64.t",
    bases=[fixed_width_integer],
)

native_int = atom(
    "NativeInt",
    type="Pervasives.OCamlStandard.Nativeint.t",
    bases=[fixed_width_integer],
)

big_int = atom(
    "BigInt",
    type="Pervasives.OCamlStandard.Big_int.big_int",
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

        #   (* @feature Traits *)
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
    type="'a Pervasives.OCamlStandard.Pervasives.ref = {mutable contents: 'a}",
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
            module SpecializePredSucc(A: Traits.PredSucc.S0): sig
              type nonrec t = A.t t
              val increment: t -> unit
              val decrement: t -> unit
            end
        """).splitlines(),
        textwrap.dedent("""\
            module SpecializeRingoidOperators(A: Traits.Ringoid.Basic.S0): sig
              type nonrec t = A.t t
              val (=+): t -> A.t -> unit
              val (=-): t -> A.t -> unit
              val (=*): t -> A.t -> unit
              val (=/): t -> A.t -> unit
            end
        """).splitlines(),
        textwrap.dedent("""\
            module SpecializeRingoid(A: Traits.Ringoid.Basic.S0): sig
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

if __name__ == "__main__":
    def gen(path, *items):
        if os.sep in path:
            os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w") as f:
            generate(items, file=f)

    all_items = (traits, concepts, atoms, wrappers)

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
            else:
                with open(path, "w") as f:
                    f.write(f'#include "../Generated/{item.prefix}/{item.name}.ml"\n\n#include "empty_{item.prefix[:-1].lower()}.ml"\n')

    for item in itertools.chain.from_iterable(all_items):
        gen(f"src/Generated/{item.prefix}/{item.name}.ml", item.implementation_items)
        if hasattr(item, "types"):
            for subtype in item.types:
                gen(f"src/Generated/{item.prefix}/{subtype.prefix.split('.')[1]}/{subtype.name}.ml", subtype.implementation_items)

    gen("unit_tests.ml", make_unit_tests())

    gen("src/dune", make_dune())
