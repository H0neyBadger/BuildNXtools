set -euxo pipefail
container="switch_build:latest"

pushd ./docker
docker build -t "$container" .
popd
docker run --rm -v $(pwd):/build/ --workdir=/build/ --entrypoint ./run.sh "$container"

