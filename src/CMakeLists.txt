# In boringssl_ffi/src/CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

project(boringssl_ffi C CXX)
set(CMAKE_CXX_STANDARD 17)
include(FetchContent)

# These options are recommended by BoringSSL's documentation.
# They prevent linking against the C++ runtime and disable building tests.
set(BORINGSSL_ALLOW_CXX_RUNTIME OFF CACHE BOOL "")
set(BUILD_TESTING OFF CACHE BOOL "")

# This is a key change: It tells BoringSSL to compile its code
# into collections of object files (.o) instead of static libraries (.a).
set(BORINGSSL_CRYPTO_LIBRARY_TYPE OBJECT)
set(BORINGSSL_SSL_LIBRARY_TYPE OBJECT)
set(BORINGSSL_FIPSMODULE_LIBRARY_TYPE OBJECT) #fipsmodule

find_package(Threads REQUIRED)

FetchContent_Declare(
    boringssl
    GIT_REPOSITORY https://boringssl.googlesource.com/boringssl
    # GIT_TAG        0.20250514.0
		GIT_TAG        0.20250701.0
)
FetchContent_MakeAvailable(boringssl)

target_compile_definitions(crypto PRIVATE BORINGSSL_SHARED_LIBRARY=1 BORINGSSL_IMPLEMENTATION=1)
target_compile_definitions(ssl PRIVATE BORINGSSL_SHARED_LIBRARY=1 BORINGSSL_IMPLEMENTATION=1)
target_compile_definitions(fipsmodule PRIVATE BORINGSSL_SHARED_LIBRARY=1 BORINGSSL_IMPLEMENTATION=1)

message("CMAKE_BINARY_DIR:")
message(${CMAKE_BINARY_DIR})

add_library(boringssl_ffi SHARED
    $<TARGET_OBJECTS:crypto>
    $<TARGET_OBJECTS:ssl>
		$<TARGET_OBJECTS:fipsmodule>
)

# add support for 16kb page only for Android
if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    target_link_options(boringssl_ffi PRIVATE "-Wl,-z,max-page-size=0x4000")
endif()

# We still need to make the include directory available.
target_include_directories(boringssl_ffi PRIVATE
    ${boringssl_SOURCE_DIR}/include
)

target_link_libraries(boringssl_ffi PRIVATE
    ssl
    crypto
		fipsmodule
    Threads::Threads # BoringSSL also depends on pthreads, which CMake abstracts as Threads::Threads
)

# Set the output directory for the shared library (optional, but good practice)
set_target_properties(boringssl_ffi PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)
