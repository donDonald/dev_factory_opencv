#!/bin/bash

echo "id:$(id)"
echo "whoami:$(whoami)"
echo "USER:$USER"

pushd .
cd ~/src/examples/DisplayImage

rm -rf ./build \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc)

popd

