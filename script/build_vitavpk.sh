#!/bin/sh
set -eu

target=${1:-all}
export VITASDK=${VITASDK:-${2:-/opt/vitasdk}}
export PATH="$VITASDK/bin:$PATH"
export CMAKE_BUILD_PARALLEL_LEVEL=${CMAKE_BUILD_PARALLEL_LEVEL:-4}

project_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cmake -S "$project_dir" -B "$project_dir/build" -G "Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE="$VITASDK/share/vita.toolchain.cmake" \
    -DCMAKE_BUILD_TYPE="${VITA_BUILD_TYPE:-Release}"
cmake --build "$project_dir/build" --target "$target"
