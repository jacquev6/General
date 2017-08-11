# coding: utf8

# Copyright 2017 Vincent Jacques <vincent@vincent-jacques.net>

"""
A `Sphinx <http://www.sphinx-doc.org>`_ extension providing an `OCaml` `domain <http://www.sphinx-doc.org/en/stable/domains.html>`_.
"""

import itertools
import json

import docutils
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


class Value(sphinx.directives.ObjectDescription):
    option_spec = {
        "noindex": docutils.parsers.rst.directives.flag,
        "type": docutils.parsers.rst.directives.unchanged,
    }

    def handle_signature(self, sig, signode):
        self.__short_name = sig
        self.__full_name = ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"] + [self.__short_name])
        signode += sphinx.addnodes.desc_annotation("val ", "val ")
        signode += sphinx.addnodes.desc_name(self.__short_name, self.__short_name)
        type_ = self.options.get("type")
        if type_:
            signode += sphinx.addnodes.desc_annotation(": ", ": ")
            signode += sphinx.addnodes.desc_annotation(type_, type_)
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
    option_spec = {
        "noindex": docutils.parsers.rst.directives.flag,
        "parameters": docutils.parsers.rst.directives.unchanged,
        "manifest": docutils.parsers.rst.directives.unchanged,
    }

    def handle_signature(self, sig, signode):
        self.__short_name = sig
        self.__full_name = ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"] + [self.__short_name])
        signode += sphinx.addnodes.desc_annotation("type ", "type ")
        parameters = self.options.get("parameters")
        if parameters:
            signode += sphinx.addnodes.desc_annotation(parameters, parameters)
            signode += sphinx.addnodes.desc_annotation(" ", " ")
        signode += sphinx.addnodes.desc_name(self.__short_name, self.__short_name)
        manifest = self.options.get("manifest")
        if manifest:
            signode += sphinx.addnodes.desc_annotation(" = ", " = ")
            signode += sphinx.addnodes.desc_annotation(manifest, manifest)
        return "type {}".format(self.__full_name)

    def add_target_and_index(self, name, sig, signode):
        assert sig == self.__short_name
        assert name == "type {}".format(self.__full_name)
        assert name not in self.state.document.ids
        signode["names"].append(name)
        signode["ids"].append(name)
        self.state.document.note_explicit_target(signode)

        self.env.domaindata[OCamlDomain.name]["typ"][sig] = self.env.docname

        self.indexnode["entries"].append(("single", "{} (type in {})".format(sig, ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"])), name, "", None))


class Exception(sphinx.directives.ObjectDescription):
    option_spec = {
        "noindex": docutils.parsers.rst.directives.flag,
        "payload": docutils.parsers.rst.directives.unchanged,
    }

    def handle_signature(self, sig, signode):
        self.__short_name = sig
        self.__full_name = ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"] + [self.__short_name])
        signode += sphinx.addnodes.desc_annotation("exception ", "exception ")
        signode += sphinx.addnodes.desc_name(self.__short_name, self.__short_name)
        payload = self.options.get("payload")
        if payload:
            signode += sphinx.addnodes.desc_annotation(" of ", " of ")
            signode += sphinx.addnodes.desc_annotation(payload, payload)
        return "exception {}".format(self.__full_name)

    def add_target_and_index(self, name, sig, signode):
        assert sig == self.__short_name
        assert name == "exception {}".format(self.__full_name)
        assert name not in self.state.document.ids
        signode["names"].append(name)
        signode["ids"].append(name)
        self.state.document.note_explicit_target(signode)

        self.env.domaindata[OCamlDomain.name]["exn"][sig] = self.env.docname

        self.indexnode["entries"].append(("single", "{} (exception in {})".format(sig, ".".join(self.env.domaindata[OCamlDomain.name]["module_stack"])), name, "", None))


class OCamlDomain(sphinx.domains.Domain):
    name = "ocaml"
    label = "OCaml"
    object_types = {
        "module": sphinx.domains.ObjType("module", "mod"),
        "value": sphinx.domains.ObjType("value", "val"),
        "type": sphinx.domains.ObjType("type", "typ"),
        "exception": sphinx.domains.ObjType("exception", "exn"),
    }
    directives = {
        "module": Module,
        "val": Value,
        "type": Type,
        "exception": Exception,
    }
    roles = {
        "mod": sphinx.roles.XRefRole(),
        "val": sphinx.roles.XRefRole(),
        "typ": sphinx.roles.XRefRole(),
        "exn": sphinx.roles.XRefRole(),
    }
    initial_data = {
        "module_stack": [],
        "mod": {},
        "val": {},
        "typ": {},
        "exn": {},
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
