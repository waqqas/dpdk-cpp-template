cmake_minimum_required(VERSION 3.10)

include(ExternalProject)

# install DPDK
ExternalProject_Add(dpdk_project 
    GIT_REPOSITORY https://github.com/DPDK/dpdk.git
    GIT_TAG v19.08
    CONFIGURE_COMMAND $(MAKE)  -C ../dpdk_project defconfig
    BUILD_COMMAND $(MAKE) -C ../dpdk_project
    INSTALL_COMMAND ""
)

ExternalProject_Get_property(dpdk_project SOURCE_DIR)

set(DPDK_INCLUDE_DIR ${SOURCE_DIR}/build/include)
set(DPDK_LIB_DIR ${SOURCE_DIR}/build/lib)
set(DPDK_KMOD_DIR ${SOURCE_DIR}/build/kmod)

include_directories(${DPDK_INCLUDE_DIR})
link_directories(${DPDK_LIB_DIR})

#install libnuma

ExternalProject_Add(numactl_project
    GIT_REPOSITORY https://github.com/numactl/numactl.git
    GIT_TAG v2.0.13
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND ./autogen.sh COMMAND ./configure
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND ""
)

ExternalProject_Get_property(numactl_project SOURCE_DIR)
message("NUMA BINARY_DIR = ${BINARY_DIR}")

set(NUMA_INCLUDE_DIR ${SOURC_DIR})
set(NUMA_LIB_DIR ${SOURCE_DIR}/.libs)

include_directories(${NUMA_INCLUDE_DIR})
link_directories(${NUMA_LIB_DIR})


####

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
