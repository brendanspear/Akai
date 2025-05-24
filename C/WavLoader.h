//
//  WavLoader.h
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-22.
//  Copyright © 2025 Brendan Spear. All rights reserved.
//

#ifndef WAVLOADER_H
#define WAVLOADER_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    int16_t* data;
    size_t length;
    uint32_t sample_rate;
    uint16_t num_channels;
} WavData;

/**
 * Loads a WAV file from the specified path.
 * Returns a pointer to a WavData struct containing the sample data.
 * Returns NULL on failure.
 */
WavData* load_wav_file(const char* path);

/**
 * Frees the memory associated with the given WavData struct.
 */
void free_wav_data(WavData* wav);

#ifdef __cplusplus
}
#endif

#endif // WAVLOADER_H
