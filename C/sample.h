#ifndef SAMPLE_H
#define SAMPLE_H

#include "akai_constants.h"  // Required for AKAI_NAME_LEN

typedef struct sample_s {
    char name[AKAI_NAME_LEN];
    int rate;
    int bits;
    int channels;
    unsigned int length;
    void* data;
} sample_t;

#endif /* SAMPLE_H */
