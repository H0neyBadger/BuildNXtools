set -euxo pipefail
container="switch_build:latest"

pushd ./docker
docker build \
    --pull \
    --build-arg OWNER_UID="${SUDO_UID}" \
    --build-arg OWNER_GID="${SUDO_GID}" \
    -t "$container" .
popd

docker run --rm -v $(pwd):/build/ --workdir=/build/ --entrypoint ./run.sh "$container"

