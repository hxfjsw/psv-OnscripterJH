#!/usr/bin/env bash
set -euo pipefail

export VITASDK=${1:-${VITASDK:-/opt/vitasdk}}
export VITASDK_CHANNEL=${VITASDK_CHANNEL:-2026.08}
export VDPM_NONINTERACTIVE=1
export PATH="$VITASDK/bin:$PATH"

if [ ! -x "$VITASDK/bin/vdpm" ]; then
    bootstrap=$(mktemp)
    trap 'rm -f "$bootstrap"' EXIT
    # VitaSDK vdpm v0.1.6
    curl --fail --location --silent --show-error --retry 3 \
        https://raw.githubusercontent.com/vitasdk/vdpm/74112e6d2c8d120f4e8fe3dc9e1df88d214537f7/bootstrap-vitasdk.sh \
        -o "$bootstrap"
    bash "$bootstrap"
fi

vdpm install \
    sdl2 sdl2_image sdl2_mixer sdl2_ttf libvita2d libvita2d_ext bzip2 libpng \
    libjpeg-turbo libwebp zlib flac mpg123 libvorbis libogg libmikmod libmodplug \
    luajit freetype vita-rss-libdl taihen
