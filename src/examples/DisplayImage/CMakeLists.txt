cmake_minimum_required(VERSION 3.11)

project(DisplayImage)
set(APPLICATION_NAME DisplayImage)
set (CMAKE_CXX_STANDARD 14)

find_package(OpenCV REQUIRED)
find_package(Threads REQUIRED)

include_directories( ${OpenCV_INCLUDE_DIRS} )

file(GLOB APPLICATION_SOURCES *.cpp)

add_executable (
    ${APPLICATION_NAME}
    ${APPLICATION_SOURCES}
)

target_link_libraries(
    ${APPLICATION_NAME}
    ${OpenCV_LIBS}
    Threads::Threads
)

