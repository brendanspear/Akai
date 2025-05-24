//
//  WavLoader.c
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-22.
//  Copyright © 2025 Brendan Spear. All rights reserved.
//

#include "WavLoader.h"
#include "safe_alloc.h"

#include <AudioToolbox/AudioToolbox.h>
#include <CoreFoundation/CoreFoundation.h>
#include <stdlib.h>
#include <string.h>

WavData* load_wav_file(const char* path) {
    CFURLRef url = CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8*)path, strlen(path), false);
    if (!url) return NULL;

    ExtAudioFileRef fileRef = NULL;
    OSStatus status = ExtAudioFileOpenURL(url, &fileRef);
    CFRelease(url);
    if (status != noErr) return NULL;

    AudioStreamBasicDescription fileFormat;
    UInt32 size = sizeof(fileFormat);
    ExtAudioFileGetProperty(fileRef, kExtAudioFileProperty_FileDataFormat, &size, &fileFormat);

    AudioStreamBasicDescription clientFormat = {0};
    clientFormat.mFormatID = kAudioFormatLinearPCM;
    clientFormat.mSampleRate = fileFormat.mSampleRate;
    clientFormat.mChannelsPerFrame = fileFormat.mChannelsPerFrame;
    clientFormat.mBitsPerChannel = 16;
    clientFormat.mBytesPerPacket = 2 * clientFormat.mChannelsPerFrame;
    clientFormat.mFramesPerPacket = 1;
    clientFormat.mBytesPerFrame = 2 * clientFormat.mChannelsPerFrame;
    clientFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;

    ExtAudioFileSetProperty(fileRef, kExtAudioFileProperty_ClientDataFormat, sizeof(clientFormat), &clientFormat);

    SInt64 numFrames = 0;
    size = sizeof(numFrames);
    ExtAudioFileGetProperty(fileRef, kExtAudioFileProperty_FileLengthFrames, &size, &numFrames);

    UInt32 numSamples = (UInt32)(numFrames * clientFormat.mChannelsPerFrame);
    int16_t* buffer = (int16_t*)safe_malloc(numSamples * sizeof(int16_t));
    if (!buffer) {
        ExtAudioFileDispose(fileRef);
        return NULL;
    }

    AudioBufferList bufList = {0};
    bufList.mNumberBuffers = 1;
    bufList.mBuffers[0].mNumberChannels = clientFormat.mChannelsPerFrame;
    bufList.mBuffers[0].mDataByteSize = (UInt32)(numSamples * sizeof(int16_t));
    bufList.mBuffers[0].mData = buffer;

    UInt32 framesToRead = (UInt32)numFrames;
    status = ExtAudioFileRead(fileRef, &framesToRead, &bufList);

    WavData* wav = (WavData*)safe_malloc(sizeof(WavData));
    if (!wav) {
        free(buffer);
        ExtAudioFileDispose(fileRef);
        return NULL;
    }

    wav->data = buffer;
    wav->length = numSamples;
    wav->sample_rate = (uint32_t)clientFormat.mSampleRate;
    wav->num_channels = clientFormat.mChannelsPerFrame;

    ExtAudioFileDispose(fileRef);
    return wav;
}

void free_wav_data(WavData* wav) {
    if (!wav) return;
    if (wav->data) free(wav->data);
    free(wav);
}
