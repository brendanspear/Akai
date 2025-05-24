//
//  akaiutil_check.c
//  AkaiSConvert
//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include "akaiutil_check.h"
#include "sample.h"
#include <string.h>

// Internal logic for S900 compatibility
int akai_check_compatibility_s900(const sample_t* sample) {
    if (!sample || sample->length == 0) return 0;
    if (sample->bits != 12) return 0;
    if (sample->rate > 37500) return 0;  // S900 max ~37.5kHz
    if (sample->channels != 1) return 0;
    return 1;
}

// Internal logic for S1000 compatibility
int akai_check_compatibility_s1000(const sample_t* sample) {
    if (!sample || sample->length == 0) return 0;
    if (sample->bits != 16) return 0;
    if (sample->rate > 44100) return 0;
    return 1;
}

// Internal logic for S3000 compatibility
int akai_check_compatibility_s3000(const sample_t* sample) {
    if (!sample || sample->length == 0) return 0;
    if (sample->bits != 16) return 0;
    if (sample->rate > 48000) return 0;
    return 1;
}

// Dispatcher based on model
bool check_akai_compatibility(const sample_t* sample, AkaiModel model) {
    if (!sample) return false;

    switch (model) {
        case AKAI_MODEL_S900:
            return akai_check_compatibility_s900(sample);
        case AKAI_MODEL_S1000:
            return akai_check_compatibility_s1000(sample);
        case AKAI_MODEL_S3000:
            return akai_check_compatibility_s3000(sample);
        default:
            return false;
    }
}
