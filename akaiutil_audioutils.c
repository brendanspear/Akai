#include "akaiutil_audioutils.h"
#include <stdlib.h>
#include <string.h>
#include <math.h>

// Normalize to full 16-bit range
void normalize_pcm16(int16_t *samples, size_t count) {
    int16_t max_val = 0;
    for (size_t i = 0; i < count; ++i) {
        if (abs(samples[i]) > max_val) {
            max_val = abs(samples[i]);
        }
    }

    if (max_val == 0) return;

    float gain = 32767.0f / max_val;
    for (size_t i = 0; i < count; ++i) {
        samples[i] = (int16_t)(samples[i] * gain);
    }
}

// Trim silence using threshold
int16_t *trim_silence_pcm16(const int16_t *samples, size_t count, size_t *new_count, int16_t threshold) {
    size_t start = 0;
    while (start < count && abs(samples[start]) <= threshold) {
        start++;
    }

    size_t end = count;
    while (end > start && abs(samples[end - 1]) <= threshold) {
        end--;
    }

    *new_count = end - start;
    int16_t *trimmed = malloc(*new_count * sizeof(int16_t));
    if (!trimmed) return NULL;

    memcpy(trimmed, &samples[start], *new_count * sizeof(int16_t));
    return trimmed;
}

// Pad silence at end
int16_t *pad_silence_end_pcm16(const int16_t *samples, size_t count, size_t pad_ms, uint32_t sample_rate, size_t *new_count) {
    size_t pad_samples = (pad_ms * sample_rate) / 1000;
    *new_count = count + pad_samples;

    int16_t *padded = malloc(*new_count * sizeof(int16_t));
    if (!padded) return NULL;

    memcpy(padded, samples, count * sizeof(int16_t));
    memset(padded + count, 0, pad_samples * sizeof(int16_t));

    return padded;
}

// Akai compatibility checker
bool is_sample_compatible(uint32_t sample_rate, uint16_t bit_depth, uint8_t channels, const char *model) {
    if (strcmp(model, "S900") == 0) {
        return sample_rate <= 40000 && bit_depth == 12 && channels == 1;
    } else if (strcmp(model, "S1000") == 0) {
        return sample_rate <= 44100 && bit_depth == 16 && channels <= 2;
    } else if (strcmp(model, "S3000") == 0) {
        return sample_rate <= 48000 && bit_depth == 16 && channels <= 2;
    }
    return false;
}

// Adjust sample for Akai compatibility (mono + 44.1kHz resample + convert to 16-bit)
int16_t *adjust_to_akai_compatibility(const int16_t *input, size_t in_count, uint32_t in_rate,
                                      uint8_t in_channels, size_t *out_count,
                                      uint32_t *out_rate, uint8_t *out_channels, const char *model) {
    *out_count = in_count;
    *out_rate = in_rate;
    *out_channels = in_channels;

    // Force mono if S900
    int16_t *intermediate = NULL;
    if (strcmp(model, "S900") == 0 && in_channels > 1) {
        *out_channels = 1;
        *out_count = in_count / in_channels;

        intermediate = malloc(*out_count * sizeof(int16_t));
        if (!intermediate) return NULL;

        for (size_t i = 0; i < *out_count; ++i) {
            int32_t sum = 0;
            for (uint8_t c = 0; c < in_channels; ++c) {
                sum += input[i * in_channels + c];
            }
            intermediate[i] = (int16_t)(sum / in_channels);
        }
    } else {
        intermediate = malloc(in_count * sizeof(int16_t));
        if (!intermediate) return NULL;
        memcpy(intermediate, input, in_count * sizeof(int16_t));
    }

    // TODO: Add optional resampling in v2 if needed

    return intermediate;
}
