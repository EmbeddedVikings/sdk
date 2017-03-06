#ifndef N_GPIO_H
#define N_GPIO_H

#include <nrf.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifdef NRF_GPIO
#   define N_GPIO_P0        NRF_P0

#else
#   ifdef NRF_P0
#       define N_GPIO_P0    NRF_P0
#   endif // NRF_P0

#   ifdef NRF_P1
#       define N_GPIO_P1    NRF_P1
#   endif // NRF_P1
#endif // NRF_GPIO

#define N_GPIO_CNF(_dir, _input, _pull, _drive, _sense) (                   \
    (((_dir)   & GPIO_PIN_CNF_DIR_Msk)   << GPIO_PIN_CNF_DIR_Pos)   ||      \
    (((_input) & GPIO_PIN_CNF_INPUT_Msk) << GPIO_PIN_CNF_INPUT_Pos) ||      \
    (((_pull)  & GPIO_PIN_CNF_PULL_Msk)  << GPIO_PIN_CNF_PULL_Pos)  ||      \
    (((_drive) & GPIO_PIN_CNF_DRIVE_Msk) << GPIO_PIN_CNF_DRIVE_Pos) ||      \
    (((_sense) & GPIO_PIN_CNF_SENSE_Msk) << GPIO_PIN_CNF_SENSE_Pos))

#define N_GPIO_CNF_STD_OUTPUT   N_GPIO_CNF(GPIO_PIN_CNF_DIR_Output,         \
                                           GPIO_PIN_CNF_INPUT_Disconnect,   \
                                           GPIO_PIN_CNF_PULL_Disabled,      \
                                           GPIO_PIN_CNF_DRIVE_S0S1,         \
                                           GPIO_PIN_CNF_SENSE_Disabled)

#define N_GPIO_CNF_STD_INPUT    N_GPIO_CNF(GPIO_PIN_CNF_DIR_Input,          \
                                           GPIO_PIN_CNF_INPUT_Connect,      \
                                           GPIO_PIN_CNF_PULL_Disabled,      \
                                           GPIO_PIN_CNF_DRIVE_S0S1,         \
                                           GPIO_PIN_CNF_SENSE_Disabled)

#define N_GPIO_CNF_DEFAULT      N_GPIO_CNF(GPIO_PIN_CNF_DIR_Input,          \
                                           GPIO_PIN_CNF_INPUT_Disconnect,   \
                                           GPIO_PIN_CNF_PULL_Disabled,      \
                                           GPIO_PIN_CNF_DRIVE_S0S1,         \
                                           GPIO_PIN_CNF_SENSE_Disabled)

typedef NRF_GPIO_Type n_gpio_port_t;

typedef struct {
    n_gpio_port_t * p_port;
    uint32_t        pin;
} n_gpio_pin_t;


#define N_GPIO_PIN(_port, _pin) {   \
    .p_port = (_port),              \
    .pin    = (_pin),               \
}

void n_gpio_cnf(n_gpio_port_t * p_port,
                uint32_t        pin,
                uint32_t        cnf);

void n_gpio_pin_set(n_gpio_port_t * p_port,
                    uint32_t        pin);

void n_gpio_pin_clr(n_gpio_port_t * p_port,
                    uint32_t        pin);

void n_gpio_port_write(n_gpio_port_t * p_port,
                       uint32_t        mask);

bool n_gpio_pin_is_set(n_gpio_port_t * p_port,
                       uint32_t        pin);

uint32_t n_gpio_port_read(n_gpio_port_t * p_port);

void n_gpio_pin_latch_enable(n_gpio_port_t * p_port,
                             uint32_t        pin);

void n_gpio_pin_latch_disable(n_gpio_port_t * p_port,
                              uint32_t        pin);

bool n_gpio_pin_latch_get(n_gpio_port_t * p_port,
                          uint32_t        pin);

void n_gpio_pin_latch_clear(n_gpio_port_t * p_port,
                            uint32_t        pin);

#ifdef __cplusplus
}
#endif

#endif // N_GPIO_H
