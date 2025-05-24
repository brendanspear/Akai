
//  akai_disk.h
//  AkaiSConvert
//
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Updated by Brendan Spear under GNU GPL v3.0
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//
#ifndef AKAI_DISK_H
#define AKAI_DISK_H

#include <stdint.h>
#include <stddef.h>
#include "sample.h"
#include "akai_model.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_PARTS 64

typedef struct {
    char name[32];
    uint32_t start_sector;
    uint32_t sector_count;
} part_t;

typedef struct {
    char label[32];
    part_t parts[MAX_PARTS];
    size_t part_count;
    AkaiModel model;
} disk_t;

// Disk management API
disk_t *create_akai_disk(AkaiModel model);
void free_disk(disk_t *disk);
int add_sample_to_disk(disk_t *disk, const sample_t *sample, AkaiModel model);
int write_akai_disk_to_file(const disk_t *disk, const char *filename);

#ifdef __cplusplus
}
#endif

#endif /* AKAI_DISK_H */
