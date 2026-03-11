#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="opa-spec-site"
CONTAINER_NAME="opa-spec-dev"
PORT="${PORT:-4000}"

usage() {
    echo "Usage: $0 {serve|build|stop}"
    echo
    echo "Commands:"
    echo "  serve   Build the Docker image and serve the site at http://localhost:${PORT}/"
    echo "  build   Build the site into _site/ without serving"
    echo "  stop    Stop the running dev server container"
    echo
    echo "Environment variables:"
    echo "  PORT    Port to serve on (default: 4000)"
}

build_image() {
    echo "Building Docker image '${IMAGE_NAME}'..."
    docker build -t "${IMAGE_NAME}" .
}

case "${1:-}" in
    serve)
        build_image
        # Remove any existing container with the same name
        docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
        echo "Starting dev server at http://localhost:${PORT}/"
        docker run --rm --name "${CONTAINER_NAME}" \
            -p "${PORT}:4000" \
            -v "$(pwd):/site" \
            "${IMAGE_NAME}"
        ;;
    build)
        build_image
        docker run --rm \
            -v "$(pwd):/site" \
            "${IMAGE_NAME}" \
            bundle exec jekyll build
        echo "Site built to _site/"
        ;;
    stop)
        echo "Stopping container '${CONTAINER_NAME}'..."
        docker stop "${CONTAINER_NAME}" 2>/dev/null || echo "Container not running."
        ;;
    *)
        usage
        exit 1
        ;;
esac
