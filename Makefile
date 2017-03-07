MK := mkdir
RM := rm -rf

BUILD_TYPE ?= debug
BOARD      ?= pca10040
DEVICE     ?= nrf52832xxAA
GENERATOR  ?= $(if $(shell ninja --version 2> /dev/null),Ninja,$(if $(filter Windows%,$(OS)),MSYS Makefiles, Unix Makefiles))
SOURCE      = "$(shell pwd)\source"

COMMON_DEFINITIONS =                     \
	-DCMAKE_BUILD_TYPE=$(BUILD_TYPE)     \
	-DCMAKE_BOARD=$(BOARD)               \
	-DCMAKE_DEVICE=$(DEVICE)             \

armgcc:
	$(RM) "build/armgcc" && $(MK) "build/armgcc"
	cd "build/armgcc" && cmake -G"$(GENERATOR)" $(COMMON_DEFINITIONS) -DCMAKE_TOOLCHAIN_FILE=toolchains/arm-none-eabi.cmake $(SOURCE)

armcc:
	$(RM) "build/armcc" && $(MK) "build/armcc"
	cd "build/armcc"  && cmake -G"$(GENERATOR)" $(COMMON_DEFINITIONS) -DCMAKE_TOOLCHAIN_FILE=toolchains/armcc.cmake $(SOURCE)

eclipse_armgcc:
	$(RM) "build/eclipse_armgcc" && $(MK) "build/eclipse_armgcc"
	cd "build/eclipse_armgcc" && cmake -G"Eclipse CDT4 - $(GENERATOR)" $(COMMON_DEFINITIONS) -DCMAKE_TOOLCHAIN_FILE=toolchains/arm-none-eabi.cmake $(SOURCE)

eclipse_armcc:
	$(RM) "build/eclipse_armcc" && $(MK) "build/eclipse_armcc"
	cd "build/eclipse_armcc"  && cmake -G"Eclipse CDT4 - $(GENERATOR)" $(COMMON_DEFINITIONS) -DCMAKE_TOOLCHAIN_FILE=toolchains/armcc.cmake $(SOURCE)

sublime_armgcc:
	$(RM) "build/sublime_armgcc" && $(MK) "build/sublime_armgcc"
	cd "build/sublime_armgcc" && cmake -G"Sublime Text 2 - $(GENERATOR)" $(COMMON_DEFINITIONS) -DCMAKE_TOOLCHAIN_FILE=toolchains/arm-none-eabi.cmake $(SOURCE)

sublime_armcc:
	$(RM) "build/sublime_armcc" && $(MK) "build/sublime_armcc"
	cd "build/sublime_armcc"  && cmake -G"Sublime Text 2 - $(GENERATOR)" $(COMMON_DEFINITIONS) -DCMAKE_TOOLCHAIN_FILE=toolchains/armcc.cmake $(SOURCE)

all: armgcc armcc

eclipse_all: eclipse_armgcc eclipse_armcc

sublime_all: sublime_armgcc sublime_armcc

clean:
	$(foreach dir,$(wildcard build/*), $(RM) $(dir))

help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... help"
	@echo "... armcc"
	@echo "... armgcc"
	@echo "... eclipse_armcc"
	@echo "... eclipse_armgcc"
	@echo "... sublime_armcc"
	@echo "... sublime_armgcc"
	@echo "... all"
	@echo "... eclipse_all"
	@echo "... sublime_all"
	@echo "... clean"
	@echo ""
	@echo "To change build type:      BUILD_TYPE=[release|debug]"
	@echo "To change default board:   BOARD=[pca10028|pca10040|pca10056]"
	@echo "To change default device:  DEVICE=[nrf51422xxAA|nrf51422xxAB|nrf51422xxAC|nrf52832xxAA|nrf52832xxAB|nrf52840xxAA]"
	@echo "To change cmake generator: GENERATOR=[\"MSYS Makefiles\"|\"Unix Makefiles\"]"