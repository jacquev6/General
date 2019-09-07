import itertools
import sys


max_arity = 6


def generate(element, **kwds):
    for line in indent(element, kwds.get("indent", 0)):
        print(line)


def indent(element, levels=1):
    if isinstance(element, str):
        yield f"{'  ' * levels}{element}"
    else:
        for sub in element:
            yield from indent(sub, levels)


class Trait:
    all = []

    def __init__(self, name, *, variadic, basics, extensions=[]):
        Trait.all.append(self)
        self.name = name
        self.max_arity = max_arity if variadic else 1
        self.basics = list(basics)
        self.extensions = list(extensions)
        self.all_items = list(itertools.chain(
            self.basics,
            itertools.chain.from_iterable(extension.members for extension in self.extensions),
        ))
        self.operators = [item for item in self.all_items if item.operator is not None]
        # print([op.operator for op in self.operators], file=sys.stderr)

    @property
    def full_name(self):
        return f"Traits.{self.name}"

    @property
    def has_operators(self):
        return len(self.operators) > 0

    @property
    def is_basic(self):
        return len(self.extensions) == 0 and len(self.operators) == 0

    @property
    def declaration(self):
        yield f"module {self.name}: sig"
        yield indent(self.__declaration())
        yield "end"

    def __declaration(self):
        if self.is_basic:
            yield self.__basic_signatures
        else:
            yield "module Basic: sig"
            yield indent(self.__basic_signatures)
            yield "end"
            if len(self.operators) != 0:
                yield "module Operators: sig"
                yield indent(self.__operators_signatures)
                yield indent(self.__operators_makers_signatures)
                yield "end"
            yield self.__extended_signatures
            yield self.__extensions_makers_signatures

    @property
    def __basic_signatures(self):
        for arity in range(self.max_arity):
            yield f"module type S{arity} = sig"
            yield f"  type {type_params(arity)}t"
            for v in self.basics:
                yield indent(v.make_signature(self.basics, arity))
            yield "end"

    @property
    def __operators_signatures(self):
        yield "module type S0 = sig"
        yield "  type t"
        for operator in self.operators:
            yield indent(operator.make_signature(self.basics, 0, operator=True))
        yield "end"

    @property
    def __operators_makers_signatures(self):
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield indent(operator.make_signature(self.basics, 0))
        yield "end): S0 with type t := M.t"

    @property
    def __extended_signatures(self):
        for arity in range(self.max_arity):
            yield f"module type S{arity} = sig"
            yield f"  include Basic.S{arity}"
            for extension in self.extensions:
                for item in extension.members:
                    yield indent(item.make_signature(self.basics, arity))
            if arity == 0:
                yield "  module O: Operators.S0 with type t := t"
            yield "end"

    @property
    def __extensions_makers_signatures(self):
        for extension in self.extensions:
            if len(extension.requirements) != 0:
                yield f"module {extension.name}: sig"
                # @todo Make{arity}
                yield "  module Make0(M: sig"
                yield "    type t"
                for req in extension.requirements:
                    if isinstance(req, str):
                        for item in self.all_items:
                            if item.name == req:
                                yield indent(item.make_signature(self.basics, 0), levels=2)
                    else:
                        yield indent(req.make_signature(self.basics, 0), levels=2)
                yield "  end): sig"
                for item in extension.members:
                    yield indent(item.make_signature(self.basics, 0, t="M.t"), levels=2)
                for prod in extension.basic_production:
                    for item in self.all_items:
                        if item.name == prod:
                            yield indent(item.make_signature(self.basics, 0, t="M.t"), levels=2)
                yield "  end"
                yield "end"

    @property
    def module_items(self):
        if self.is_basic:
            yield self.__basic_module_items
        else:
            yield "module Basic = struct"
            yield indent(self.__basic_module_items)
            yield "end"
            yield "module Operators = struct"
            yield indent(self.__operators_module_items)
            yield "end"
            yield self.__extended_module_items

    @property
    def __basic_module_items(self):
        yield self.__basic_signatures
        for arity in range(1, self.max_arity):
            functor_params = "".join(f"({a.upper()}: S0)" for a in abcd(arity))
            yield f"module Specialize{arity}(M: S{arity}){functor_params}: S0 with type t = {type_args(arity)}M.t = struct"
            yield f"  type t = {type_args(arity)}M.t"
            for v in self.basics:
                yield indent(v.make_specialization(self.basics, arity))
            yield "end"

    @property
    def __operators_module_items(self):
        yield self.__operators_signatures
        yield "module Make0(M: sig"
        yield "  type t"
        for operator in self.operators:
            yield indent(operator.make_signature(self.basics, 0))
        yield "end) = struct"
        for operator in self.operators:
            yield f"  let ( {operator.operator} ) = M.{operator.name}"
        yield "end"

    @property
    def __extended_module_items(self):
        yield self.__extended_signatures
        for arity in range(1, self.max_arity):
            functor_params = "".join(f"({a.upper()}: Basic.S0)" for a in abcd(arity))
            yield f"module Specialize{arity}(M: S{arity}){functor_params}: S0 with type t = {type_args(arity)}M.t = struct"
            yield "  module Self = struct"
            yield f"    include Basic.Specialize{arity}(M)" + "".join(f"({a.upper()})" for a in abcd(arity))
            for extension in self.extensions:
                for item in extension.members:
                    yield indent(item.make_specialization(self.basics, arity), levels=2)
            yield "  end"
            yield "  module O = Operators.Make0(Self)"
            yield "  include Self"
            yield "end"


class Concept:
    all = []

    def __init__(self, name, *, inherited):
        Concept.all.append(self)
        self.name = name
        self.inherited = inherited

    @property
    def full_name(self):
        return self.name

    @property
    def has_operators(self):
        return any(base.has_operators for base in self.inherited)

    @property
    def declaration(self):
        yield f"module {self.name}: sig"
        if self.has_operators:
            yield "  module Operators: sig"
            yield "    module type S0 = sig"
            yield "      type t"
            for base in self.inherited:
                if base.has_operators:
                    yield f"      include {base.full_name}.Operators.S0 with type t := t"
            yield "    end"
            yield "  end"
        yield indent(self.__signatures)
        yield "end"

    @property
    def __signatures(self):
        for arity in range(max_arity):
            yield f"module type S{arity} = sig"
            yield f"  type {type_params(arity)}t"
            if arity == 0:
                yield "  module O: Operators.S0 with type t := t"
            for base in self.inherited:
                if arity == 0 and base.has_operators:
                    operators_constraint = " and module O := O"
                else:
                    operators_constraint = ""
                yield f"  include {base.full_name}.S{arity} with type {type_params(arity)}t := {type_params(arity)}t{operators_constraint}"
            yield "end"

    @property
    def module_items(self):
        yield "module Operators = struct"
        yield "  module type S0 = sig"
        yield "    type t"
        for base in self.inherited:
            if base.has_operators:
                yield f"    include {base.full_name}.Operators.S0 with type t := t"
        yield "  end"
        yield "end"
        yield self.__signatures


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



representable = Trait(
    "Representable",
    variadic=True,
    basics=[
        val("repr", params=[variadic_type], return_="string"),
    ],
)

displayable = Trait(
    "Displayable",
    variadic=False,
    basics=[
        val("to_string", params=[variadic_type], return_="string"),
    ],
)

parsable = Trait(
    "Parsable",
    variadic=False,
    basics=[
        val("try_of_string", params=["string"], return_="t option"),
        val("of_string", params=["string"], return_="t"),
    ],
)

equatable = Trait(
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

comparable = Trait(
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

ringoid = Trait(
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
    ]
)


identifiable = Concept(
    "Identifiable",
    inherited=[equatable, representable],
)

able = Concept(
    "Able",
    inherited=[identifiable, comparable],
)

# number = Concept(
#     "Number",
#     inherited=[],
# )
