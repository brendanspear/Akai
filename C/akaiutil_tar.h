//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_TAR_H
#define AKAIUTIL_TAR_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_PARTS 64

// Partition structure
typedef struct {
    char name[32];
    uint32_t start_sector;
    uint32_t sector_count;
} part_t;

// Disk structure
typedef struct {
    char label[32];
    part_t parts[MAX_PARTS];
    size_t part_count;
} disk_t;

// Function declarations
int akai_parse_disk_image(const uint8_t *buffer, size_t length, disk_t *disk);
void akai_free_disk(disk_t *disk);
int akai_validate_disk(const disk_t *disk);
int akai_build_disk_image(const disk_t *disk, uint8_t *buffer, size_t max_length);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_TAR_H
