project(blinky C ASM)
include(boards)
include(common)
include(drivers)

set(SOURCES     ${COMMON_SOURCES}
                ${DRIVERS_SOURCES}
                "main.c")

include_directories(${PROJECT_DIR}
                    ${DRIVERS_INCLUDES}
                    ${COMMON_INCLUDES})

nordic_add_executable(${PROJECT_NAME}  ${SOURCES})
nordic_set_board_properties(${PROJECT_NAME})
nordic_add_hex_bin_targets(${PROJECT_NAME})