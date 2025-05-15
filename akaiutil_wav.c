#include "akaiutil_wav.h"
#include <string.h>
#include <stdio.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

static uint32_t read_uint32_le(const uint8_t *ptr) {
    return (uint32_t)ptr[0] | ((uint32_t)ptr[1] << 8) | ((uint32_t)ptr[2] << 16) | ((uint32_t)ptr[3] << 24);
}

static uint16_t read_uint16_le(const uint8_t *ptr) {
    return (uint16_t)ptr[0] | ((uint16_t)ptr[1] << 8);
}

int parse_wav_header(const uint8_t *buffer, size_t size, wav_metadata_t *meta, size_t *data_offset) {
    if (size < 44 || memcmp(buffer, "RIFF", 4) != 0 || memcmp(buffer + 8, "WAVE", 4) != 0) {
        return -1;
    }

    size_t offset = 12;
    while (offset + 8 <= size) {
        uint32_t chunk_size = read_uint32_le(buffer + offset + 4);
        if (memcmp(buffer + offset, "fmt ", 4) == 0) {
            if (chunk_size < 16 || offset + 8 + chunk_size > size) return -2;
            meta->audio_format = read_uint16_le(buffer + offset + 8);
            meta->channels = read_uint16_le(buffer + offset + 10);
            meta->sample_rate = read_uint32_le(buffer + offset + 12);
            meta->byte_rate = read_uint32_le(buffer + offset + 16);
            meta->block_align = read_uint16_le(buffer + offset + 20);
            meta->bits_per_sample = read_uint16_le(buffer + offset + 22);
        } else if (memcmp(buffer + offset, "data", 4) == 0) {
            meta->data_size = chunk_size;
            *data_offset = offset + 8;
            return 0;
        }
        offset += 8 + chunk_size;
    }

    return -3; // "data" chunk not found
}

int is_wav_compatible_for_sampler(const wav_metadata_t *meta, uint16_t sampler_model) {
    if (meta->audio_format != 1) return 0; // Only PCM
    if (meta->channels != 1) return 0;     // Mono only for full compatibility
    if (meta->bits_per_sample != 16) return 0;
    if (sampler_model == 900 && meta->sample_rate > 40000) return 0; // S900 specific limits
    return 1;
}

int convert_wav_to_pcm16(const uint8_t *in_buffer, size_t in_size, int16_t *out_samples, size_t out_capacity) {
    if (in_size / 2 > out_capacity) return -1;
    for (size_t i = 0; i < in_size / 2; ++i) {
        out_samples[i] = (int16_t)(in_buffer[2 * i] | (in_buffer[2 * i + 1] << 8));
    }
    return 0;
}

int normalize_pcm_audio(int16_t *samples, size_t length, float factor) {
    if (factor <= 0.0f || factor == 1.0f) return 0;
    for (size_t i = 0; i < length; ++i) {
        float scaled = samples[i] * factor;
        if (scaled > 32767.0f) scaled = 32767.0f;
        else if (scaled < -32768.0f) scaled = -32768.0f;
        samples[i] = (int16_t)scaled;
    }
    return 0;
}
