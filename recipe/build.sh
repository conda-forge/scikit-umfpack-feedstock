#!/bin/bash

cat <<EOF > site.cfg
[umfpack]
include_dirs = $PREFIX/include/suitesparse
library_dirs = $PREFIX/lib
EOF

$PYTHON -m pip install --no-build-isolation --no-deps -vv .
