
#ifndef SAMPLE_H
#define SAMPLE_H

#include <stdint.h>
#include <stddef.h>

#define AKAI_NAME_LEN 64

typedef struct sample_s {
    char name[AKAI_NAME_LEN];
    uint32_t rate;
    uint8_t bits;
    uint8_t channels;
    size_t length;
    void *data;
} sample_t;

sample_t *create_sample_from_pcm(const int16_t *pcm, size_t length, uint32_t rate, uint8_t channels, uint8_t bits);

#endif /* SAMPLE_H */
