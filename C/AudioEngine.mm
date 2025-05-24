// Copyright (c) 2025 Brendan Robert Spear. All rights reserved.

#import <Foundation/Foundation.h>
#include "read_utils.h"

void AudioEngine_LoadFile(const char *path) {
    NSLog(@"[AudioEngine] Attempting to load: %s", path);
    int result = load_wav_file(path);
    if (result != 0) {
        NSLog(@"[AudioEngine] Failed to load WAV file.");
    } else {
        NSLog(@"[AudioEngine] Successfully loaded WAV file.");
    }
}
