#!/bin/bash
set -euxo pipefail

git_update() {
    # set +e
    git clone --recursive --depth=1 \
    "$1" "$2" || (cd "$2"; git pull; git submodule sync)
    # set -e
}

simple_make(){
    pushd "$1"
    make clean
    make
    popd
}


echo "Downloading git repos"
git_update "https://github.com/reswitched/libtransistor-base.git" "./libtransistor-base"
git_update "https://github.com/reswitched/libtransistor.git" "./libtransistor"
git_update "https://github.com/switchbrew/switch-tools.git" "./switch-tools"
git_update "https://github.com/switchbrew/libnx.git" "./libnx"
git_update "https://github.com/CTCaer/hekate.git" "./hekate"
git_update "https://github.com/reswitched/fusee-launcher.git" "./fusee-launcher"
git_update "https://github.com/Reisyukaku/ReiNX.git" "./ReiNX"
git_update "https://github.com/Adubbz/Tinfoil.git" "./Tinfoil"
# Use sfml from pacman
#git_update "https://github.com/SFML/SFML.git" "./SFML"
git_update "https://github.com/switchbrew/nx-hbmenu.git" "./nx-hbmenu"

echo "Build Config"

pushd "./libtransistor-base"
echo "Build libtransistor-base"
virtualenv ./.venv
set +eu
source ./.venv/bin/activate
set -eu 
# pip install -U https://github.com/eliben/pyelftools/archive/master.tar.gz
pip install -U -r ./requirements.txt
make distclean
make
popd

echo "Setting up libtransistor env"
[ ! -L ./libtransistor/dist ] && ln -s ../libtransistor-base/dist/ ./libtransistor/dist

echo "Build libtransistor"
simple_make "./libtransistor"

# deactivate python virtualenv
deactivate

echo "Build switch-tools"
pushd "./switch-tools"
./autogen.sh
popd

PATH="${PATH}:$(pwd)/switch-tools/"
PATH="${PATH}:${DEVKITARM}/bin"
PATH="${PATH}:${DEVKITPRO}/portlibs/switch/bin/"
PATH="${PATH}:${DEVKITPRO}/tools/bin/"
export PATH="${PATH}"

echo "Build libnx"
simple_make "./libnx"

echo "Build hekate"
simple_make "./hekate"

echo "Build fusee-launcher"
simple_make "./fusee-launcher"

#echo "Build SFML"
#pushd "./SFML"
#cmake .
#popd

echo "Build nx-hbmenu"
export PKG_CONFIG_PATH="${DEVKITPRO}/portlibs/switch/lib/pkgconfig/"
simple_make "./nx-hbmenu"

echo "Build ReiNX"
simple_make "./ReiNX"

echo "Build /Tinfoil"
simple_make "./Tinfoil"

