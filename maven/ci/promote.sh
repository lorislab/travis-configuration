#!/bin/bash
set -e

# login to docker registry
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# docker images
export DOCKER_IMAGE=$TRAVIS_REPO_SLUG:${TRAVIS_COMMIT::7}
export DOCKER_IMAGE_PROMOTED=$TRAVIS_REPO_SLUG:$TRAVIS_TAG

# pull the docker image
docker pull $DOCKER_IMAGE
# tag the docker image
docker tag $DOCKER_IMAGE $DOCKER_IMAGE_PROMOTED
# push the docker image
docker push $DOCKER_IMAGE_PROMOTED
