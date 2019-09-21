#!/bin/bash

set -o errexit

DO_UTOP_INTERFACE=true
DO_TEST_INSTALL=true

while [[ "$#" > 0 ]]
do
  case $1 in
    -q|--quick)
      DO_UTOP_INTERFACE=false
      DO_TEST_INSTALL=false
      ;;
    *)
      echo "Unknown parameter passed: $1"
      exit 1;;
  esac
  shift
done

GENERATE_CODE=true

for OCAML_VERSION in ${OCAML_VERSIONS:-4.02 4.03 4.04 4.05 4.06 4.07 4.08}
do
    echo "OCaml $OCAML_VERSION"
    echo "=========="

    date

    echo
    echo "Building docker image"
    echo "---------------------"

    # Uncomment next line if you're too anxious to wait for the quiet build :)
    # docker build --build-arg OCAML_VERSION=$OCAML_VERSION .
    IMAGE=$(docker build --quiet --build-arg OCAML_VERSION=$OCAML_VERSION .)
    RUN="docker run --rm --volume $PWD:/project --workdir /project $IMAGE"

    mkdir -p _builds/$OCAML_VERSION
    rm -f _build
    ln -sf _builds/$OCAML_VERSION _build

    if $GENERATE_CODE
    then
        echo
        echo "Generating code"
        echo "---------------"

        GENERATE_CODE=false

        $RUN coverage3 run --branch -m geni
        echo
        echo "Geni coverage:"
        $RUN coverage3 report --show-missing
        echo "Full report in $PWD/_builds/$OCAML_VERSION/geni_coverage/index.html"
        $RUN coverage3 html --directory=_build/geni_coverage
        rm .coverage
    fi

    echo
    echo "Running tests"
    echo "-------------"

    # @todo Measure test coverage. If possible, module by module.
    $RUN dune runtest

    if $DO_UTOP_INTERFACE
    then
        echo
        echo "Extracting interface as seen in utop"
        echo "------------------------------------"

        rm -rf doc/utop/$OCAML_VERSION
        mkdir -p doc/utop/$OCAML_VERSION
        $RUN python3 doc/utop/extract.py doc/utop/$OCAML_VERSION
    fi

    if $DO_TEST_INSTALL
    then
        echo
        echo "Testing package install"
        echo "-----------------------"

        $RUN opam install General
    fi

    # @todo Build demo apps (as native, byte code, and js)

    # @todo Integrate validation of ResetPervasives with dune:
    # in a demo app, check that:
    #  - all symbols in OCamlStandard.Pervasives are reset in ResetPervasives
    #  - all symbols in ResetPervasives do exist in OCamlStandard.Pervasives
    # Symbols: modules, types, exceptions, values, externals

    rm _build

    echo
done

echo
echo "Development cycle OK"

# @todo Build doc
# if (which sphinxcontrib-ocaml-autodoc && which sphinx-build) >/dev/null
# then
#     echo
#     echo "Building doc"
#     echo

#     rm -rf _build/sphinx  # Keep while we're developing the Sphinx extension
#     sphinx-build doc _build/sphinx/html -d _build/sphinx/doctrees
#     rm -rf docs
#     cp -r _build/sphinx/html docs
#     touch docs/.nojekyll
#     rm -f docs/.buildinfo
#     echo
#     echo "See documentation in $(pwd)/docs/index.html"
# else
#     echo
#     echo "Not trying to build doc because autoocamldoc or sphinx-build is missing"
# fi
