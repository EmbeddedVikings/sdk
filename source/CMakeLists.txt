cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_LIST_DIR}/toolchains"
    "${CMAKE_CURRENT_LIST_DIR}/devices"
    "${CMAKE_CURRENT_LIST_DIR}/common"
    "${CMAKE_CURRENT_LIST_DIR}/drivers"
    "${CMAKE_CURRENT_LIST_DIR}/boards")

project(nordic_sdk)
add_subdirectory(examples)