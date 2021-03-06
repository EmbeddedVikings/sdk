if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(MCPU_FLAGS  -mthumb -mcpu=cortex-m4)
    set(VFP_FLAGS   -mfloat-abi=hard -mfpu=fpv4-sp-d16)

elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "ARMCC")
    set(MCPU_FLAGS  --cpu=cortex-m4.fp)
endif()


function(nordic_memory_settings)
    if(NOT DEFINED ${PROJECT_NAME}_DEVICE_FLASH_ORGIN)
        set(${PROJECT_NAME}_DEVICE_FLASH_ORGIN 0x00000000 CACHE STRING "${PROJECT_NAME} flash orgin.")
    endif()

    if(NOT DEFINED ${PROJECT_NAME}_DEVICE_RAM_ORGIN)
        set(${PROJECT_NAME}_DEVICE_RAM_ORGIN   0x20000000 CACHE STRING "${PROJECT_NAME} RAM orgin.")
    endif()

    if(${DEVICE_DENSITY} STREQUAL "AA")
        if(NOT DEFINED ${PROJECT_NAME}_DEVICE_FLASH_SIZE)
            set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x80000 CACHE STRING "${PROJECT_NAME} flash size.")
        endif()

        if(NOT DEFINED ${PROJECT_NAME}_DEVICE_RAM_SIZE)
            set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x10000 CACHE STRING "${PROJECT_NAME} RAM size.")
        endif()

    elseif(${DEVICE_DENSITY} STREQUAL "AB")
        if(NOT DEFINED ${PROJECT_NAME}_DEVICE_FLASH_SIZE)
            set(${PROJECT_NAME}_DEVICE_FLASH_SIZE  0x40000 CACHE STRING "${PROJECT_NAME} flash size.")
        endif()

        if(NOT DEFINED ${PROJECT_NAME}_DEVICE_RAM_SIZE)
            set(${PROJECT_NAME}_DEVICE_RAM_SIZE    0x8000  CACHE STRING "${PROJECT_NAME} RAM size.")
        endif()

    else()
        message(FATAL_ERROR "Unsupported device density: " ${DEVICE_DENSITY})
    endif()
endfunction()


function(nordic_startup_settings)
    if(NOT DEFINED ${PROJECT_NAME}_STARTUP_CONFIG_STACK_SIZE)
        set(${PROJECT_NAME}_STARTUP_CONFIG_STACK_SIZE   0x1000 CACHE STRING "Stack size.")
    endif()

    if(NOT DEFINED ${PROJECT_NAME}_STARTUP_CONFIG_HEAP_SIZE)
        set(${PROJECT_NAME}_STARTUP_CONFIG_HEAP_SIZE    0x1000 CACHE STRING "Heap size.")
    endif()
endfunction()


function(nordic_system_settings)
    if(NOT DEFINED ${PROJECT_NAME}_SYSTEM_CONFIG_NFCT_PINS_AS_GPIOS)
        set(${PROJECT_NAME}_SYSTEM_CONFIG_NFCT_PINS_AS_GPIOS    OFF CACHE BOOL  "Configure NFCT Pins as GPIOs.")
    endif()

    if(NOT DEFINED ${PROJECT_NAME}_SYSTEM_CONFIG_PINRESET_AS_GPIO)
        set(${PROJECT_NAME}_SYSTEM_CONFIG_PINRESET_AS_GPIO      OFF CACHE BOOL  "Configure Reset Pin as GPIO.")
    endif()

    if(NOT DEFINED ${PROJECT_NAME}_SYSTEM_CONFIG_SWO_ENABLED)
        set(${PROJECT_NAME}_SYSTEM_CONFIG_SWO_ENABLED           OFF CACHE BOOL  "Enable SWO.")
    endif()

    if(NOT DEFINED ${PROJECT_NAME}_SYSTEM_CONFIG_TRACE_ENABLED)
        set(${PROJECT_NAME}_SYSTEM_CONFIG_TRACE_ENABLED         OFF CACHE BOOL  "Enable Trace.")
    endif()
endfunction()