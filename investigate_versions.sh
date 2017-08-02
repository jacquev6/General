#!/bin/bash

set -o errexit

function investigate_version {
  local OCAML_VERSION=$1
  echo "OCaml $OCAML_VERSION"
  echo "============"
  opam switch --yes ForGeneral.$OCAML_VERSION --alias-of $OCAML_VERSION
  eval `opam config env`
  opam install --yes cppo js_of_ocaml bisect_ppx bisect-summary
  git clean -fXd
  ./run_development_cycle.sh --quick
  echo
}

INITIAL_SWITCH=$(opam switch show)  # `opam switch --no-switch` switches anyway
trap "opam switch $INITIAL_SWITCH" EXIT

investigate_version 4.02.2
investigate_version 4.02.3
investigate_version 4.03.0
investigate_version 4.04.0
investigate_version 4.04.1
investigate_version 4.04.2
investigate_version 4.05.0

git clean -fXd
