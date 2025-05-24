//
//  akaiutil_io.c
//  AkaiSConvert
//
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Adapted and modernized by Brendan Spear
//  Released under GNU GPL v3.0
//

#include "akaiutil_io.h"
#include "akaiutil_tar.h"  // For disk image generation
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "akai_disk.h"
#include <sndfile.h>  // Requires linking with libsndfile

uint8_t *read_file(const char *filename, size_t *length) {
    FILE *fp = fopen(filename, "rb");
    if (!fp) return NULL;

    fseek(fp, 0, SEEK_END);
    *length = ftell(fp);
    fseek(fp, 0, SEEK_SET);

    uint8_t *buffer = (uint8_t *)malloc(*length);
    if (!buffer) {
        fclose(fp);
        return NULL;
    }

    fread(buffer, 1, *length, fp);
    fclose(fp);
    return buffer;
}

int write_file(const char *filename, const uint8_t *data, size_t length) {
    FILE *fp = fopen(filename, "wb");
    if (!fp) return -1;

    fwrite(data, 1, length, fp);
    fclose(fp);
    return 0;
}

int16_t *load_wav_pcm16(const char *filename, size_t *sample_count, uint32_t *sample_rate, uint8_t *channels) {
    SF_INFO sfinfo;
    memset(&sfinfo, 0, sizeof(sfinfo));
    SNDFILE *sndfile = sf_open(filename, SFM_READ, &sfinfo);
    if (!sndfile) return NULL;

    *sample_count = sfinfo.frames;
    *sample_rate = sfinfo.samplerate;
    *channels = sfinfo.channels;

    int16_t *buffer = malloc(sizeof(int16_t) * (*sample_count) * (*channels));
    if (!buffer) {
        sf_close(sndfile);
        return NULL;
    }

    sf_read_short(sndfile, buffer, (*sample_count) * (*channels));
    sf_close(sndfile);
    return buffer;
}

int save_pcm16_as_wav(const char *filename, const int16_t *samples, size_t sample_count, uint32_t sample_rate, uint8_t channels) {
    SF_INFO sfinfo;
    memset(&sfinfo, 0, sizeof(sfinfo));
    sfinfo.samplerate = sample_rate;
    sfinfo.frames = sample_count;
    sfinfo.channels = channels;
    sfinfo.format = SF_FORMAT_WAV | SF_FORMAT_PCM_16;

    SNDFILE *sndfile = sf_open(filename, SFM_WRITE, &sfinfo);
    if (!sndfile) return -1;

    sf_write_short(sndfile, samples, sample_count * channels);
    sf_close(sndfile);
    return 0;
}

void generate_output_filename(const char *input, const char *ext, char *output, size_t max_len) {
    const char *basename = strrchr(input, '/');
    if (!basename) basename = input;
    else basename++;

    const char *dot = strrchr(basename, '.');
    size_t len = dot ? (size_t)(dot - basename) : strlen(basename);
    if (len + strlen(ext) + 2 > max_len) return;

    strncpy(output, basename, len);
    output[len] = '\0';
    strcat(output, ".");
    strcat(output, ext);
}

// Convert 16-bit PCM samples to 12-bit Akai-style packed format
int akai_convert_16bit_to_12bit(const int16_t *input, int input_len, uint8_t *output, int output_max_len) {
    if (!input || !output || input_len <= 0 || output_max_len <= 0) return -1;

    int out_index = 0;
    for (int i = 0; i < input_len && out_index + 1 < output_max_len; ++i) {
        int16_t sample = input[i];
        uint16_t shifted = (sample + 32768) >> 4; // Convert to unsigned, then shift to 12-bit

        output[out_index++] = (shifted >> 4) & 0xFF;         // High byte
        output[out_index++] = (shifted & 0x0F) << 4;         // Low nibble
    }

    return out_index; // number of bytes written
}

// Convert 12-bit Akai-style packed format to 16-bit PCM samples
int akai_convert_12bit_to_16bit(const uint8_t *input, int input_len, int16_t *output, int output_max_len) {
    if (!input || !output || input_len <= 1 || output_max_len <= 0) return -1;

    int out_index = 0;
    for (int i = 0; i + 1 < input_len && out_index < output_max_len; i += 2) {
        uint16_t combined = ((input[i] << 4) | (input[i + 1] >> 4)) & 0x0FFF;
        output[out_index++] = ((int16_t)combined << 4) - 32768;
    }

    return out_index; // number of samples written
}


