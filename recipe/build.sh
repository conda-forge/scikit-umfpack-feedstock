#!/bin/bash
set -ex

# Help SuiteSparse headers/libs be found
export CFLAGS="$CFLAGS -I${PREFIX}/include -I${PREFIX}/include/suitesparse"
export LDFLAGS="$LDFLAGS -L${PREFIX}/lib"

# Drop '--buildtype release' because meson-python sets buildtype itself
MESON_SETUP_ARGS=""
if [[ -n "${MESON_ARGS:-}" ]]; then
    MESON_ARGS_REDUCED="${MESON_ARGS/--buildtype release/}"
    MESON_SETUP_ARGS="-Csetup-args=${MESON_ARGS_REDUCED// / -Csetup-args=}"
fi

"${PYTHON}" -m pip install . \
     --no-build-isolation \
     --no-deps \
     -vv \
     ${MESON_SETUP_ARGS}
