if(NOT DEFINED ${PROJECT_NAME}_DEVICE)
    set(${PROJECT_NAME}_DEVICE ${CMAKE_DEVICE} CACHE STRING "Device [nrf51422xxAA, nrf51422xxAB, nrf51422xxAC, nrf52832xxAA, nrf52832xxAB, nrf52840xxAA]")
endif()

string(TOUPPER ${${PROJECT_NAME}_DEVICE} DEVICE)
string(REGEX MATCH "^(NRF[0-9][0-9])"   DEVICE_SERIES   ${DEVICE})
string(REGEX MATCH "^(NRF([0-9]+))"     DEVICE_TYPE     ${DEVICE})
string(REGEX MATCH "([A-Z][A-Z])$"      DEVICE_DENSITY  ${DEVICE})

if(${DEVICE_SERIES} STREQUAL "NRF51")
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(MCPU_FLAGS  -mthumb -mcpu=cortex-m0)
        set(VFP_FLAGS   -mfloat-abi=soft)

    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
        set(MCPU_FLAGS  --cpu=cortex-m0)
    endif()

elseif(${DEVICE_SERIES} STREQUAL "NRF52")
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(MCPU_FLAGS  -mthumb -mcpu=cortex-m4)
        set(VFP_FLAGS   -mfloat-abi=hard -mfpu=fpv4-sp-d16)

    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
        set(MCPU_FLAGS  --cpu=cortex-m4.fp)
    endif()
endif()

string(TOLOWER ${DEVICE_TYPE} DEVICE_TYPE_L)
set(DEVICE_SYSTEM_FILE ${CMAKE_CURRENT_LIST_DIR}/src/system_${DEVICE_TYPE_L}.c)


if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(DEVICE_STARTUP_FILE         ${CMAKE_CURRENT_LIST_DIR}/src/gcc_startup_${DEVICE_TYPE_L}.S)
    set(DEVICE_COMMON_LINKER_PATH   ${CMAKE_CURRENT_LIST_DIR}/linker)
    set(TEMPLATE_LINKER_SCRIPT      ${CMAKE_CURRENT_LIST_DIR}/linker/template.ld)

elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
    set(DEVICE_STARTUP_FILE         ${CMAKE_CURRENT_LIST_DIR}/src/arm_startup_${DEVICE_TYPE_L}.s)
    set(TEMPLATE_LINKER_SCRIPT      ${CMAKE_CURRENT_LIST_DIR}/linker/template.sct)
endif()

set(${PROJECT_NAME}_DEVICE_FLASH_ORGIN 0x00000000 CACHE STRING "${PROJECT_NAME} flash orgin.")
set(${PROJECT_NAME}_DEVICE_RAM_ORGIN   0x20000000 CACHE STRING "${PROJECT_NAME} RAM orgin.")

if(${DEVICE_TYPE} STREQUAL "NRF51422")
    if(${DEVICE_DENSITY} STREQUAL "AA")
        set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x40000 CACHE STRING "${PROJECT_NAME} flash size.")
        set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x4000  CACHE STRING "${PROJECT_NAME} RAM size.")

    elseif(${DEVICE_DENSITY} STREQUAL "AB")
        set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x80000 CACHE STRING "${PROJECT_NAME} flash size.")
        set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x4000  CACHE STRING "${PROJECT_NAME} RAM size.")

    elseif(${DEVICE_DENSITY} STREQUAL "AC")
        set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x40000 CACHE STRING "${PROJECT_NAME} flash size.")
        set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x20000 CACHE STRING "${PROJECT_NAME} RAM size.")

    else()
        message(FATAL_ERROR "Unsupported device density: " ${DEVICE_DENSITY})
    endif()

elseif(${DEVICE_TYPE} STREQUAL "NRF52832")
    if(${DEVICE_DENSITY} STREQUAL "AA")
        set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x80000 CACHE STRING "${PROJECT_NAME} flash size.")
        set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x10000 CACHE STRING "${PROJECT_NAME} RAM size.")

    elseif(${DEVICE_DENSITY} STREQUAL "AB")
        set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x40000 CACHE STRING "${PROJECT_NAME} flash size.")
        set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x8000  CACHE STRING "${PROJECT_NAME} RAM size.")

    else()
        message(FATAL_ERROR "Unsupported device density: " ${DEVICE_DENSITY})
    endif()

elseif(${DEVICE_TYPE} STREQUAL "NRF52840")
    if(${DEVICE_DENSITY} STREQUAL "AA")
        set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x100000 CACHE STRING "${PROJECT_NAME} flash size.")
        set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x40000  CACHE STRING "${PROJECT_NAME} RAM size.")

    else()
        message(FATAL_ERROR "Unsupported device density: " ${DEVICE_DENSITY})
    endif()

else()
    message(FATAL_ERROR "Unsupported device type: " ${DEVICE_TYPE})
endif()

set(DEVICE_INCLUDES "${CMAKE_CURRENT_LIST_DIR}/inc" "${CMAKE_CURRENT_LIST_DIR}/cmsis/inc")

function(nordic_set_device_properties TARGET)
    target_compile_options(${TARGET}     PRIVATE ${MCPU_FLAGS} ${VFP_FLAGS})
    target_compile_definitions(${TARGET} PRIVATE "-D${DEVICE_SERIES}_SERIES" "-D${DEVICE_TYPE}" "-D${DEVICE}")
    target_include_directories(${TARGET} PRIVATE ${DEVICE_INCLUDES})
    string (REPLACE ";" " " TARGET_LINK_FLAGS " ${MCPU_FLAGS} ${VFP_FLAGS}")
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
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJDUMP} -d -S     ${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C} > ${PROJECT_NAME}.dmp)
        add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${SIZE}              ${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C})
    endif()
endfunction()