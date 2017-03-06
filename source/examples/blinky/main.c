#include <stdbool.h>
#include <stdint.h>
#include "nrf_delay.h"
#include "pca10040.h"
#include <n_gpio.h>

/**
 * @brief Function for application main entry.
 */
int main(void)
{
    n_gpio_cnf(N_GPIO_P0,
               LED_0,
               N_GPIO_CNF_STD_OUTPUT);

    /* Toggle LEDs. */
    while (true)
    {
        n_gpio_pin_set(N_GPIO_P0, LED_0);
        nrf_delay_ms(500);
        n_gpio_pin_clr(N_GPIO_P0, LED_0);
        nrf_delay_ms(500);
    }
}
