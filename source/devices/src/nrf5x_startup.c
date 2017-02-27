#include <stdint.h>
#include <nrf5x_startup.h>
#include <nrf5x_system.h>
#include "startup_config.h"

#if defined(__GNUC__)
    void _start(void)    __attribute__((noreturn));
#   define START() _start()

#elif defined(__CC_ARM)
    void __main(void)    __attribute__((noreturn));
#   define START() __main()

#else
#   error "Unsupported compiler."
#endif

extern uint32_t __bss_start__;
extern uint32_t __bss_end__;
extern uint32_t __etext;
extern uint32_t __data_start__;
extern uint32_t __data_end__;

uint8_t stack[STARTUP_CONFIG_STACK_SIZE]    __attribute__ ((used, section(".stack")));

#if (SYSTEM_CONFIG_HEAP_SIZE > 0)
    uint8_t heap[STARTUP_CONFIG_HEAP_SIZE]  __attribute__ ((used, section(".heap")));
#endif

void Reset_Handler(void)
{
    uint32_t * p_src;
    uint32_t * p_dst;

#if STARTUP_CONFIG_INIT_DATA
    for (p_src = &__etext, p_dst = &__data_start__; p_dst < &__data_end__; p_src++, p_dst++)
    {
        *p_dst = *p_src;
    }
#endif // STARTUP_CONFIG_INIT_DATA

#if STARTUP_CONFIG_CLEAR_BSS
    for (p_dst = &__bss_start__; p_dst < &__bss_end__; p_dst++)
    {
        *p_dst = 0;
    }
#endif // STARTUP_CONFIG_CLEAR_BSS

    SystemInit();

    START();

    while (1);
}
