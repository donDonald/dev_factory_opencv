## Intro
  Docker image with opencv 4.6.0




## To pull the image
```
$ docker pull <registry>:<port>/dev_factory_opencv:4.6.0
```




## To build the image
```
$ bash ./build.sh dev_factory_opencv
```




## Enable X server access
Have to enable access to hosts' X server to let X apps running on hosts's DISPLAY
```
$ xhost +local: 
```




## To run the image
```
$ bash ./run.sh dev_factory_opencv
```




## To test the image
```
$ bash ./run.sh dev_factory_opencv --entrypoint="/home/dev_factory_opencv/test.sh"
```




## To test python example
```
$ bash ./run.sh dev_factory_opencv --entrypoint="/home/dev_factory_opencv/test.python.sh"
```




## To run performance tests
```
$ bash ./run.sh dev_factory_opencv --entrypoint="/home/dev_factory_opencv/test.performance.sh"
```

