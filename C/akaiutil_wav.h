//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_WAV_H
#define AKAIUTIL_WAV_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

// Metadata structure for WAV files
typedef struct {
    uint16_t audio_format;    // PCM = 1
    uint16_t channels;        // Mono = 1, Stereo = 2
    uint32_t sample_rate;
    uint32_t byte_rate;
    uint16_t block_align;
    uint16_t bits_per_sample;
    uint32_t data_size;
} wav_metadata_t;

// Function declarations
int parse_wav_header(const uint8_t *buffer, size_t size, wav_metadata_t *meta, size_t *data_offset);
int is_wav_compatible_for_sampler(const wav_metadata_t *meta, uint16_t sampler_model);
int convert_wav_to_pcm16(const uint8_t *in_buffer, size_t in_size, int16_t *out_samples, size_t out_capacity);
int normalize_pcm_audio(int16_t *samples, size_t length, float factor);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_WAV_H
