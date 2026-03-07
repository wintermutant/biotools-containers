#!/bin/bash
# Build script for kofam_scan container

set -e

VERSION=${1:-"latest"}
REGISTRY="ghcr.io/wintermutant"
IMAGE_NAME="kofam_scan"

echo "Building kofam_scan container version: $VERSION"
echo "Target: $REGISTRY/$IMAGE_NAME:$VERSION"

# Build for both architectures
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t $REGISTRY/$IMAGE_NAME:$VERSION \
  --push \
  .

echo "Successfully built and pushed $REGISTRY/$IMAGE_NAME:$VERSION"
