#!/bin/bash

set -o errexit

for pack in $(git ls-files "*.mlpack")
do
    directory=${pack%.mlpack}
    if [ -d $directory ]
    then
        # echo "Rebuilding $pack from $directory's contents"
        ls $directory | grep "^.*\.ml.*$" | sed "s/\.ml.*//" | sort -u >$pack
    fi
done

ocamlbuild -use-ocamlfind -no-links -plugin-tag "package(cppo_ocamlbuild)" General.cmxa unit_tests.byte -I demo demo.byte
_build/src/unit_tests.byte
_build/demo/demo.byte

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
rm -rf _build
ocamlbuild -use-ocamlfind -no-links -plugin-tag "package(cppo_ocamlbuild)" -package General demo.native
_build/demo.native
cd ..
