//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_CHECK_H
#define AKAIUTIL_CHECK_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

// Check if PCM audio is compatible with a given Akai sampler model
// Returns 1 if compatible, 0 otherwise
int check_compatibility(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth, const char *model);

// Individual checks (used internally or externally as needed)
int akai_check_compatibility_s900(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth);
int akai_check_compatibility_s1000(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth);
int akai_check_compatibility_s3000(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_CHECK_H
