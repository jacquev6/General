# coding: utf8

# Copyright 2017 Vincent Jacques <vincent@vincent-jacques.net>

"""
A `Sphinx <http://www.sphinx-doc.org>`_ extension providing an `OCaml` `domain <http://www.sphinx-doc.org/en/stable/domains.html>`_.
"""

import itertools
import json

import sphinx


class Module(sphinx.directives.ObjectDescription):
    def handle_signature(self, sig, signode):
        self.__short_name = sig
        self.__full_name = ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"] + [self.__short_name])
        signode += sphinx.addnodes.desc_annotation("module ", "module ")
        signode += sphinx.addnodes.desc_name(self.__short_name, self.__short_name)
        return "module {}".format(self.__full_name)

    def add_target_and_index(self, name, sig, signode):
        assert sig == self.__short_name
        assert name == "module {}".format(self.__full_name)
        assert name not in self.state.document.ids
        signode["names"].append(name)
        signode["ids"].append(name)
        self.state.document.note_explicit_target(signode)

        self.env.domaindata[OCamlDomain.name]["mod"][sig] = self.env.docname

        self.indexnode["entries"].append(("single", "{} (module in {})".format(sig, ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"])), name, "", None))

    def before_content(self):
        self.env.domaindata[OCamlDomain.name]["module_stack"].append(self.__short_name)

    def after_content(self):
        self.env.domaindata[OCamlDomain.name]["module_stack"].pop()


def chain_value_types(types, sep=[], before_one=[], after_one=[], before_more=[], after_more=[]):
    if len(types) > 0:
        types = [value_type_to_signodes(x) for x in types]
        if len(types) > 1:
            nodes = [None] * (len(types) * 2 - 1)
            nodes[0::2] = types
            for i in range(0, len(types) - 1):
                nodes[2 * i + 1] = sep
            return before_more + list(itertools.chain.from_iterable(nodes)) + after_more
        else:
            return before_one + types[0] + after_one
    else:
        return []

class Value(sphinx.directives.ObjectDescription):
    optional_arguments = 1

    def handle_signature(self, sig, signode):
        self.__short_name = sig
        self.__full_name = ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"] + [self.__short_name])
        signode += sphinx.addnodes.desc_annotation("val ", "val ")
        signode += sphinx.addnodes.desc_name(self.__short_name, self.__short_name)
        if len(self.arguments) > 1 and self.arguments[1].startswith("type: "):
            signode += sphinx.addnodes.desc_annotation(": ", ": ")
            signode += sphinx.addnodes.desc_annotation(self.arguments[1][6:], self.arguments[1][6:])
        return "val {}".format(self.__full_name)

    def add_target_and_index(self, name, sig, signode):
        assert sig == self.__short_name
        assert name == "val {}".format(self.__full_name)
        assert name not in self.state.document.ids, name
        signode["names"].append(name)
        signode["ids"].append(name)
        self.state.document.note_explicit_target(signode)

        self.env.domaindata[OCamlDomain.name]["val"][self.__full_name] = self.env.docname
        self.env.domaindata[OCamlDomain.name]["val"][sig] = self.env.docname

        self.indexnode["entries"].append(("single", "{} (value in {})".format(sig, ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"])), name, "", None))


class Type(sphinx.directives.ObjectDescription):
    def handle_signature(self, sig, signode):
        self.__short_name = sig
        self.__full_name = ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"] + [self.__short_name])
        signode += sphinx.addnodes.desc_annotation("type ", "type ")
        signode += sphinx.addnodes.desc_name(self.__short_name, self.__short_name)
        return "typ {}".format(self.__full_name)

    def add_target_and_index(self, name, sig, signode):
        assert sig == self.__short_name
        assert name == "typ {}".format(self.__full_name)
        assert name not in self.state.document.ids
        signode["names"].append(name)
        signode["ids"].append(name)
        self.state.document.note_explicit_target(signode)

        self.env.domaindata[OCamlDomain.name]["typ"][sig] = self.env.docname

        self.indexnode["entries"].append(("single", "{} (type in {})".format(sig, ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"])), name, "", None))


class OCamlDomain(sphinx.domains.Domain):
    name = "ocaml"
    label = "OCaml"
    object_types = {
        "module": sphinx.domains.ObjType("module", "mod"),
        "value": sphinx.domains.ObjType("value", "val"),
        "type": sphinx.domains.ObjType("type", "typ"),
    }
    directives = {
        "module": Module,
        "val": Value,
        "type": Type,
    }
    roles = {
        "mod": sphinx.roles.XRefRole(),
        "val": sphinx.roles.XRefRole(),
        "typ": sphinx.roles.XRefRole(),
    }
    initial_data = {
        "module_stack": [],
        "mod": {},
        "val": {},
        "typ": {},
    }

    def resolve_xref(self, env, fromdocname, builder, typ, target, node, contnode):
        foo = self.data[typ].get(target)
        if foo:
            target = "{} {}".format({"val": "val", "typ": "type", "mod": "module"}[typ], target)
            return sphinx.util.nodes.make_refnode(builder, fromdocname, foo, target, contnode, None)
        else:
            return None


def setup(app):
    app.add_domain(OCamlDomain)
