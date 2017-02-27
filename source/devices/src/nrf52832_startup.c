#include <stdint.h>
#include <stddef.h>
#include <nrf5x_startup.h>

extern uint32_t __StackTop;

#define DEFAULT_HANDLER_WEAK_ALIAS  __attribute__ ((weak, alias("Default_Handler")))


void Default_Handler(void)
{
    while (1);
}

void Reset_Handler(void)                                    DEFAULT_HANDLER_WEAK_ALIAS;
void NMI_Handler(void)                                      DEFAULT_HANDLER_WEAK_ALIAS;
void HardFault_Handler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void MemoryManagement_Handler(void)                         DEFAULT_HANDLER_WEAK_ALIAS;
void BusFault_Handler(void)                                 DEFAULT_HANDLER_WEAK_ALIAS;
void UsageFault_Handler(void)                               DEFAULT_HANDLER_WEAK_ALIAS;
void SVC_Handler(void)                                      DEFAULT_HANDLER_WEAK_ALIAS;
void DebugMon_Handler(void)                                 DEFAULT_HANDLER_WEAK_ALIAS;
void PendSV_Handler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void SysTick_Handler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;

void POWER_CLOCK_IRQHandler(void)                           DEFAULT_HANDLER_WEAK_ALIAS;
void RADIO_IRQHandler(void)                                 DEFAULT_HANDLER_WEAK_ALIAS;
void UARTE0_UART0_IRQHandler(void)                          DEFAULT_HANDLER_WEAK_ALIAS;
void SPIM0_SPIS0_TWIM0_TWIS0_SPI0_TWI0_IRQHandler(void)     DEFAULT_HANDLER_WEAK_ALIAS;
void SPIM1_SPIS1_TWIM1_TWIS1_SPI1_TWI1_IRQHandler(void)     DEFAULT_HANDLER_WEAK_ALIAS;
void NFCT_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void GPIOTE_IRQHandler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void SAADC_IRQHandler(void)                                 DEFAULT_HANDLER_WEAK_ALIAS;
void TIMER0_IRQHandler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void TIMER1_IRQHandler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void TIMER2_IRQHandler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void RTC0_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void TEMP_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void RNG_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void ECB_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void CCM_AAR_IRQHandler(void)                               DEFAULT_HANDLER_WEAK_ALIAS;
void WDT_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void RTC1_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void QDEC_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void COMP_LPCOMP_IRQHandler(void)                           DEFAULT_HANDLER_WEAK_ALIAS;
void SWI0_EGU0_IRQHandler(void)                             DEFAULT_HANDLER_WEAK_ALIAS;
void SWI1_EGU1_IRQHandler(void)                             DEFAULT_HANDLER_WEAK_ALIAS;
void SWI2_EGU2_IRQHandler(void)                             DEFAULT_HANDLER_WEAK_ALIAS;
void SWI3_EGU3_IRQHandler(void)                             DEFAULT_HANDLER_WEAK_ALIAS;
void SWI4_EGU4_IRQHandler(void)                             DEFAULT_HANDLER_WEAK_ALIAS;
void SWI5_EGU5_IRQHandler(void)                             DEFAULT_HANDLER_WEAK_ALIAS;
void TIMER3_IRQHandler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void TIMER4_IRQHandler(void)                                DEFAULT_HANDLER_WEAK_ALIAS;
void PWM0_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void PDM_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void MWU_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void PWM1_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void PWM2_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void SPIM2_SPIS2_SPI2_IRQHandler(void)                      DEFAULT_HANDLER_WEAK_ALIAS;
void RTC2_IRQHandler(void)                                  DEFAULT_HANDLER_WEAK_ALIAS;
void I2S_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;
void FPU_IRQHandler(void)                                   DEFAULT_HANDLER_WEAK_ALIAS;

const irq_handler_t isr_vector[] __attribute__ ((section(".isr_vector"))) = 
{
    (irq_handler_t)&__StackTop,
    Reset_Handler,
    NMI_Handler,
    HardFault_Handler,
    MemoryManagement_Handler,
    BusFault_Handler,
    UsageFault_Handler,
    0,
    0,
    0,
    0,
    SVC_Handler,
    DebugMon_Handler,
    0,
    PendSV_Handler,
    SysTick_Handler,

    POWER_CLOCK_IRQHandler,
    RADIO_IRQHandler,
    UARTE0_UART0_IRQHandler,
    SPIM0_SPIS0_TWIM0_TWIS0_SPI0_TWI0_IRQHandler,
    SPIM1_SPIS1_TWIM1_TWIS1_SPI1_TWI1_IRQHandler,
    NFCT_IRQHandler,
    GPIOTE_IRQHandler,
    SAADC_IRQHandler,
    TIMER0_IRQHandler,
    TIMER1_IRQHandler,
    TIMER2_IRQHandler,
    RTC0_IRQHandler,
    TEMP_IRQHandler,
    RNG_IRQHandler,
    ECB_IRQHandler,
    CCM_AAR_IRQHandler,
    WDT_IRQHandler,
    RTC1_IRQHandler,
    QDEC_IRQHandler,
    COMP_LPCOMP_IRQHandler,
    SWI0_EGU0_IRQHandler,
    SWI1_EGU1_IRQHandler,
    SWI2_EGU2_IRQHandler,
    SWI3_EGU3_IRQHandler,
    SWI4_EGU4_IRQHandler,
    SWI5_EGU5_IRQHandler,
    TIMER3_IRQHandler,
    TIMER4_IRQHandler,
    PWM0_IRQHandler,
    PDM_IRQHandler,
    0,
    0,
    MWU_IRQHandler,
    PWM1_IRQHandler,
    PWM2_IRQHandler,
    SPIM2_SPIS2_SPI2_IRQHandler,
    RTC2_IRQHandler,
    I2S_IRQHandler,
    FPU_IRQHandler,
};
