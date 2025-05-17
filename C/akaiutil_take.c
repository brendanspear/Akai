//
//  akaiutil_take.c
//  AkaiSConvert
//

#include "commoninclude.h"
#include "akaiutil_take.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void manipulate_sample(sample_t *sample) {
    strncpy(sample->name, "Updated", sizeof(sample->name));
    sample->rate = 44100;
    sample->bits = 16;
    sample->channels = 2;
    sample->length = 1024;
    sample->data = (uint8_t *)malloc(sample->length);
    memset(sample->data, 0, sample->length);
}
