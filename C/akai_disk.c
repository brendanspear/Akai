
//  akai_disk.c
//  AkaiSConvert
//
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Updated by Brendan Spear under GNU GPL v3.0
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include "akai_disk.h"
#include "akaiutil_tar.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

disk_t *create_akai_disk(AkaiModel model) {
    disk_t *disk = (disk_t *)malloc(sizeof(disk_t));
    if (!disk) return NULL;
    memset(disk, 0, sizeof(disk_t));
    strncpy(disk->label, "AKAI_DISK", sizeof(disk->label) - 1);
    disk->model = model;
    disk->part_count = 0;
    return disk;
}

void free_disk(disk_t *disk) {
    if (disk) {
        free(disk);
    }
}

int add_sample_to_disk(disk_t *disk, const sample_t *sample, AkaiModel model) {
    if (!disk || !sample) return 0;
    if (disk->part_count >= MAX_PARTS) return 0;

    snprintf(disk->parts[disk->part_count].name, sizeof(disk->parts[disk->part_count].name), "%s", sample->name);
    disk->parts[disk->part_count].start_sector = (uint32_t)(disk->part_count * 100);
    disk->parts[disk->part_count].sector_count = 100;
    disk->part_count++;
    return 1;
}

int write_akai_disk_to_file(const disk_t *disk, const char *filename) {
    if (!disk || !filename) return 0;

    uint8_t buffer[4096];
    int written = akai_build_disk_image(disk, buffer, sizeof(buffer));
    if (written <= 0) return 0;

    FILE *fp = fopen(filename, "wb");
    if (!fp) return 0;
    fwrite(buffer, 1, written, fp);
    fclose(fp);
    return 1;
}
