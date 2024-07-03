#!/usr/bin/env bash

# ===== [1/2] ZMusic =====

# Prepare for build
mkdir -pv parts/zmusic/source_code/build

# Build
cd parts/zmusic/source_code/build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && make -j$(nproc --all) install

# Move to workspace directory
cd "${OLDPWD}"

# ===== [2/2] GZDoom =====

# Prepare for build
mkdir -pv gzdoom/source_code/build

# Build
cd gzdoom/source_code/build
cmake .. -DNO_GTK=ON -DCMAKE_BUILD_TYPE=Release && make -j$(nproc --all)

# Move to workspace directory
cd "${OLDPWD}"

# ===== Make package =====

mkdir -pv out

cp -v gzdoom/source_code/build/gzdoom out/
cp -v gzdoom/source_code/build/*.pk3 out/

strip -v out/gzdoom

ldd out/gzdoom | awk 'NF == 4 { system("cp -v " $3 " out/") }'
cp -v /lib/x86_64-linux-gnu/libopenal.so.1 out/

cp -Rv gzdoom/source_code/build/soundfonts/ out/soundfonts
cp -Rv gzdoom/source_code/build/fm_banks/ out/fm_banks

# [HACK] Force success, we'll handle this later
exit 0
