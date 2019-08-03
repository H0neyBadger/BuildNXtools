set -euxo pipefail
container="switch_build:latest"

pushd ./container
podman build \
    --pull \
    -t "$container" .
popd

podman run --rm -it -v "$(pwd):/build/" --workdir=/build/ "$container" "${1}"

