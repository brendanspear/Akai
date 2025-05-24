//  akai_export.c
//  AkaiSConvert
//
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008–2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Updated by Brendan Spear under GNU GPL v3.0
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sample.h"
#include "akaiutil_io.h"
#include "akaiutil_audioutils.h"
#include "akaiutil_file.h"
#include "akaiutil_check.h"
#include "akaiutil_api.h"
#include "akai_export.h"
#include "akai_disk.h"

bool export_sample_to_akai_format(const char* input_path, const char* output_path, const AkaiExportOptions* options, AkaiModel model) {
    size_t sample_count;
    uint32_t sample_rate;
    uint8_t channels;

    int16_t* pcm_data = load_wav_pcm16(input_path, &sample_count, &sample_rate, &channels);
    fprintf(stderr, "Loaded WAV: pcm_data=%p, sample_count=%zu, rate=%u, channels=%u\n",
            (void*)pcm_data, sample_count, sample_rate, channels);

    if (!pcm_data) {
        fprintf(stderr, "\n❌ Failed to load sample from %s\n", input_path);
        return false;
    }

    sample_t* sample = create_sample_from_pcm(pcm_data, sample_count, sample_rate, 16, channels);
    free(pcm_data);

    if (!sample) {
        fprintf(stderr, "\n❌ Failed to create sample structure\n");
        return false;
    }

    fprintf(stderr, "Created sample: sample=%p, data=%p, length=%zu, rate=%u, bits=%u, channels=%u\n",
            (void*)sample, (void*)sample->data, sample->length, sample->rate, sample->bits, sample->channels);

    if (options) {
        if (options->normalize) normalize_pcm16(sample);
        if (options->trim_silence) trim_silence_pcm16(sample);
        if (options->pad_silence) pad_silence_end_pcm16(sample, options->silence_ms);
        if (options->force_mono && sample->channels > 1) {
            convert_to_mono_pcm16(sample);
        }
    }

    adjust_to_akai_compatibility(sample, model);

    disk_t* disk = create_akai_disk(model);
    if (!disk) {
        fprintf(stderr, "\n❌ Failed to create Akai disk\n");
        free_sample(sample);
        return false;
    }

    if (!add_sample_to_disk(disk, sample, model)) {
        fprintf(stderr, "\n❌ Failed to add sample to disk\n");
        free_sample(sample);
        free_disk(disk);
        return false;
    }

    if (!write_akai_disk_to_file(disk, output_path)) {
        fprintf(stderr, "\n❌ Failed to write disk to file\n");
        free_sample(sample);
        free_disk(disk);
        return false;
    }

    free_sample(sample);
    free_disk(disk);
    return true;
}
