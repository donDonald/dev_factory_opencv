#!/bin/bash

IMAGE_NAME=${1:-"dev_factory_opencv_sdk"}
FLAGS=" $2 "

docker run \
    -it \
    --rm \
    $FLAGS \
    --network=host \
    --env DISPLAY=$DISPLAY \
    --privileged  \
    -v "$HOME/.Xauthority:/home/dev_factory_opencv_sdk/.Xauthority"  \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source="$(pwd)"/src,target=/home/dev_factory_opencv_sdk/src \
    --name $IMAGE_NAME \
    $IMAGE_NAME

