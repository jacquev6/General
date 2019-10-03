ARG OCAML_VERSION=4.02

FROM ocaml/opam2:debian-10-ocaml-${OCAML_VERSION}

RUN sudo apt-get update && \
    sudo apt-get install --yes m4 npm python3 python3-pip graphviz && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo pip3 install coverage

WORKDIR /project

ARG OCAML_VARIANT=4.02

RUN opam switch ${OCAML_VARIANT} && \
    eval $(opam env) && \
    opam install utop

COPY General.opam .

RUN eval $(opam env) && \
    opam pin add --no-action --kind=path . && \
    opam install General --deps-only --with-test
