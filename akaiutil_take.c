#include "akaiutil_take.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define SILENCE_THRESHOLD 200 // Amplitude threshold for silence detection

int akai_split_sample(const int16_t *input, size_t length, sample_t *out) {
    if (!input || !out) return -1;

    out->total_length = (uint32_t)length;
    out->sample_rate = 44100; // Default fallback
    out->channels = 1;
    out->bit_depth = 16;
    out->parts = NULL;
    strncpy(out->name, "SplitSample", sizeof(out->name));

    // Create a single segment for now (future logic can segment intelligently)
    part_t *segment = (part_t *)malloc(sizeof(part_t));
    if (!segment) return -1;

    segment->offset = 0;
    segment->length = (uint32_t)length;
    strncpy(segment->name, "FullSample", sizeof(segment->name));
    segment->next = NULL;

    out->parts = segment;
    return 0;
}

void akai_free_sample(sample_t *sample) {
    if (!sample) return;

    part_t *part = sample->parts;
    while (part) {
        part_t *next = part->next;
        free(part);
        part = next;
    }
    sample->parts = NULL;
}

int akai_trim_silence(int16_t *buffer, size_t *length) {
    if (!buffer || !length || *length == 0) return -1;

    size_t start = 0;
    size_t end = *length - 1;

    // Find first non-silent sample
    while (start < *length && abs(buffer[start]) < SILENCE_THRESHOLD)
        ++start;

    // Find last non-silent sample
    while (end > start && abs(buffer[end]) < SILENCE_THRESHOLD)
        --end;

    size_t new_length = end - start + 1;
    if (start > 0 && new_length > 0) {
        memmove(buffer, buffer + start, new_length * sizeof(int16_t));
    }

    *length = new_length;
    return 0;
}

int akai_add_silence(int16_t *buffer, size_t *length, size_t max_length, uint32_t milliseconds, uint32_t sample_rate) {
    if (!buffer || !length || sample_rate == 0) return -1;

    size_t extra_samples = (milliseconds * sample_rate) / 1000;
    if (*length + extra_samples > max_length) return -1;

    memset(buffer + *length, 0, extra_samples * sizeof(int16_t));
    *length += extra_samples;
    return 0;
}
