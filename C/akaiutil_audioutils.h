
#ifndef AKAIUTIL_AUDIOUTILS_H
#define AKAIUTIL_AUDIOUTILS_H

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include "sample.h"
#include "akai_model.h"

#ifdef __cplusplus
extern "C" {
#endif

// Audio processing helpers
bool convert_to_mono_pcm16(sample_t* sample);
bool normalize_pcm16_internal(int16_t* data, size_t length);
bool trim_silence_pcm16_internal(int16_t* data, size_t* length);
bool pad_silence_end_pcm16_internal(sample_t* sample, int milliseconds);
bool adjust_to_akai_compatibility_internal(sample_t* sample, AkaiModel model);

#ifdef __cplusplus
}
#endif

#endif /* AKAIUTIL_AUDIOUTILS_H */
