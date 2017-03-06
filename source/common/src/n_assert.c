#include <stdbool.h>
#include <n_assert.h>
#include <nrf.h>

__WEAK void n_assert_callback(uint16_t line_num, const uint8_t * p_file_name)
{
    static volatile struct
    {
        uint32_t        line_num;
        const uint8_t * p_file_name;
    } m_assert_data = {0};

    __disable_irq();
    m_assert_data.line_num      = line_num;
    m_assert_data.p_file_name   = p_file_name;
    (void)m_assert_data;

    while (true);
}
