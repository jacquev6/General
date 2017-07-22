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

build General.cmxa unit_tests.byte unit_tests.js -I demo demo.byte

_build/src/unit_tests.byte
node _build/src/unit_tests.js
_build/demo/demo.byte

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
rm -rf _build

build -package General demo.native demo.js

_build/demo.native
node _build/demo.js
cd ..
