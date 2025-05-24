//
//  akaiutil_io.h
//  AkaiSConvert
//
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Adapted and modernized by Brendan Spear
//  Released under GNU GPL v3.0
//

#ifndef AKAIUTIL_IO_H
#define AKAIUTIL_IO_H

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include "akai_disk.h"

#ifdef __cplusplus
extern "C" {
#endif

// File utility functions
uint8_t *read_file(const char *filename, size_t *length);
int write_file(const char *filename, const uint8_t *data, size_t length);

// WAV I/O (using libsndfile)
int16_t *load_wav_pcm16(const char *filename, size_t *sample_count, uint32_t *sample_rate, uint8_t *channels);
int save_pcm16_as_wav(const char *filename, const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t channels);

// Path utilities
void generate_output_filename(const char *input, const char *ext, char *output, size_t max_len);

// Akai conversion
int akai_convert_16bit_to_12bit(const int16_t *input, int input_len, uint8_t *output, int output_max_len);
int akai_convert_12bit_to_16bit(const uint8_t *input, int input_len, int16_t *output, int output_max_len);

// Export Akai disk image
int write_akai_disk_to_file(const disk_t *disk, const char *output_path);

#ifdef __cplusplus
}
#endif

#endif /* AKAIUTIL_IO_H */
