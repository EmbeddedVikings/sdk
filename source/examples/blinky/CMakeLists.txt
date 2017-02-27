project(blinky C ASM)
include(boards)

set(SOURCES  "main.c")

include_directories(${PROJECT_DIR})

nordic_add_executable(${PROJECT_NAME}  ${SOURCES})
nordic_set_board_properties(${PROJECT_NAME})
nordic_add_hex_bin_targets(${PROJECT_NAME})