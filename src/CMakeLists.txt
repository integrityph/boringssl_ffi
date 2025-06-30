# # This file is located at boringssl_ffi/src/CMakeLists.txt
# cmake_minimum_required(VERSION 3.14)

# # The project name here defines the final library name.
# # It will produce `libboringssl_ffi.so` or `libboringssl_ffi.dylib`.
# project(boringssl_ffi C CXX)

# # Set a C++ standard, as BoringSSL requires it.
# set(CMAKE_CXX_STANDARD 17)

# # This command includes the CMake module that gives us the fetch ability.
# include(FetchContent)

# # This block declares the dependency we want to download.
# FetchContent_Declare(
#     boringssl
#     GIT_REPOSITORY https://boringssl.googlesource.com/boringssl
#     GIT_TAG        0.20250514.0
# )

# # This command tells CMake to actually perform the download
# # and make the build targets available.
# FetchContent_MakeAvailable(boringssl)

# # Now, we define our own library.
# # The name MUST match the project() name above.
# add_library(${PROJECT_NAME} SHARED
#     # We create our library using all of BoringSSL's source files,
#     # which are provided by the FetchContent command above.
#     ${crypto_sources}
#     ${ssl_sources}
# )

# # Finally, we make the BoringSSL header files available.
# target_include_directories(${PROJECT_NAME} PUBLIC
#     # This variable points to the downloaded source directory.
#     ${boringssl_SOURCE_DIR}/include
# )








# # In boringssl_ffi/src/CMakeLists.txt
# cmake_minimum_required(VERSION 3.14)

# project(boringssl_ffi C CXX)
# set(CMAKE_CXX_STANDARD 17)
# include(FetchContent)

# # These options are recommended by BoringSSL's documentation.
# # They prevent linking against the C++ runtime and disable building tests.
# set(BORINGSSL_ALLOW_CXX_RUNTIME OFF CACHE BOOL "")
# set(BUILD_TESTING OFF CACHE BOOL "")

# # This is a key change: It tells BoringSSL to compile its code
# # into collections of object files (.o) instead of static libraries (.a).
# set(BORINGSSL_CRYPTO_LIBRARY_TYPE OBJECT)
# set(BORINGSSL_SSL_LIBRARY_TYPE OBJECT)

# find_package(Threads REQUIRED)

# FetchContent_Declare(
#     boringssl
#     GIT_REPOSITORY https://boringssl.googlesource.com/boringssl
#     GIT_TAG        0.20250514.0
# )
# FetchContent_MakeAvailable(boringssl)
# message("CMAKE_BINARY_DIR:")
# message(${CMAKE_BINARY_DIR})
# # Now, we create our single shared library by consuming the fully-compiled
# # object files from BoringSSL's internal 'crypto' and 'ssl' targets.
# # This correctly includes all C, C++, and Assembly sources.
# add_library(boringssl_ffi SHARED
#     $<TARGET_OBJECTS:crypto>
#     $<TARGET_OBJECTS:ssl>
# )
# message("CMAKE_BINARY_DIR:")
# message(${CMAKE_BINARY_DIR})

# # We still need to make the include directory available.
# target_include_directories(boringssl_ffi PRIVATE
#     ${boringssl_SOURCE_DIR}/include
# )
#
# target_link_libraries(boringssl_ffi PRIVATE
#     ${CMAKE_BINARY_DIR}/_deps/boringssl-build/libssl.a
#     ${CMAKE_BINARY_DIR}/_deps/boringssl-build/libcrypto.a
#     Threads::Threads # BoringSSL also depends on pthreads, which CMake abstracts as Threads::Threads
# )
#
# # Set the output directory for the shared library (optional, but good practice)
# set_target_properties(boringssl_ffi PROPERTIES
#     LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
# )








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

find_package(Threads REQUIRED)

FetchContent_Declare(
    boringssl
    GIT_REPOSITORY https://boringssl.googlesource.com/boringssl
    GIT_TAG        0.20250514.0
)
FetchContent_MakeAvailable(boringssl)

target_compile_definitions(crypto PRIVATE BORINGSSL_SHARED_LIBRARY=1 BORINGSSL_IMPLEMENTATION=1)
target_compile_definitions(ssl PRIVATE BORINGSSL_SHARED_LIBRARY=1 BORINGSSL_IMPLEMENTATION=1)

message("CMAKE_BINARY_DIR:")
message(${CMAKE_BINARY_DIR})

add_library(boringssl_ffi SHARED
    $<TARGET_OBJECTS:crypto>
    $<TARGET_OBJECTS:ssl>
)

# We still need to make the include directory available.
target_include_directories(boringssl_ffi PRIVATE
    ${boringssl_SOURCE_DIR}/include
)

target_link_libraries(boringssl_ffi PRIVATE
    ssl
    crypto
    Threads::Threads # BoringSSL also depends on pthreads, which CMake abstracts as Threads::Threads
)

# Set the output directory for the shared library (optional, but good practice)
set_target_properties(boringssl_ffi PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)

# target_link_options(boringssl_ffi PRIVATE 
#     "-Wl,-exported_symbols_list,${CMAKE_CURRENT_SOURCE_DIR}/exported_symbols.txt"
# )