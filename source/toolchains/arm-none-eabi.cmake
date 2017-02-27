set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  ARM)

set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY) # to skip CMake’s checks for a working compiler 
set(CMAKE_C_COMPILER                arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER              arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER              arm-none-eabi-g++)
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_LINER_SCRIPT_SUFFIX       ".ld")

set(AS                              arm-none-eabi-as)
set(AR                              arm-none-eabi-ar)
set(OBJCOPY                         arm-none-eabi-objcopy)
set(OBJDUMP                         arm-none-eabi-objdump)
set(SIZE                            arm-none-eabi-size)

set(CMAKE_CROSSCOMPILING        ON)
set(CMAKE_SKIP_INSTALL_RULES    ON)

set(CMAKE_C_FLAGS           "-Wall -fno-builtin -fdata-sections -ffunction-sections -std=gnu99" CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS         "-Wall -fno-builtin -fdata-sections -ffunction-sections"            CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS         "-x assembler-with-cpp"                                             CACHE INTERNAL "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS  "-lnosys -Wl,--gc-sections"                      CACHE INTERNAL "exe link flags")

SET(CMAKE_C_FLAGS_DEBUG     "-O0 -g -ggdb3" CACHE INTERNAL "c debug compiler flags")
SET(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g -ggdb3" CACHE INTERNAL "cxx debug compiler flags")
SET(CMAKE_ASM_FLAGS_DEBUG   "-g -ggdb3"     CACHE INTERNAL "asm debug compiler flags")

SET(CMAKE_C_FLAGS_RELEASE   "-O2 -g -ggdb3" CACHE INTERNAL "c release compiler flags")
SET(CMAKE_CXX_FLAGS_RELEASE "-O2 -g -ggdb3" CACHE INTERNAL "cxx release compiler flags")
SET(CMAKE_ASM_FLAGS_RELEASE "-g -ggdb3"     CACHE INTERNAL "asm release compiler flags")