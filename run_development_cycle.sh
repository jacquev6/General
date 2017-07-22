#!/bin/bash

set -o errexit

function build {
    ocamlbuild \
        -use-ocamlfind -no-links \
        -plugin-tag "package(cppo_ocamlbuild)" \
        -plugin-tag "package(js_of_ocaml.ocamlbuild)" \
        $@
}

for pack in $(git ls-files "*.mlpack")
do
    directory=${pack%.mlpack}
    if [ -d $directory ]
    then
        # echo "Rebuilding $pack from $directory's contents"
        ls $directory | grep "^.*\.ml.*$" | sed "s/\.ml.*//" | sort -u >$pack
    fi
done

build -package bisect_ppx General.cmxa unit_tests.byte unit_tests.js -I demo demo.byte

echo
echo "Running unit tests in node.js"
node _build/src/unit_tests.js
echo

echo "Running unit tests in byte code"
rm -f bisect????.out
_build/src/unit_tests.byte
echo
bisect-summary bisect0001.out
echo
bisect-ppx-report -html _build/bisect bisect0001.out
echo "See coverage report in $(pwd)/_build/bisect/index.html"
echo
rm -f bisect????.out

if [ "x$1" == "x--quick" ]
then
    exit
fi

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
rm -rf _build

build -package General demo.native demo.js

node _build/demo.js
cd ..
