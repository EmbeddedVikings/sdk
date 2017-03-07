project(drivers)
include(drivers)
include(devices)
include(common)

include_directories(${COMMON_INCLUDES}
                    ${DRIVERS_INCLUDES})

nordic_add_library(${PROJECT_NAME}  ${DRIVERS_SOURCES})