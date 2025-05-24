//
//  akaiutil_api.c
//  AkaiSConvert
//

#include "akaiutil_api.h"
#include "akaiutil_audioutils.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

sample_t* create_sample_from_pcm(const int16_t* data, size_t sample_count, uint32_t rate, uint8_t bits, uint8_t channels) {
    if (!data || sample_count == 0) return NULL;
    sample_t* sample = malloc(sizeof(sample_t));
    if (!sample) return NULL;
    sample->data = malloc(sample_count * sizeof(int16_t));
    if (!sample->data) {
        free(sample);
        return NULL;
    }
    memcpy(sample->data, data, sample_count * sizeof(int16_t));
    sample->length = sample_count;
    sample->rate = rate;
    sample->bits = bits;
    sample->channels = channels;
    snprintf(sample->name, sizeof(sample->name), "Exported");
    return sample;
}

void free_sample(sample_t* sample) {
    if (sample) {
        if (sample->data) free(sample->data);
        free(sample);
    }
}

bool process_samples_with_options(sample_t* sample, const AkaiExportOptions* options) {
    if (!sample || !options) return false;

    if (options->normalize) {
        if (!normalize_pcm16_internal(sample->data, sample->length)) return false;
    }
    if (options->trim_silence) {
        if (!trim_silence_pcm16_internal(sample->data, &sample->length)) return false;
    }
    if (options->pad_silence) {
        if (!pad_silence_end_pcm16_internal(sample, options->silence_ms)) return false;
    }
    return true;
}

bool adjust_to_akai_compatibility(sample_t* sample, AkaiModel model) {
    return adjust_to_akai_compatibility_internal(sample, model);
}
