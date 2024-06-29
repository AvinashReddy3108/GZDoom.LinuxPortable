#!/usr/bin/env bash

# ===== [1/2] ZMusic =====

# Prepare for build
mkdir -pv parts/zmusic/source_code/build

# Build
cd parts/zmusic/source_code/build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && make install

# ========================

# Move to workspace directory
cd "${OLDPWD}"

# ===== [2/2] GZDoom =====

# Prepare for build
mkdir -pv gzdoom/source_code/build

# Build
cd parts/gzdoom/source_code/build
cmake .. -DNO_GTK=ON -DCMAKE_BUILD_TYPE=Release && make

# ========================

# Move to workspace directory
cd "${OLDPWD}"
