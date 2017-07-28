#!/bin/bash

set -o errexit

function build {
    ocamlbuild \
        -use-ocamlfind -no-links \
        -plugin-tag "package(cppo_ocamlbuild)" \
        -plugin-tag "package(js_of_ocaml.ocamlbuild)" \
        $@
}

for directory in $(find src -mindepth 1 -type d)
do
    echo "Rebuilding ${directory}.mlpack from $directory's contents"
    ls $directory/*.ml* | grep -v "_\.ml" | sed "s#\..*##" | sort -u >${directory}.mlpack
    ls $directory/*_.ml*                  | sed "s#\..*##" | sort -u >${directory}_.mlpack
done

build -I demo -build-dir _build_native \
    ResetPervasives.inferred.mli \
    General.cmxa unit_tests.native demo.native

python3 <<END
def complete_definitions():
    with open("_build_native/src/ResetPervasives.inferred.mli") as f:
        current_line = None
        for line in f:
            if line.startswith("  "):
                current_line += " " + line.strip()
            else:
                if current_line is not None:
                    yield current_line
                current_line = line.strip()
        yield current_line

ok = True
for line in complete_definitions():
    if all(x not in line for x in [
        "\`Please_use_General_",
        "\`You_should_not_be_using_that",
    ]) and all(not line.startswith(prefix) for prefix in [
        "external __LOC__",
        "external __FILE__",
        "external __LINE__",
        "external __MODULE__",
        "external __POS__",
        "external __LOC_OF__",
        "external __LINE_OF__",
        "external __POS_OF__",
        "type ",
        "exception ",
        "module ",
    ]):
        ok = False
        print("Not overriden in Pervasives:", line)

if not ok:
    exit(1)
END

grep "\`Please_use_" _build_native/src/ResetPervasives.inferred.mli \
| sed "s/.*\`Please_use_\(.*\) ]/let _ = \1/" | sed "s/__/./g" \
| grep -v todo \
> demo/demo_pervasives.ml

build -I demo \
    -package bisect_ppx -tag debug \
    -tag-line 'true:+open(DependenciesForBisectPpx)' \
    -tag-line '<DependenciesForBisectPpx.*>:-open(DependenciesForBisectPpx)' \
    General.cma unit_tests.byte unit_tests.js demo.byte demo_pervasives.byte

# @todo Could we build with *one* module using bisect_ppx and measure coverage of this module by its own tests?
# Currently, a few functions are measured as covered because they are used in the test framework.

echo
echo "Running unit tests in node.js"
node _build/src/unit_tests.js
echo

rm -f bisect????.out
echo "Running unit tests in byte code"
_build/src/unit_tests.byte
_build/src/unit_tests.byte --verbose > _build/unit_tests_output.txt
echo
bisect-summary bisect????.out | grep -v -e "^100.0% \[.*\] src/" -e "^100.0% .*ForBisectPpx.ml$" -e "^  0.0% \[.*0/0.*\] src/"
echo
bisect-ppx-report -I _build -html _build/bisect bisect????.out
echo "See coverage report in $(pwd)/_build/bisect/index.html"
echo
rm -f bisect????.out

echo "Running demo"
_build_native/demo/demo.native

if [ "x$1" == "x--quick" ]
then
    exit
fi

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
rm -rf _build
build -package General demo.native demo.js
cd ..
