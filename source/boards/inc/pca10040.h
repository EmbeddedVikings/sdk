/* Copyright (c) 2014 Nordic Semiconductor. All Rights Reserved.
 *
 * The information contained herein is property of Nordic Semiconductor ASA.
 * Terms and conditions of usage are described in detail in NORDIC
 * SEMICONDUCTOR STANDARD SOFTWARE LICENSE AGREEMENT.
 *
 * Licensees are granted free, non-transferable use of the information. NO
 * WARRANTY of ANY KIND is provided. This heading must NOT be removed from
 * the file.
 *
 */
#ifndef PCA10040_H__
#define PCA10040_H__

#include "nrf.h"

#ifdef __cplusplus
extern "C" {
#endif
#define LEDS_NUMBER    4

#define LED_0          17
#define LED_1          18
#define LED_2          19
#define LED_3          20

#define LEDS_ACTIVE_STATE 0

#define LEDS_INV_MASK  LEDS_MASK

#define LEDS_LIST { LED_0, LED_1, LED_2, LED_3 }

#ifdef __cplusplus
}
#endif

#endif // PCA10040_H__
