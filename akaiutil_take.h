

#include <stdint.h>
#include <stddef.h>
#include "akaiutil_tar.h"

#ifndef AKAIUTIL_TAKE_H
#define AKAIUTIL_TAKE_H

#ifdef __cplusplus
extern "C" {
#endif

// Forward declaration of structs to ensure visibility across headers
struct sample_s;

// Define sample metadata structure
typedef struct sample_s {
    uint32_t total_length;
    uint16_t sample_rate;
    uint8_t channels; // 1 for mono, 2 for stereo
    uint8_t bit_depth; // 8 or 16
    part_t *parts;
    char name[64];
} sample_t;

// Function declarations
int akai_split_sample(const int16_t *input, size_t length, sample_t *out);
void akai_free_sample(sample_t *sample);
int akai_trim_silence(int16_t *buffer, size_t *length);
int akai_add_silence(int16_t *buffer, size_t *length, size_t max_length, uint32_t milliseconds, uint32_t sample_rate);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_TAKE_H
