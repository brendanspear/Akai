// Bridging-Header.h
#import <stdint.h>
#import <stdio.h>
#import "akaiutil.h"
#include "akaiutil.h"
#include "akaiutil_tar.h"
#include "akaiutil_check.h"
// ... add any .h files that contain function declarations

int32_t akai_convert_16bit_to_12bit(const int16_t* in, int32_t inCount, uint8_t* out, int32_t outMax);
int32_t akai_convert_12bit_to_16bit(const uint8_t* in, int32_t inCount, int16_t* out, int32_t outMax);
