#!/bin/bash

IMAGE_NAME=$1
DOCKER_FILE=${2:-"./Dockerfile"}
FLAGS=" $3 "
if [ -z $IMAGE_NAME ]; then
    echo "Where is image name to build dude? Exiting" 1>&2
    exit
fi

docker build -t $IMAGE_NAME $FLAGS -f $DOCKER_FILE  .
#docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t $IMAGE_NAME $FLAGS -f $DOCKER_FILE  .



