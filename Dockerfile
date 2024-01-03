FROM ubuntu:22.04
MAINTAINER Pavel Taranov <pavel.a.taranov@gmail.com>




#To skip setting itimezonei, to set timezone: echo "Australia/Adelaide" | sudo tee /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive




# Basic tools
RUN apt update \
 && apt install -y wget \
                   curl \
                   tree \
                   gawk \
                   zip \
                   lsof \
                   mc \
                   vim \
                   tmux \
                   less \
                   git \
                   tig \
                   net-tools \
                   iproute2 \
                   cmake \
                   build-essential \
                   x11-apps \
# Python3 \
                   python3 \
                   python3-pip \
                   python3-venv \
                   python3-distutils \
# Cleanup apt \
 && apt clean \
# Setup mc \
 && echo "regex/i/\.(md|log|txt|js|json|ejs|yml|j2|cfg|xml|sql|py|ipynb)$\n    Include=editor" | tee -a /etc/mc/mc.ext




# Install python packages
# libgl1 - Fixing ImportError: libGL.so.1: cannot open shared object file: No such file or directory
RUN apt update \
 && apt install -y libsm6 libxext6 libxrender-dev libgl1 \
 && pip install numpy opencv-python \
# Cleanup apt \
 && apt clean




RUN apt update \
 && apt install -y libgtk2.0-dev pkg-config \
# Cleanup apt \
 && apt clean




# Create user
####ARG UID=2100
####ARG GID=2100
####ENV USER=dev_factory_opencv_sdk
####ENV USER_NAME=$USER
####RUN groupadd --gid $GID $USER_NAME \
#### && useradd --uid $UID --gid $GID --shell /bin/bash --create-home $USER_NAME
ENV USER=dev_factory_opencv_sdk
ENV USER_NAME=$USER
RUN useradd --shell /bin/bash --create-home $USER_NAME

USER $USER_NAME

# Setup vim
RUN echo "set tabstop=4\nset shiftwidth=4\nset softtabstop=4\nset expandtab" | tee -a /home/$USER_NAME/.vimrc \
 && echo "export EDITOR=vim" | tee -a /home/$USER_NAME/.bashrc




# https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html
ARG VERSION=4.6.0




## Use locally stored files
#COPY files/opencv/archive/$VERSION}.zip /home/$USER_NAME/opencv.zip
#COPY files/opencv_contrib/archive/$VERSION}.zip /home/$USER_NAME/opencv_contrib.zip
#COPY files/opencv_extra/archive/$VERSION}.zip /home/$USER_NAME/opencv_extra.zip




# Download files from remote
RUN cd /home/$USER_NAME \
    && wget https://github.com/opencv/opencv/archive/$VERSION.zip -O opencv.zip \
    && wget https://github.com/opencv/opencv_contrib/archive/$VERSION.zip -O opencv_contrib.zip \
    && wget https://github.com/opencv/opencv_extra/archive/$VERSION.zip -O opencv_extra.zip 




# https://www.pyimagesearch.com/2016/07/11/compiling-opencv-with-cuda-support/
RUN cd /home/$USER_NAME \
    && unzip ./opencv.zip \
    && rm ./opencv.zip \
    && unzip ./opencv_contrib.zip \
    && rm ./opencv_contrib.zip\
    && unzip ./opencv_extra.zip \
    && rm ./opencv_extra.zip \
    && ln -s ./opencv-$VERSION opencv \
    && ln -s ./opencv_contrib-$VERSION opencv_contrib \
    && ln -s ./opencv_extra-$VERSION opencv_extra \
    && mkdir -p opencv/build \
    && cd opencv/build \
    && cmake -D CMAKE_INSTALL_PREFIX=/usr/local \
##  # Have specify compute capability to fix tis error:
##  #     CUDA backend for DNN module requires CC 5.3 or higher.  Please remove unsupported architectures from CUDA_ARCH_BIN option.
##  # -D CUDA_ARCH_BIN="3.0 3.5 3.7 5.0 5.2 6.0 6.1 7.0 7.5"
##      -D WITH_CUDA=ON \
##      -D ENABLE_FAST_MATH=1 \
##      -D CUDA_FAST_MATH=1 \
##      -D WITH_CUBLAS=1 \
##      -D CUDA_ARCH_BIN="6.0 6.1 7.0 7.5" \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON .. | tee 1.cmake \
    && make -j$(nproc) | tee 2.make




# Installing opencv
USER root
RUN cd /home/$USER_NAME/opencv/build \
    && make -j$(nproc) install | tee 3.make.install
##  # && cd .. \
##  # && rm -rf ./build




USER $USER_NAME
COPY --chown=$USER_NAME:$USER_NAME \
     files/entrypoint.sh \
     files/sysinfo.sh \
     files/test.sh \
     files/test.performance.sh \
     files/test.python.sh \
     /home/$USER_NAME/




ENTRYPOINT /home/$USER_NAME/entrypoint.sh

