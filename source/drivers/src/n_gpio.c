#include <stddef.h>
#include <stdbool.h>
#include <n_gpio.h>
#include <n_assert.h>

void n_gpio_cnf(n_gpio_port_t * p_port,
                uint32_t        pin,
                uint32_t        cnf)
{
    N_ASSERT(p_port != NULL);
    N_ASSERT(pin < 32);

    p_port->PIN_CNF[pin] = cnf;
}

void n_gpio_pin_set(n_gpio_port_t * p_port,
                    uint32_t        pin)
{
    N_ASSERT(p_port != NULL);
    N_ASSERT(pin < 32);

    p_port->OUTSET = (1UL << pin);
}

void n_gpio_pin_clr(n_gpio_port_t * p_port,
                    uint32_t        pin)
{
    N_ASSERT(p_port != NULL);
    N_ASSERT(pin < 32);

    p_port->OUTCLR = (1UL << pin);
}

void n_gpio_port_write(n_gpio_port_t * p_port,
                       uint32_t        mask)
{
    N_ASSERT(p_port);

    p_port->OUT = mask;
}

bool n_gpio_pin_is_set(n_gpio_port_t * p_port,
                       uint32_t        pin)
{
    N_ASSERT(p_port);
    N_ASSERT(pin < 32);

    return (p_port->IN & (1UL << pin)) ? true : false;
}

uint32_t n_gpio_port_read(n_gpio_port_t * p_port)
{
    N_ASSERT(p_port);

    return p_port->IN;
}

void n_gpio_pin_latch_enable(n_gpio_port_t * p_port,
                             uint32_t        pin)
{
    N_ASSERT(p_port);
    N_ASSERT(pin < 32);

    uint32_t detect_mode = p_port->DETECTMODE;

    p_port->DETECTMODE = detect_mode | (1UL << pin);
}

void n_gpio_pin_latch_disable(n_gpio_port_t * p_port,
                              uint32_t        pin)
{
    N_ASSERT(p_port);
    N_ASSERT(pin < 32);

    uint32_t detect_mode = p_port->DETECTMODE;

    p_port->DETECTMODE = detect_mode & ~(1UL << pin);
}

bool n_gpio_pin_latch_get(n_gpio_port_t * p_port,
                          uint32_t        pin)
{
    N_ASSERT(p_port);
    N_ASSERT(pin < 32);

    return (p_port->LATCH & (1 << pin)) ? true : false;
}

void n_gpio_pin_latch_clear(n_gpio_port_t * p_port,
                            uint32_t        pin)
{
    N_ASSERT(p_port);
    N_ASSERT(pin < 32);

    p_port->LATCH = (1 << pin);
}
