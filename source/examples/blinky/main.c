#include <stdbool.h>
#include <stdint.h>
#include "nrf_delay.h"
#include "pca10040.h"

typedef enum
{
    NRF_GPIO_PIN_DIR_INPUT  = GPIO_PIN_CNF_DIR_Input, ///< Input.
    NRF_GPIO_PIN_DIR_OUTPUT = GPIO_PIN_CNF_DIR_Output ///< Output.
} nrf_gpio_pin_dir_t;

/**
 * @brief Connection of input buffer.
 */
typedef enum
{
    NRF_GPIO_PIN_INPUT_CONNECT    = GPIO_PIN_CNF_INPUT_Connect,   ///< Connect input buffer.
    NRF_GPIO_PIN_INPUT_DISCONNECT = GPIO_PIN_CNF_INPUT_Disconnect ///< Disconnect input buffer.
} nrf_gpio_pin_input_t;

/**
 * @brief Enumerator used for selecting the pin to be pulled down or up at the time of pin configuration.
 */
typedef enum
{
    NRF_GPIO_PIN_NOPULL   = GPIO_PIN_CNF_PULL_Disabled, ///<  Pin pull-up resistor disabled.
    NRF_GPIO_PIN_PULLDOWN = GPIO_PIN_CNF_PULL_Pulldown, ///<  Pin pull-down resistor enabled.
    NRF_GPIO_PIN_PULLUP   = GPIO_PIN_CNF_PULL_Pullup,   ///<  Pin pull-up resistor enabled.
} nrf_gpio_pin_pull_t;

/**
 * @brief Enumerator used for selecting output drive mode.
 */
typedef enum
{
    NRF_GPIO_PIN_S0S1 = GPIO_PIN_CNF_DRIVE_S0S1, ///< !< Standard '0', standard '1'.
    NRF_GPIO_PIN_H0S1 = GPIO_PIN_CNF_DRIVE_H0S1, ///< !< High-drive '0', standard '1'.
    NRF_GPIO_PIN_S0H1 = GPIO_PIN_CNF_DRIVE_S0H1, ///< !< Standard '0', high-drive '1'.
    NRF_GPIO_PIN_H0H1 = GPIO_PIN_CNF_DRIVE_H0H1, ///< !< High drive '0', high-drive '1'.
    NRF_GPIO_PIN_D0S1 = GPIO_PIN_CNF_DRIVE_D0S1, ///< !< Disconnect '0' standard '1'.
    NRF_GPIO_PIN_D0H1 = GPIO_PIN_CNF_DRIVE_D0H1, ///< !< Disconnect '0', high-drive '1'.
    NRF_GPIO_PIN_S0D1 = GPIO_PIN_CNF_DRIVE_S0D1, ///< !< Standard '0', disconnect '1'.
    NRF_GPIO_PIN_H0D1 = GPIO_PIN_CNF_DRIVE_H0D1, ///< !< High-drive '0', disconnect '1'.
} nrf_gpio_pin_drive_t;

/**
 * @brief Enumerator used for selecting the pin to sense high or low level on the pin input.
 */
typedef enum
{
    NRF_GPIO_PIN_NOSENSE    = GPIO_PIN_CNF_SENSE_Disabled, ///<  Pin sense level disabled.
    NRF_GPIO_PIN_SENSE_LOW  = GPIO_PIN_CNF_SENSE_Low,      ///<  Pin sense low level.
    NRF_GPIO_PIN_SENSE_HIGH = GPIO_PIN_CNF_SENSE_High,     ///<  Pin sense high level.
} nrf_gpio_pin_sense_t;


void nrf_gpio_cfg(
    uint32_t             pin_number,
    nrf_gpio_pin_dir_t   dir,
    nrf_gpio_pin_input_t input,
    nrf_gpio_pin_pull_t  pull,
    nrf_gpio_pin_drive_t drive,
    nrf_gpio_pin_sense_t sense)
{
    NRF_P0->PIN_CNF[pin_number] = ((uint32_t)dir << GPIO_PIN_CNF_DIR_Pos)
                                   | ((uint32_t)input << GPIO_PIN_CNF_INPUT_Pos)
                                   | ((uint32_t)pull << GPIO_PIN_CNF_PULL_Pos)
                                   | ((uint32_t)drive << GPIO_PIN_CNF_DRIVE_Pos)
                                   | ((uint32_t)sense << GPIO_PIN_CNF_SENSE_Pos);
}

void nrf_gpio_cfg_output(uint32_t pin_number)
{
    nrf_gpio_cfg(
        pin_number,
        NRF_GPIO_PIN_DIR_OUTPUT,
        NRF_GPIO_PIN_INPUT_DISCONNECT,
        NRF_GPIO_PIN_NOPULL,
        NRF_GPIO_PIN_S0S1,
        NRF_GPIO_PIN_NOSENSE);
}

void nrf_gpio_pin_toggle(uint32_t pin_number)
{
    uint32_t pins_state = NRF_P0->OUT;

    NRF_P0->OUTSET = (~pins_state & (1UL << pin_number));
    NRF_P0->OUTCLR = (pins_state & (1UL << pin_number));
}

/**
 * @brief Function for application main entry.
 */
int main(void)
{
    nrf_gpio_cfg_output(LED_0);

    /* Toggle LEDs. */
    while (true)
    {
        nrf_gpio_pin_toggle(LED_0);
        nrf_delay_ms(500);
    }
}
