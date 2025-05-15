#ifndef AKAIUTIL_IO_H
#define AKAIUTIL_IO_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>
#include <stdint.h>

int akai_convert_16bit_to_12bit(const int16_t *input, int input_len, uint8_t *output, int output_max_len);
int akai_convert_12bit_to_16bit(const uint8_t *input, int input_len, int16_t *output, int output_max_len);


// Read entire file into memory
uint8_t *read_file(const char *filename, size_t *length);

// Write buffer to file
int write_file(const char *filename, const uint8_t *data, size_t length);

// Load 16-bit PCM samples from WAV file
int16_t *load_wav_pcm16(const char *filename, size_t *sample_count, uint32_t *sample_rate, uint8_t *channels);

// Save 16-bit PCM samples as WAV file
int save_pcm16_as_wav(const char *filename, const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t channels);

// Utility to generate output filename with new extension
void generate_output_filename(const char *input, const char *ext, char *output, size_t max_len);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_IO_H
