#!/bin/bash
set -euxo pipefail

git_update() {
    # set +e
    git clone --recursive --depth=1 \
    "$1" "$2" || (cd "$2"; git pull; git submodule sync)
    # set -e
}



echo "Downloading git repos"
git_update "https://github.com/reswitched/libtransistor-base.git" "./libtransistor-base"
git_update "https://github.com/reswitched/libtransistor.git" "./libtransistor"


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

pushd "./libtransistor"
echo "Setting up libtransistor env"
[ ! -L ./dist ] && ln -s ../libtransistor-base/dist ./dist
echo "Build libtransistor"
make clean
make
popd


