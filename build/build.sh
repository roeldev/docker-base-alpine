#!/bin/bash

BUILD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PROJECT_DIR=$( dirname "${BUILD_DIR}" )

ALPINE_VERSION=$1
IMAGE_VERSION=${ALPINE_VERSION}-local
BUILD_DATE=$( date -u +"%Y-%m-%dT%H:%M:%SZ" )
GIT_REF=$( git rev-parse --short HEAD )
TRAVIS=${TRAVIS:=true}
LATEST=false

# fail on missing git ref
if [[ -z ${GIT_REF} ]]
then
    exit 1
fi

 # extract vars from .travis.yml when they are not set
MAINTAINER=${MAINTAINER:=$( ${BUILD_DIR}/.parse-yml.sh "MAINTAINER" )}
GITHUB_REPO=${GITHUB_REPO:=$( ${BUILD_DIR}/.parse-yml.sh "GITHUB_REPO" )}
DOCKER_REPO=${DOCKER_REPO:=$( ${BUILD_DIR}/.parse-yml.sh "DOCKER_REPO" )}

# get description from github when not set
DESCRIPTION=${DESCRIPTION:=$( \
    curl -s https://api.github.com/repos/${GITHUB_REPO} \
    | grep "description" \
    | cut -d : -f 2 \
    | cut -d '"' -f 2
)}

# only for local...
if ${TRAVIS}
then
    # if [[ ${TRAVIS_BRANCH} == "master" ]]
    # then
    #     exit 1
    # fi

    if [[ ${TRAVIS_BRANCH} == ${TRAVIS_TAG} ]]
    then
        IMAGE_VERSION=${ALPINE_VERSION}-${TRAVIS_TAG}
        LATEST=true
    else
        IMAGE_VERSION=${ALPINE_VERSION}-experimental
    fi
fi

echo Build Docker image ${DOCKER_REPO}:${IMAGE_VERSION}...
echo
echo Maintainer: ${MAINTAINER}
echo Description: ${DESCRIPTION}
echo GitHub repo: ${GITHUB_REPO}
echo Docker Hub repo: ${DOCKER_REPO}
echo Image version tag: ${IMAGE_VERSION}
echo Build date: ${BUILD_DATE}
echo Git commit ref: ${GIT_REF}
echo

docker build \
    --build-arg "ALPINE_VERSION=${ALPINE_VERSION}" \
    --label "maintainer=${MAINTAINER}" \
    --label "description=${DESCRIPTION}" \
    --label "org.label-schema.name=index.docker.io/${DOCKER_REPO}" \
    --label "org.label-schema.version=${IMAGE_VERSION}" \
    --label "org.label-schema.build-date=${BUILD_DATE}" \
    --label "org.label-schema.vcs-ref=${GIT_REF}" \
    --label "org.label-schema.vcs-url=https://github.com/${GITHUB_REPO}" \
    --label "org.label-schema.schema-version=1.0" \
    --file "${PROJECT_DIR}/Dockerfile" \
    --tag "${DOCKER_REPO}:${IMAGE_VERSION}" \
    "${PROJECT_DIR}"

if ${LATEST}
then
    echo Use image as latest
    docker tag ${DOCKER_REPO}:${IMAGE_VERSION} ${DOCKER_REPO}:${ALPINE_VERSION}-latest
    docker tag ${DOCKER_REPO}:${IMAGE_VERSION} ${DOCKER_REPO}:${ALPINE_VERSION}
fi
