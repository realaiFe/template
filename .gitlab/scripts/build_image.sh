#!/bin/bash
source .gitlab/scripts/utils.sh

function docker_build() {
  set -o errexit
  short_sha="${CI_COMMIT_SHA:0:8}"  # 提取前8个字符
  tag="${DOCKER_TAG}_${short_sha}"
  msg_info "${CI_PROJECT_NAME} 镜像地址: $DOCKER_IMAGE:$tag"
  msg_info "${CI_PROJECT_NAME} 镜像tag: $tag"
  docker login $DOCKER_IMAGE -u $DOCKER_USERNAME -p '$DOCKER_PASS'

  docker build \
      -t $DOCKER_IMAGE:$tag \
      -f ./Dockerfile \
      .
      docker push $DOCKER_IMAGE:$tag
}
