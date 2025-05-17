//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include "akaiutil_take.h"
#include <stdlib.h>
#include <string.h>
#include "akaiutil_trim.h"


// Threshold below which values are considered silence
#define SILENCE_THRESHOLD 100

// Trim silence from start and end of buffer
int akai_trim_silence(int16_t *buffer, size_t *length) {
    if (!buffer || !length || *length == 0) return -1;

    size_t start = 0;
    size_t end = *length - 1;

    // Find start point
    while (start < *length && abs(buffer[start]) < SILENCE_THRESHOLD) {
        start++;
    }

    // Find end point
    while (end > start && abs(buffer[end]) < SILENCE_THRESHOLD) {
        end--;
    }

    size_t new_length = end - start + 1;

    if (start > 0 && new_length > 0) {
        memmove(buffer, buffer + start, new_length * sizeof(int16_t));
    }

    *length = new_length;
    return 0;
}

// Add X ms of silence to end of sample (max_length must include this room)
int akai_add_silence(int16_t *buffer, size_t *length, size_t max_length, uint32_t milliseconds, uint32_t sample_rate) {
    if (!buffer || !length || sample_rate == 0) return -1;

    size_t additional_samples = (milliseconds * sample_rate) / 1000;

    if (*length + additional_samples > max_length) {
        return -2; // Not enough room
    }

    memset(buffer + *length, 0, additional_samples * sizeof(int16_t));
    *length += additional_samples;

    return 0;
}
