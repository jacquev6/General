#!/usr/bin/env python3

import glob
import os.path


class Flattener:
    def __init__(self):
        self.unused_sources = set(
            f for f in glob.glob("src/**", recursive=True)
            if os.path.isfile(f)
        )

    def general(self):
        yield from self.module_of_dir("Reset", [
            "CommonHeader.ml",
            "DefinitionHeader.ml",
            "ResetPervasives.ml",
            "ResetStandardLibrary.ml",
            "Footer.ml",
        ])
        yield ""
        yield "open Reset.ResetPervasives"
        yield "open Reset.ResetStandardLibrary"
        yield "module OCSP = OCamlStandard.Pervasives"
        yield from self.module_of_file("Equate.ml")
        yield from self.module_of_file("Compare.ml")
        yield from self.module_of_file("Shorten.ml")
        yield ""
        yield from self.module_of_dir("Foundations", [
            "Format_.ml",
            "Lazy_.ml",
            "Exception.ml",
            "Functions.ml",
            "Int.ml",
            "Bool.ml",
            "Option.ml",
            "List_.ml",
            "CallStack.ml",
            "Float.ml",
            "Reference.ml",
            "String_.ml",
            "IntRange.ml",
            "Tuples.ml",
            "Exit.ml",
            "Stream_.cppo.ml",
            "Unit.ml",
            "PervasivesWhitelist.ml",
        ])
        yield ""
        yield "module Pervasives = struct"
        yield "  include Reset.ResetPervasives"
        yield "  include Reset.ResetStandardLibrary"
        yield "  include Foundations.PervasivesWhitelist"
        yield "end"
        yield ""
        yield "open Pervasives"
        yield ""
        yield from self.module_of_file("Testing.cppo.ml")
        yield ""
        yield from self.module_of_dir("Traits", [
            "Representable.ml",
            "Equatable.ml",
            "Comparable.ml",
            "Displayable.ml",
            "FilterMapable.ml",
            "Foldable.ml",
            "Parsable.ml",
            "PredSucc.ml",
            "Ringoid.ml",
            "Scanable.ml",
        ])
        yield ""
        yield from self.module_of_dir("Concepts", [
            "Identifiable.ml",
            "Able.ml",
            "Number.ml",
            "RealNumber.ml",
            "Integer.ml",
        ])
        yield ""
        yield from self.module_of_dir("Implementation", [
            "Array_.ml",
            "Exception.ml",
            "Format_.ml",
            "StandardInt.ml",
            "Int32_.cppo.ml",
            "Int64_.cppo.ml",
            "Float.ml",
            "BigInt.ml",
            "Bool.ml",
            "Bytes_.ml",
            "Int.ml",
            "List_.ml",
            "CallStack.ml",
            "Char_.ml",
            "Exit.ml",
            "Functions.ml",
            "InChannel.ml",
            "InFile.ml",
            "IntRange.ml",
            "Lazy_.ml",
            "NativeInt_.cppo.ml",
            "Option.ml",
            "OutChannel.ml",
            "OutFile.ml",
            "Tuples.cppo.ml",
            "RedBlackTree.cppo.ml",
            "Reference.ml",
            "SortedMap.ml",
            "SortedSet.ml",
            "StandardOutChannel.ml",
            "StdErr.ml",
            "StdIn.ml",
            "StdOut.ml",
            "Stream_.ml",
            "String_.ml",
            "TestingTests.ml",
            "Unit.ml",
        ])
        yield ""
        yield from self.module_of_dir("Specializations", [
            "List_.ml",
            "Option.ml",
            "Reference.ml",
            "SortedMap.ml",
            "SortedSet.ml",
        ])
        self.warn_unused_sources()

    def module_of_dir(self, dir_name, file_names):
        yield "module {} = struct".format(dir_name)
        for (i, file_name) in enumerate(file_names):
            if i != 0:
                yield ""
            yield from self.indent(self.module_of_file(os.path.join(dir_name, file_name)))
        yield "end"

    def module_of_file(self, file_name):
        file_name = os.path.join("src", file_name)
        self.unused_sources.discard(file_name)
        module_name = os.path.basename(file_name).replace(".ml", "").replace(".cppo", "")
        yield "module {} = struct".format(module_name)
        yield "  # 1 \"{}\"".format(file_name)
        with open(file_name) as f:
            yield from self.indent(f)
        yield "end"

    def warn_unused_sources(self):
        for source in sorted(self.unused_sources):
            print("WARNING: source file not used:", source)

    def indent(self, lines):
        for line in lines:
            line = line.rstrip()
            if line:
                yield "  {}".format(line)
            else:
                yield ""


if __name__ == "__main__":
    with open("Impl.ml", "w") as f:
        for line in Flattener().general():
            f.write(line + "\n")
