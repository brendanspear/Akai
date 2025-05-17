//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_AUDIOUTILS_H
#define AKAIUTIL_AUDIOUTILS_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

// Normalize PCM 16-bit samples to full scale
void normalize_pcm16(int16_t *samples, size_t count);

// Trim leading/trailing silence (based on a threshold value)
int16_t *trim_silence_pcm16(const int16_t *samples, size_t count, size_t *new_count, int16_t threshold);

// Pad silence (zero samples) to the end for timing compatibility
int16_t *pad_silence_end_pcm16(const int16_t *samples, size_t count, size_t pad_ms, uint32_t sample_rate, size_t *new_count);

// Check if sample matches Akai model limitations
bool is_sample_compatible(uint32_t sample_rate, uint16_t bit_depth, uint8_t channels, const char *model);

// Auto-adjust audio (e.g. downmix to mono) to match Akai model compatibility
int16_t *adjust_to_akai_compatibility(const int16_t *input, size_t in_count, uint32_t in_rate,
                                      uint8_t in_channels, size_t *out_count,
                                      uint32_t *out_rate, uint8_t *out_channels, const char *model);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_AUDIOUTILS_H
