#ifndef AKAIUTIL_TAR_H
#define AKAIUTIL_TAR_H

#include <stdint.h>
#include <stddef.h>
#include "akai_disk.h"  // ← This is now the *only* source of disk_t

#ifdef __cplusplus
extern "C" {
#endif

int akai_parse_disk_image(const uint8_t *buffer, size_t length, disk_t *disk);
void akai_free_disk(disk_t *disk);
int akai_validate_disk(const disk_t *disk);
int akai_build_disk_image(const disk_t *disk, uint8_t *buffer, size_t max_length);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_TAR_H
