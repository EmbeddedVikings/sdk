
#ifndef STARTUP_CONFIG_H__
#define STARTUP_CONFIG_H__

#ifdef __cplusplus
extern "C" {
#endif

#define STARTUP_CONFIG_STACK_SIZE           0x1000
#define STARTUP_CONFIG_HEAP_SIZE            0x0000
#define STARTUP_CONFIG_INIT_DATA            1
#define STARTUP_CONFIG_CLEAR_BSS            0

#ifdef __cplusplus
}
#endif

#endif // STARTUP_CONFIG_H__
