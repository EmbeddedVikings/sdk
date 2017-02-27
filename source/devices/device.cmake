if(NOT DEFINED ${PROJECT_NAME}_DEVICE)
    set(${PROJECT_NAME}_DEVICE ${CMAKE_DEVICE} CACHE STRING "Device [nrf51422xxAA|nrf51422xxAB|nrf51422xxAC|nrf52832xxAA|nrf52832xxAB|nrf52840xxAA]")
endif()


string(TOUPPER ${${PROJECT_NAME}_DEVICE} DEVICE)
string(REGEX MATCH "^(NRF[0-9][0-9])"   DEVICE_SERIES   ${DEVICE})
string(REGEX MATCH "^(NRF([0-9]+))"     DEVICE_TYPE     ${DEVICE})
string(REGEX MATCH "([A-Z][A-Z])$"      DEVICE_DENSITY  ${DEVICE})

string(TOLOWER ${DEVICE_TYPE}   DEVICE_TYPE_L)


include(${CMAKE_CURRENT_LIST_DIR}/CMake/${DEVICE_TYPE_L}.cmake)


set(DEVICE_SYSTEM_FILE      ${CMAKE_CURRENT_LIST_DIR}/src/${DEVICE_TYPE_L}_system.c)
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(DEVICE_STARTUP_FILE         ${CMAKE_CURRENT_LIST_DIR}/src/gcc_${DEVICE_TYPE_L}_startup.S)
    set(DEVICE_COMMON_LINKER_PATH   ${CMAKE_CURRENT_LIST_DIR}/linker)
    set(TEMPLATE_LINKER_SCRIPT      ${CMAKE_CURRENT_LIST_DIR}/templates/linker.ld.in)

elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
    set(DEVICE_STARTUP_FILE         ${CMAKE_CURRENT_LIST_DIR}/src/arm_${DEVICE_TYPE_L}_startup.s)
    set(TEMPLATE_LINKER_SCRIPT      ${CMAKE_CURRENT_LIST_DIR}/templates/scatter_file.sct.in)
endif()

set(TEMPLATE_STARTUP_CONFIG     ${CMAKE_CURRENT_LIST_DIR}/templates/startup_config.h.in)
set(TEMPLATE_SYSTEM_CONFIG      ${CMAKE_CURRENT_LIST_DIR}/templates/system_config.h.in)
set(DEVICE_INCLUDES             ${CMAKE_CURRENT_LIST_DIR}/inc
                                ${CMAKE_CURRENT_LIST_DIR}/cmsis/inc)


function(nordic_set_device_properties TARGET)
    target_compile_options(${TARGET}     PRIVATE ${MCPU_FLAGS} ${VFP_FLAGS})
    target_compile_definitions(${TARGET} PRIVATE "-D${DEVICE_SERIES}_SERIES" "-D${DEVICE_TYPE}" "-D${DEVICE}")
    target_include_directories(${TARGET} PRIVATE ${DEVICE_INCLUDES})
    target_include_directories(${TARGET} PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/config)
    string(REPLACE ";" " " TARGET_LINK_FLAGS " ${MCPU_FLAGS} ${VFP_FLAGS}")
    set_property(TARGET ${TARGET} APPEND_STRING PROPERTY LINK_FLAGS ${TARGET_LINK_FLAGS})
endfunction()


function(nordic_add_linker TARGET)
    if(DEFINED ${PROJECT_NAME}_DEVICE_LINKER_SCRIPT)
        set(LINKER_SCRIPT ${${PROJECT_NAME}_DEVICE_LINKER_SCRIPT})

    else()
        message(STATUS "Generate linker script for ${TARGET}.")
        set(FLASH_ORGIN ${${PROJECT_NAME}_DEVICE_FLASH_ORGIN})
        set(FLASH_SIZE  ${${PROJECT_NAME}_DEVICE_FLASH_SIZE})
        set(RAM_ORGIN   ${${PROJECT_NAME}_DEVICE_RAM_ORGIN})
        set(RAM_SIZE    ${${PROJECT_NAME}_DEVICE_RAM_SIZE})

        set(LINKER_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}${CMAKE_LINER_SCRIPT_SUFFIX})
        configure_file(${TEMPLATE_LINKER_SCRIPT} ${LINKER_SCRIPT})
    endif()

    if(DEFINED ${PROJECT_NAME}_DEVICE_COMMON_LINKER_PATH)
        set(COMMON_LINKER_PATH ${${PROJECT_NAME}_DEVICE_COMMON_LINKER_PATH})
    else()
        set(COMMON_LINKER_PATH ${DEVICE_COMMON_LINKER_PATH})
    endif()

    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set_property(TARGET ${TARGET} APPEND_STRING PROPERTY LINK_FLAGS " -L ${DEVICE_COMMON_LINKER_PATH} -T${LINKER_SCRIPT}")

    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
        set_property(TARGET ${TARGET} APPEND_STRING PROPERTY LINK_FLAGS " --scatter ${LINKER_SCRIPT}")
    endif()


    set(STARTUP_CONFIG_STACK_SIZE  ${${PROJECT_NAME}_STARTUP_CONFIG_STACK_SIZE})
    set(STARTUP_CONFIG_HEAP_SIZE   ${${PROJECT_NAME}_STARTUP_CONFIG_HEAP_SIZE})

    configure_file(${TEMPLATE_STARTUP_CONFIG} ${CMAKE_CURRENT_BINARY_DIR}/config/startup_config.h)


    set(SYSTEM_CONFIG_NFCT_PINS_AS_GPIOS    ${${PROJECT_NAME}_SYSTEM_CONFIG_NFCT_PINS_AS_GPIOS})
    set(SYSTEM_CONFIG_PINRESET_AS_GPIO      ${${PROJECT_NAME}_SYSTEM_CONFIG_PINRESET_AS_GPIO})
    set(SYSTEM_CONFIG_SWO_ENABLED           ${${PROJECT_NAME}_SYSTEM_CONFIG_SWO_ENABLED})
    set(SYSTEM_CONFIG_TRACE_ENABLED         ${${PROJECT_NAME}_SYSTEM_CONFIG_TRACE_ENABLED})

    configure_file(${TEMPLATE_SYSTEM_CONFIG} ${CMAKE_CURRENT_BINARY_DIR}/config/system_config.h)
endfunction()


function(nordic_add_executable TARGET)
    add_executable(${TARGET} ${ARGN})
    nordic_set_device_properties(${TARGET})
    nordic_add_linker(${TARGET})
    set_property(TARGET ${TARGET} APPEND PROPERTY SOURCES ${DEVICE_STARTUP_FILE} ${DEVICE_SYSTEM_FILE})
endfunction()


function(nordic_add_hex_bin_targets TARGET)
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJCOPY} -O binary ${TARGET}${CMAKE_EXECUTABLE_SUFFIX_C}   ${PROJECT_NAME}.bin)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJCOPY} -O ihex   ${TARGET}${CMAKE_EXECUTABLE_SUFFIX_C}   ${PROJECT_NAME}.hex)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJDUMP} -d -S     ${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C} > ${PROJECT_NAME}.dmp)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${SIZE}              ${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C})

    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_FROMELF} --bin ${TARGET}${CMAKE_EXECUTABLE_SUFFIX_C} -o ${PROJECT_NAME}.bin)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_FROMELF} --i32 ${TARGET}${CMAKE_EXECUTABLE_SUFFIX_C} -o ${PROJECT_NAME}.hex)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJDUMP} -d -S       ${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C} > ${PROJECT_NAME}.dmp)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${SIZE}                ${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C})
    endif()
endfunction()