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

set(NUMA_INCLUDE_DIR ${SOURC_DIR})
set(NUMA_LIB_DIR ${SOURCE_DIR}/.libs)

include_directories(${NUMA_INCLUDE_DIR})
link_directories(${NUMA_LIB_DIR})


####