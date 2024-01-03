#!/bin/bash

pushd -n $(pwd)

cd

# Print out info
./sysinfo.sh

cd $HOME/opencv/build/bin
# https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html
export OPENCV_TEST_DATA_PATH=$HOME/opencv_extra/testdata
./opencv_perf_core 2>&1          | tee $HOME/test.result.opencv_perf_core.log
./opencv_perf_dnn 2>&1           | tee $HOME/test.result.opencv_perf_dnn.log
./opencv_perf_objdetect 2>&1     | tee $HOME/test.result.opencv_perf_objdetect.log
./opencv_perf_cudaobjdetect 2>&1 | tee $HOME/test.result.opencv_perf_cudaobjdetect.log

popd

