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

for OCAML_VARIANT in ${OCAML_VERSIONS:-4.02 4.03 4.03+flambda 4.04 4.04+flambda 4.05 4.05+flambda 4.06 4.06+flambda 4.07 4.07+flambda 4.08 4.08+flambda}
do
    echo "OCaml $OCAML_VARIANT"
    echo "OCaml $OCAML_VARIANT" | sed "s#.#=#g"

    date

    echo
    echo "Building docker image"
    echo "---------------------"

    OCAML_VERSION=$(echo $OCAML_VARIANT | sed "s#+.*##")
    # Uncomment next line if you're too anxious to wait for the quiet build :)
    # docker build --build-arg OCAML_VERSION=$OCAML_VERSION --build-arg OCAML_VARIANT=$OCAML_VARIANT .
    IMAGE=$(docker build --quiet --build-arg OCAML_VERSION=$OCAML_VERSION --build-arg OCAML_VARIANT=$OCAML_VARIANT .)
    RUN="docker run --rm --volume $PWD:/project --workdir /project $IMAGE"

    $RUN opam switch

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
        echo "Full report in $PWD/_builds/geni_coverage/index.html"
        $RUN coverage3 html --directory=_builds/geni_coverage
        rm .coverage
    fi

    echo
    echo "Running tests"
    echo "-------------"

    mkdir -p _builds/$OCAML_VARIANT
    rm -f _build
    ln -sf _builds/$OCAML_VARIANT _build

    # @todo Measure test coverage. If possible, module by module.
    $RUN dune runtest

    rm -rf doc/unit_tests/$OCAML_VARIANT
    mkdir -p doc/unit_tests/$OCAML_VARIANT
    $RUN _build/default/tst/run_all_tests.bc --verbose >doc/unit_tests/$OCAML_VARIANT/all.txt

    if $DO_UTOP_INTERFACE
    then
        echo
        echo "Extracting interface as seen in utop"
        echo "------------------------------------"

        rm -rf doc/utop/$OCAML_VARIANT
        mkdir -p doc/utop/$OCAML_VARIANT
        $RUN python3 doc/utop/extract.py doc/utop/$OCAML_VARIANT
    fi

    if $DO_TEST_INSTALL
    then
        echo
        echo "Testing package install"
        echo "-----------------------"

        $RUN bash -c 'opam install General && cd /tmp && echo "open General.Abbr let _ = StdOut.print \"Hello General\"">tst.ml && echo "(executable (name tst) (libraries General))">dune && dune build @all && _build/default/tst.exe && _build/default/tst.bc'
    fi

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
