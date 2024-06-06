#!/bin/bash

export CFLAGS="${CFLAGS} -I$PREFIX/include/suitesparse"
export UMFPACK="${PREFIX}/lib"

$PYTHON -m pip install --no-deps --ignore-installed -vv .
