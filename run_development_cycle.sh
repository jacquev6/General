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

cd src
ocamlbuild -use-ocamlfind -no-links General.cma
cd ..

opam pin add --yes --no-action .
opam reinstall --yes General

cd demo
ocamlbuild -use-ocamlfind -no-links demo.byte demo.native
cd ..

demo/_build/demo.byte
demo/_build/demo.native
