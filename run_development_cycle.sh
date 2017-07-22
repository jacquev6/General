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

ocamlbuild -use-ocamlfind -no-links General.cmxa -I demo demo.byte
_build/demo/demo.byte

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
ocamlbuild -use-ocamlfind -no-links -package General demo.native
_build/demo.native
cd ..

