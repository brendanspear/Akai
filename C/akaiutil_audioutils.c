//
//  akaiutil_audioutils.c
//  AkaiSConvert
//
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008–2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Updated by Brendan Spear under GNU GPL v3.0
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

#include "sample.h"
#include "akai_model.h"
#include "akaiutil_audioutils.h"

bool normalize_pcm16_internal(int16_t* data, size_t length) {
    if (!data || length == 0) return false;

    int16_t max_val = 0;
    for (size_t i = 0; i < length; ++i) {
        int16_t abs_val = abs(data[i]);
        if (abs_val > max_val) {
            max_val = abs_val;
        }
    }

    if (max_val == 0) return true; // Already silent

    float scale = 32767.0f / max_val;
    for (size_t i = 0; i < length; ++i) {
        data[i] = (int16_t)(data[i] * scale);
    }

    return true;
}

bool trim_silence_pcm16_internal(int16_t* data, size_t* length) {
    if (!data || !length || *length == 0) return false;

    const int threshold = 100;
    size_t start = 0;
    size_t end = *length - 1;

    while (start < *length && abs(data[start]) < threshold) start++;
    while (end > start && abs(data[end]) < threshold) end--;

    size_t new_len = end - start + 1;
    if (new_len == 0) return false;

    memmove(data, data + start, new_len * sizeof(int16_t));
    *length = new_len;

    return true;
}

bool pad_silence_end_pcm16_internal(sample_t* sample, int milliseconds) {
    if (!sample || sample->rate == 0) return false;

    size_t pad_samples = (milliseconds * sample->rate) / 1000;
    size_t new_len = sample->length + pad_samples;

    int16_t* new_data = realloc(sample->data, new_len * sizeof(int16_t));
    if (!new_data) return false;

    memset(new_data + sample->length, 0, pad_samples * sizeof(int16_t));

    sample->data = new_data;
    sample->length = new_len;

    return true;
}

bool adjust_to_akai_compatibility_internal(sample_t* sample, AkaiModel model) {
    if (!sample) return false;

    if (model == AKAI_MODEL_S900 && sample->channels > 1) {
        size_t mono_len = sample->length / sample->channels;
        int16_t* mono_data = malloc(mono_len * sizeof(int16_t));
        if (!mono_data) return false;

        for (size_t i = 0; i < mono_len; ++i) {
            int32_t sum = 0;
            for (uint8_t c = 0; c < sample->channels; ++c) {
                sum += ((int16_t*)sample->data)[i * sample->channels + c];
            }
            mono_data[i] = (int16_t)(sum / sample->channels);
        }

        free(sample->data);
        sample->data = mono_data;
        sample->length = mono_len;
        sample->channels = 1;
    }

    return true;
}

bool convert_to_mono_pcm16(sample_t* sample) {
    if (!sample || sample->channels <= 1) return false;

    size_t mono_len = sample->length;
    int16_t* mono_data = malloc(mono_len * sizeof(int16_t));
    if (!mono_data) return false;

    for (size_t i = 0; i < mono_len; ++i) {
        int32_t sum = 0;
        for (int c = 0; c < sample->channels; ++c) {
            sum += ((int16_t*)sample->data)[i * sample->channels + c];
        }
        mono_data[i] = (int16_t)(sum / sample->channels);
    }

    free(sample->data);
    sample->data = mono_data;
    sample->channels = 1;

    return true;
}
// Public wrappers to expose internal functions via header

bool normalize_pcm16(sample_t* sample) {
    if (!sample || !sample->data || sample->length == 0) return false;
    return normalize_pcm16_internal(sample->data, sample->length);
}

bool trim_silence_pcm16(sample_t* sample) {
    if (!sample || !sample->data || sample->length == 0) return false;
    return trim_silence_pcm16_internal(sample->data, &sample->length);
}

bool pad_silence_end_pcm16(sample_t* sample, int milliseconds) {
    return pad_silence_end_pcm16_internal(sample, milliseconds);
}
