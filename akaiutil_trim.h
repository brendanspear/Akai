#ifndef AKAIUTIL_TRIM_H
#define AKAIUTIL_TRIM_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

// Trim leading and trailing silence from 16-bit PCM audio.
// Returns the new length via out_sample_count.
int16_t *trim_silence(const int16_t *samples, size_t sample_count, size_t *out_sample_count);

// Pad audio with silence (zeros) at the end.
// Returns a new buffer, updates out_sample_count.
int16_t *pad_silence(const int16_t *samples, size_t sample_count, size_t pad_ms, uint32_t sample_rate, size_t *out_sample_count);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_TRIM_H
