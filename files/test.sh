#!/bin/bash

pushd -n $(pwd)

cd

# Print out info
./sysinfo.sh

cd $HOME/opencv/build/bin
# https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html
export OPENCV_TEST_DATA_PATH=$HOME/opencv_extra/testdata
./opencv_test_core 2>&1 | tee $HOME:/test.result.opencv_test_core.log
./opencv_test_dnn  2>&1 | tee $HOME/test.result.opencv_test_dnn.log

popd

