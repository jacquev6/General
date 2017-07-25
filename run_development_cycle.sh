#!/bin/bash

set -o errexit

function build {
    ocamlbuild \
        -use-ocamlfind -no-links \
        -plugin-tag "package(cppo_ocamlbuild)" \
        -plugin-tag "package(js_of_ocaml.ocamlbuild)" \
        $@
}

for pack in $(git ls-files "*.mlpack" --exclude "*_.mlpack")
do
    directory=${pack%.mlpack}
    if [ -d $directory ]
    then
        # echo "Rebuilding $pack from $directory's contents"
        ls $directory | grep -v "_\.ml" | grep "^.*\.ml.*$" | sed "s#\(.*\)\.ml.*#$directory/\1#" | sort -u >${directory}.mlpack
        ls $directory | grep    "_\.ml" | grep "^.*\.ml.*$" | sed "s#\(.*\)\.ml.*#$directory/\1#" | sort -u >${directory}_.mlpack
    fi
done

build -I demo -build-dir _build_native \
    General.cmxa unit_tests.native demo.native

build -I demo \
    -package bisect_ppx \
    -tag-line 'true:+open(OperatorForBisectPpx)' \
    -tag-line '<OperatorForBisectPpx.*>:-open(OperatorForBisectPpx)' \
    General.cma unit_tests.byte unit_tests.js demo.byte

echo
echo "Running unit tests in node.js"
node _build/src/unit_tests.js
echo

rm -f bisect????.out
echo "Running unit tests in byte code"
_build/src/unit_tests.byte
echo
bisect-summary bisect0001.out
echo
bisect-ppx-report -I _build -html _build/bisect bisect0001.out
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
