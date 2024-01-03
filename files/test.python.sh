#!/bin/bash

pushd -n $(pwd)

cd

# Print out info
./sysinfo.sh

export OPENCV_SAMPLES_DATA_PATH=$HOME/opencv/samples/data
python3 /usr/local/share/opencv4/samples/python/digits.py 2>&1 | tee $HOME/test.result.python_digits.log

popd

