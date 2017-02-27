if(NOT DEFINED ${PROJECT_NAME}_BOARD)
    set(${PROJECT_NAME}_BOARD ${CMAKE_BOARD} CACHE STRING "Board [pca10028|pac10040|pca10056]")
    set_property(CACHE ${PROJECT_NAME}_BOARD PROPERTY STRINGS pca10028 pac10040 pca10056)
endif()
string(TOUPPER ${${PROJECT_NAME}_BOARD} BOARD)

if(BOARD STREQUAL "PCA10028")
    set(${PROJECT_NAME}_DEVICE "NRF51422XXAC")

elseif(BOARD STREQUAL "PCA10040")
    set(${PROJECT_NAME}_DEVICE "NRF52832XXAA")

elseif(BOARD STREQUAL "PCA10056")
    set(${PROJECT_NAME}_DEVICE "NRF52840XXAA")

else()
    message(FATAL_ERROR "Unsupported board: " ${BOARD})
endif()

set(BOARD_INCLUDES "${CMAKE_CURRENT_LIST_DIR}/inc")

include(device)

function(nordic_set_board_properties TARGET)
    target_compile_definitions(${TARGET} PRIVATE "-D${BOARD}")
    target_include_directories(${TARGET} PRIVATE ${BOARD_INCLUDES})
endfunction()