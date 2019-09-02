ARG OCAML_VERSION=4.02

FROM ocaml/opam2:debian-10-ocaml-${OCAML_VERSION}

RUN sudo apt-get update && \
    sudo apt-get install --yes m4 npm && \
    sudo rm -rf /var/lib/apt/lists/*

WORKDIR /project

COPY General.opam .

RUN opam pin add --no-action --kind=path . && \
    opam install General --deps-only --with-test
