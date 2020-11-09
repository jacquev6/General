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

        rm -rf src/Generated
        mkdir src/Generated
        $RUN python3 src/geni.py src/Generated
        $RUN dot src/Generated/Facets.dot -Tpng -odocs/Facets.png

        (
            grep "RESET_TYPE(" src/Reset/ResetPervasives.ml | grep -v "'" | sed "s/ *RESET_TYPE(.*, \(.*\)).*/let (_: General.\1 option) = None/" | sed "s/__/./g" | sort -u | grep -v "\.todo option) = None$";
            grep "RESET_TYPE(.*'" src/Reset/ResetPervasives.ml | sed "s/ *RESET_TYPE(.*, \(.*\)).*/let (_: _ General.\1 option) = None/" | sed "s/__/./g" | sort -u | grep -v "\.todo option) = None$";
            grep "RESET_VALUE" src/Reset/ResetPervasives.ml | sed "s/ *RESET_VALUE(.*, \(.*\)).*/let _ = General.\1/" | sed "s/__/./g" | sort -u | grep -v "\.todo$";
            echo "";
            echo "open General.Abbr";
            echo "";
            echo "let () =";
            echo "  let argv = Li.of_array OCamlStandard.Sys.argv in";
            echo "  Exit.exit (Tst.command_line_main ~argv General.Tests.test)";
        ) > unit_tests.ml

        (
            echo "(rule";
            echo "  (targets General.mli)";
            echo "  (deps";
            echo "    (:src General.cppo.mli)";
            echo "    geni.py";
            (
                find src -type f -name "*.signatures*.ml" -or -name "*.makers*.mli";
                find src/Reset -type f -not -name "DefinitionHeader.ml";
                find src/Generated -type f -name "*.mli";
            ) | sed "s|src/|    |" | sort -u
            echo "  )";
            echo "  (action (run %{bin:cppo} -V OCAML:%{ocaml_version} %{src} -o %{targets}))";
            echo ")";
            echo "";
            echo "(rule";
            echo "  (targets General.ml)";
            echo "  (deps";
            echo "    (:src General.cppo.ml)";
            echo "    geni.py";
            (
                find src -type f -name "*.ml" -not -name "SignatureHeader.ml" -not -name "General.cppo.ml";
            ) | sed "s|src/|    |" | sort -u
            echo "  )";
            echo "  (action (run %{bin:cppo} -V OCAML:%{ocaml_version} %{src} -o %{targets}))";
            echo ")";
            echo "";
            echo "(library";
            echo "  (name General)";
            echo "  (public_name General)";
            echo "  (modules General)";
            echo "  (libraries num)";
            echo "  (flags (:standard -nopervasives -w @A-4-33-44-45-48-67-60))";
            echo ")";
        ) > src/dune
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
