//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include "akaiutil_check.h"
#include <string.h>

// Internal logic for S900 compatibility
int akai_check_compatibility_s900(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth) {
    if (!samples || sample_count == 0) return 0;
    if (bit_depth != 12) return 0;
    if (sample_rate > 37500) return 0;  // S900 max ~37.5kHz
    return 1;
}

// Internal logic for S1000 compatibility
int akai_check_compatibility_s1000(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth) {
    if (!samples || sample_count == 0) return 0;
    if (bit_depth != 16) return 0;
    if (sample_rate > 44100) return 0;  // S1000 max ~44.1kHz
    return 1;
}

// Internal logic for S3000 compatibility
int akai_check_compatibility_s3000(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth) {
    if (!samples || sample_count == 0) return 0;
    if (bit_depth != 16) return 0;
    if (sample_rate > 48000) return 0;  // S3000 max ~48kHz
    return 1;
}

// Dispatcher based on model string
int check_compatibility(const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t bit_depth, const char *model) {
    if (!model) return 0;

    if (strcmp(model, "S900") == 0) {
        return akai_check_compatibility_s900(samples, sample_count, sample_rate, bit_depth);
    } else if (strcmp(model, "S1000") == 0) {
        return akai_check_compatibility_s1000(samples, sample_count, sample_rate, bit_depth);
    } else if (strcmp(model, "S3000") == 0) {
        return akai_check_compatibility_s3000(samples, sample_count, sample_rate, bit_depth);
    }

    return 0; // Unknown model
}
