//  akaiutil_api.h
//  AkaiSConvert
//
//  Main interface for processing audio samples into Akai format

#ifndef AKAIUTIL_API_H
#define AKAIUTIL_API_H

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include "sample.h"
#include "akai_export.h"
#include "akai_model.h"

#ifdef __cplusplus
extern "C" {
#endif

// Core sample creation/destruction
sample_t* create_sample_from_pcm(const int16_t* data, size_t sample_count, uint32_t rate, uint8_t bits, uint8_t channels);
void free_sample(sample_t* sample);

// Safe wrapper versions for audio processing
bool normalize_pcm16(sample_t* sample);
bool trim_silence_pcm16(sample_t* sample);
bool pad_silence_end_pcm16(sample_t* sample, int milliseconds);
bool convert_to_mono_pcm16(sample_t* sample);

// Export-oriented processing helpers
bool adjust_to_akai_compatibility(sample_t* sample, AkaiModel model);
bool process_samples_with_options(sample_t* sample, const AkaiExportOptions* options);

#ifdef __cplusplus
}
#endif

#endif /* AKAIUTIL_API_H */
