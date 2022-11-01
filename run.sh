#!/bin/bash

IMAGE_NAME=$1
FLAGS=" $2 " # --rm
if [ -z $IMAGE_NAME ]; then
    echo "Where is mage name to run dude? Exiting" 1>&2
    exit
fi

#docker run -it --rm  $FLAGS --name $IMAGE_NAME --gpus all $IMAGE_NAME

#docker run -it --rm  $FLAGS --name $IMAGE_NAME $IMAGE_NAME

docker run  -it --rm $FLAGS --network=host --env DISPLAY=$DISPLAY --privileged  \
 -v "$HOME/.Xauthority:/home/dev_factory_opencv/.Xauthority"  \
 -v /tmp/.X11-unix:/tmp/.X11-unix $IMAGE_NAME
