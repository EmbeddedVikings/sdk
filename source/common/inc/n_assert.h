#ifndef N_ASSERT_H
#define N_ASSERT_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef N_ASSERT_ENABLED
#   ifdef DEBUG
#       define N_ASSERT_ENABLED true
#   else
#       define N_ASSERT_ENABLED false
#   endif // DEBUG
#endif // N_ASSERT_ENABLED

void n_assert_callback(uint16_t line_num, const uint8_t * p_file_name);

#define N_ASSERT(_expr)                                             \
    if ((N_ASSERT_ENABLED) && (_expr))                              \
    {                                                               \
        n_assert_callback((uint16_t)__LINE__, (uint8_t *)__FILE__); \
    }

#ifdef __cplusplus
}
#endif
#endif // N_ASSERT_H
