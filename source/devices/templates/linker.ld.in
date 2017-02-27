/* Linker script to configure memory regions. */

SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

MEMORY
{
  FLASH (rx) : ORIGIN = ${FLASH_ORGIN}, LENGTH = ${FLASH_SIZE}
  RAM (rwx) :  ORIGIN = ${RAM_ORGIN}, LENGTH = ${RAM_SIZE}
}

INCLUDE "nrf5x_common.ld"
