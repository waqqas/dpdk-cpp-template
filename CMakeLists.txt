cmake_minimum_required(VERSION 3.10)

include(ExternalProject)

include(${CMAKE_SOURCE_DIR}/dpdk.cmake)


find_package (Threads REQUIRED)


set(CMAKE_CXX_STANDARD 11)

add_definitions(-mssse3)

if(NOT CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

string(TOUPPER "${CMAKE_BUILD_TYPE}" CMAKE_BUILD_TYPE)

set(COMMON_WARN "-Wall -Werror -Wextra -Wstrict-aliasing=2 -Wno-unused-parameter -Wno-unused-variable")
set(COMMON_C_FLAGS "-fstrict-aliasing -fvisibility=hidden")
set(COMMON_CXX_FLAGS "${COMMON_C_FLAGS} -faligned-new -fno-rtti")

include_directories(${CMAKE_SOURCE_DIR}/src)

file(GLOB sources src/*.cpp src/*.h)
add_executable(app ${sources})
target_link_libraries(app dpdk numa pthread dl)
