set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  ARM)

set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY) # to skip CMake’s checks for a working compiler 
set(CMAKE_C_COMPILER                armcc)
set(CMAKE_CXX_COMPILER              armcc)
set(CMAKE_ASM_COMPILER              armasm)
set(CMAKE_FROMELF                   fromelf)
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_LINER_SCRIPT_SUFFIX       ".sct")

set(SIZE                            arm-none-eabi-size)
set(OBJDUMP                         arm-none-eabi-objdump)

set(CMAKE_CROSSCOMPILING        ON)
set(CMAKE_SKIP_INSTALL_RULES    ON)

set(CMAKE_C_FLAGS           "--c99"                                                             CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS         ""                                                                  CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS         "--cpreproc --apcs=interwork --cpreproc_opts=\"-DASSEMBLER_PREPROC__\""  CACHE INTERNAL "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS  "--strict --map --xref --symbols"                                   CACHE INTERNAL "exe link flags")

SET(CMAKE_C_FLAGS_DEBUG     "-o0 -g"        CACHE INTERNAL "c debug compiler flags")
SET(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g"        CACHE INTERNAL "cxx debug compiler flags")
SET(CMAKE_ASM_FLAGS_DEBUG   ""              CACHE INTERNAL "asm debug compiler flags")

SET(CMAKE_C_FLAGS_RELEASE   "-O3 -Otime"    CACHE INTERNAL "c release compiler flags")
SET(CMAKE_CXX_FLAGS_RELEASE "-O3 -Otime"    CACHE INTERNAL "cxx release compiler flags")
SET(CMAKE_ASM_FLAGS_RELEASE ""              CACHE INTERNAL "asm release compiler flags")