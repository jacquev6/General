#!/bin/bash

set -o errexit

function build {
    ocamlbuild \
        -use-ocamlfind -no-links \
        -plugin-tag "package(cppo_ocamlbuild)" \
        $@
}

for directory in $(find src -mindepth 1 -type d)
do
    # echo "Rebuilding ${directory}.mlpack from $directory's contents"
    ls $directory/*.ml* | sed "s#\..*##" | sort -u >${directory}.mlpack
done

build -build-dir _build_native -X _build_coverage -X demo \
    src/Foundations/ResetPervasives.inferred.mli \
    General.cmxa unit_tests.native

python3 <<END
def complete_definitions():
    with open("_build_native/src/Foundations/ResetPervasives.inferred.mli") as f:
        current_line = None
        for line in f:
            line = line.strip()
            if any(line.startswith(prefix + " ") for prefix in ["exception", "external", "type", "val", "module"]):
                if current_line is not None:
                    yield current_line
                current_line = line
            else:
                current_line += " " + line
        yield current_line

ok = True
for line in complete_definitions():
    assert line.count(" : ") <= 1, line
    if (
        "\`Please_use_General_" not in line and
        line not in ["exception Exit", "module LargeFile : sig"] and
        all(not line.startswith("external __{}__ : ".format(x)) for x in ["LOC", "FILE", "LINE", "MODULE", "POS", "LOC_OF", "LINE_OF", "POS_OF"])
    ):
        ok = False
        print("Not reset in Pervasives:", line)

if not ok:
    exit(1)
END

python3 <<END
def all_please_uses():
    with open("_build_native/src/Foundations/ResetPervasives.inferred.mli") as f:
        for line in f:
            for word in line.split():
                if word.startswith("\`Please_use_") and not word.endswith("__todo"):
                    yield word[12:].replace("__", ".")
with open("demo/demo_pervasives.ml", "w") as f:
    for symbol in sorted(set(all_please_uses())):
        if symbol.endswith("Reference.t") or symbol.endswith("Format.t"):
            f.write("let (_: _ {} option) = None\n".format(symbol))
        elif symbol.endswith(".t"):
            f.write("let (_: {} option) = None\n".format(symbol))
        else:
            f.write("let _ = {}\n".format(symbol))
END

cd demo
# This simulates the 'opam install' process, but is quicker
rm -rf _build_with_lib
mkdir _build_with_lib
cp ../_build_native/src/General.cmi ../_build_native/src/General.cmx ../_build_native/src/General.a ../_build_native/src/General.cmxa _build_with_lib
build -build-dir _build_with_lib -X _build_with_package -package num -lib General demo.native demo_pervasives.native
cd ..

build -build-dir _build_coverage -X _build_native -X demo \
    -package bisect_ppx -tag debug \
    -tag-line 'true:+open(DependenciesForBisectPpx)' \
    -tag-line '<DependenciesForBisectPpx.*>:-open(DependenciesForBisectPpx)' \
    unit_tests.byte

# @todo Could we build with *one* module using bisect_ppx and measure coverage of this module by its own tests?
# Currently, a few functions are measured as covered because they are used in the test framework.

echo
echo "Running unit tests in byte code"
_build_coverage/src/unit_tests.byte
rm -f bisect????.out
_build_coverage/src/unit_tests.byte --verbose > _build_coverage/unit_tests_output.txt
echo
bisect-summary bisect????.out | grep -v -e "^100.0% \[.*\] src/" -e "^100.0% .*ForBisectPpx.ml$" -e "^  0.0% \[.*0/0.*\] src/"
echo
bisect-ppx-report -I _build_coverage -html _build_coverage/bisect bisect????.out
echo "See coverage report in $(pwd)/_build_coverage/bisect/index.html"
rm -f bisect????.out

js_of_ocaml +nat.js _build_coverage/src/unit_tests.byte

echo
echo "Running unit tests in node.js"
node _build_coverage/src/unit_tests.js
rm -f bisect????.out
echo

echo "Running demo"
demo/_build_with_lib/demo.native

if [ "x$1" == "x--quick" ]
then
    exit
fi

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
rm -rf _build_with_package
build -build-dir _build_with_package -X _build_with_lib -package General demo.byte demo.native
cd ..
