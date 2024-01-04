#!/bin/bash

echo "id:$(id)"
echo "whoami:$(whoami)"
echo "USER:$USER"

pushd .
cd ~/src/examples/DisplayImage

bash build.sh \
 && cd build \
 && ./DisplayImage ../data/girl.jpeg 

popd

