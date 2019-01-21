#!/bin/bash

set -e

mkdir -p ${SRC_DIR}/build_conda
cd ${SRC_DIR}/build_conda

# quick overview of config:
../configure \
    --prefix=${PREFIX} \
    --with-libiconv-prefix=${PREFIX} \
    --enable-languages=c,fortran \
    --with-tune=generic \
    --disable-multilib \
    --enable-checking=release \
    --disable-bootstrap \
    --build=${macos_machine} \
    --with-gmp=${PREFIX} \
    --with-mpfr=${PREFIX} \
    --with-mpc=${PREFIX} \
    --with-isl=${PREFIX}

# using || to quiet logs unless there is an issue
{
    make -j"${CPU_COUNT}" >& make_logs.txt
} || {
    cat make_logs.txt
    exit 1
}
